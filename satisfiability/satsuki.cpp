// satsuki 1.2
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include <sstream>
#include <fstream>
#include <string>
#include <ctime>
#include <csignal>
#include <cmath>


typedef unsigned int uint;


const uint BUFFSIZE=12; //expected number of average literals per clause
const uint BLOCK_SIZE = 256*1024*32; //32 MB for a 4B variable
const uint CONFLICTS_PER_RESTART = 1500; // restart after ... conflicts

uint	g_comp_var = 0; //an undefined variable which is in the same comp.
int*	g_watched_lits;

// statistics
uint	decisions=0;
uint	conflicts=0;
uint	restarts=0;
// statistics end



enum Tristate
{
	False=0,
	True=2,
	Undef
};

enum Activity
{
	ACTIVE,
	INACTIVE
};

const Tristate FIRST = True;
const Tristate SECOND = False;

/*
	pos 0: number of unsatisfied clauses
	pos 1 to |v|: values of variables //tristate
	pos |v|+1 to |v|+1+2*|c|: two watched literals, zero for void
*/
struct State
{
	char*		info;//size 1+f->num_var+num_clauses
	// statictics:
	uint*		var_pos_neg_count; //size = 2*|v|+1 <-starting pos = 1, pos 0 = unsat clauses
};

/*
	variables with values set but not yet processed
*/
struct VariableQueue
{
	uint*	queue;
	uint	size; //allocated
	uint	top_index;
};

struct Formula
{
	uint		num_variables;

	uint*		pos_occurences_index; // array of size num_variables+2
	uint*		neg_occurences_index; // array of size num_variables+2
	// +1 for the last virtual variable +1 for we start at 1

	uint*		clauses_variables_index; // number of clauses + 1
	uint		num_clauses_variables_index; //total number of clauses

	uint*		pos_occurences;
	uint*		neg_occurences;
	int*		clauses_variables;
};
bool CheckResult(const Formula*f, const State*s)
{
	bool sat_clause;
	int k;
	for(uint i = 0; i < f->num_clauses_variables_index; i++)
	{
		sat_clause = false;
		for(uint j = f->clauses_variables_index[i]; j < f->clauses_variables_index[i+1]; j++)
		{
			k = f->clauses_variables[j];
			if( k > 0)
				if(s->info[k] == True)
					sat_clause = true;
			if( k < 0)
				if(s->info[-k] == False)
					sat_clause = true;
		}
		if(sat_clause == false)
		{
			printf("%d,", i);
			return false;
		}
	}
	return true;
}
void Write(const Formula*f, const State*s, const VariableQueue*)
{
	for(uint i = 1; i < f->num_variables+1; i++)
	{
		if(s->info[i] == True)
			printf("%d ", i);
		else
			printf("-%d ", i);
	}
	puts("0\n");
	/*
	puts("watched literals:");
	for(uint i = 0; i < f->num_clauses_variables_index; i++)
	{
		printf("cl %3d w1: %3d w2: %3d\n", i, s->data[1+f->num_variables+2*i], s->data[1+f->num_variables+2*i+1]);
	}
	/*
	puts("statistics:");
	for(uint i=1; i<f->num_variables+1; i++)
	{
		printf("var %d positive: %d negative %d\n",i, s->var_pos_neg_count[i],s->var_pos_neg_count[f->num_variables+i]);
	}
	/**/
}

/*
	set watched literals to 0
	update variable occurence statistics
	begin and end are pointers to the clauses
*/
inline void TurnOffClauses(const Formula* f, uint* begin, uint* end, State* s, VariableQueue* v)
{
	uint vars = f->num_variables;
	int *a, *b;
	uint *c;
	while(begin != end)
	{
		if (s->info[1+vars+(*begin)] == INACTIVE)// is the clause active? is watched literal 1 nonzero?
		{
			begin++;
			continue; 
		}
		s->var_pos_neg_count[0]--;
		s->info[1+vars+(*begin)] = INACTIVE; //deactivate clause
		// a, b : pointers to the literals
		a = f->clauses_variables + f->clauses_variables_index[*begin];
		b = f->clauses_variables + f->clauses_variables_index[*begin +1];
		while(a != b)
		{
			if(s->info[abs(*a)] == Undef)
			{
				if(*a > 0)
				{
					c = &(s->var_pos_neg_count[*a]);
					(*c)--;
					if(*c == 0) // no more positive occurences
					{
						s->info[*a] = False;
						v->queue[v->top_index] = *a;
						v->top_index++;
					}
				}
				else
				{
					c = &(s->var_pos_neg_count[vars-*a]); //[vars + abs(a)]
					(*c)--;
					if(*c == 0) // no more negative occurences
					{
						s->info[-*a] = True;
						v->queue[v->top_index] = -(*a);
						v->top_index++;
					}
				}
			}
			a++;
		}
		begin++;
	}
}

/*
	test if watched literal down -> find another or find unit
	can discover that a clause is unsatisfiable <- return value
*/
inline bool TestUnit(const Formula*f, uint* begin, const uint* end, State* s, VariableQueue* v, uint var)
{
	uint num_var = f->num_variables;
	uint pos, ai, aw1, aw2;
	int *w1,*w2; //the watched literals
	int* i;
	while(begin != end)
	{
		pos = 2*(*begin);
		w1 = g_watched_lits + pos; //ptr arithm.
		w2 = g_watched_lits + pos + 1;
		aw1 = abs(*w1);
		aw2 = abs(*w2);

		if(s->info[num_var+1+(*begin)] == INACTIVE) //continues if this clause is inactive
		{
			begin++;
			continue;
		}
		if(aw1 != var && aw2 != var)
		{
			g_comp_var = aw1;
			begin++;
			continue;
		}
		// watched literal down, find an undef variable in this clause
		i = &(f->clauses_variables[f->clauses_variables_index[*begin]]);
		while(i < &(f->clauses_variables[f->clauses_variables_index[1+*begin]]))
		{
			ai = abs(*i);
			if(s->info[ai] != Undef)
			{
				// this clause is already satisfied but has not been turned off yet.
				// without this the program could make bad implications
				// if ( (*i > 0 && s->data[*i] == True) || (*i < 0 && s->data[-(*i)] == False) )
				if (((*i) * (s->info[ai]-1)) > 0) //using: True = 2, False = 0
					goto endofwhile;
			}			
			// if(s->data[ai] == Undef && ai != aw1 && ai != aw2)
			else if (ai != aw1 && ai != aw2)
			{
				if(aw1 == var) // the first watched literal was var
					*w1 = *i;
				else			// the second watched literal was var
					*w2 = *i;
				g_comp_var = ai;
				goto endofwhile;
			}
			i++;
		}
		// we could not find a new watched literal -> this clause is unit
		s->info[num_var+1+(*begin)] = INACTIVE;
		s->var_pos_neg_count[0]--; ////////////////////////////////////////////////////////////////////////////////////////////
		if(aw1 != var)
			i = w1;
		else 
			i = w2;
		if(*i>0)
		{
			if(s->info[*i] == False) //contradiction
				return false;
			if(s->info[*i] == Undef)
			{
				v->queue[v->top_index] = *i;
				v->top_index++;
			}
			s->info[*i] = True;
		}
		else
		{
			if(s->info[-(*i)] == True) //contradiction
				return false;
			if(s->info[-(*i)] == Undef)
			{
				v->queue[v->top_index] = -(*i);
				v->top_index++;
			}
			s->info[-(*i)] = False;
		}

endofwhile:
		begin++;
	}
	return true;
}



void InitialClearPures(const Formula* f, State* s)
{
	// Find the pure variables
	VariableQueue* myq = new VariableQueue;
	myq->queue = new uint[f->num_variables];
	myq->size = f->num_variables;
	myq->top_index = 0;
	uint num_var = f->num_variables;

	for(uint i=1; i < num_var+1; i++)
	{
		if(s->info[i] != Undef)
			continue;
		if(s->var_pos_neg_count[i] == 0)
		{
			//only negative occurences
			s->info[i] = False;
			myq->queue[myq->top_index] = i;
			myq->top_index++;
		}
		else if (s->var_pos_neg_count[num_var+i] == 0)
		{
			//only positive occurences
			s->info[i] = True;
			myq->queue[myq->top_index] = i;
			myq->top_index++;
		}
	}

	// process pure variables, new pures can appear
	uint var;
	while(myq->top_index > 0)
	{
		myq->top_index--;
		var = myq->queue[myq->top_index];
		if(s->info[var] == True)
		{
			TurnOffClauses(f, f->pos_occurences + f->pos_occurences_index[var], 
							f->pos_occurences + f->pos_occurences_index[var+1], 
							s, myq);
			// no active negative occurences
		}
		else // s->data[var] == False
		{
			TurnOffClauses(f, f->neg_occurences + f->neg_occurences_index[var],
							f->neg_occurences + f->neg_occurences_index[var+1],
							s, myq);
			// no active positive occurences
		}
	}
	delete[] myq->queue;
	delete myq;
}
/*
	Perform actions implied by defining a value to the variables in the variable queue
	returns false if the formula is unsatisfied else returns true
*/
inline bool ProcessSubstitution(const Formula*f, State*s, VariableQueue*v)
{
	uint var;
	bool sat = true;
	while (v->top_index > 0 && sat)
	{
		v->top_index--;
		var = v->queue[v->top_index];
		if(s->info[var] == True)
		{
			//turn off positive occurences and test unitness in negative occurences
			TurnOffClauses(f, f->pos_occurences + f->pos_occurences_index[var], 
							f->pos_occurences + f->pos_occurences_index[var+1], 
							s, v);
			sat = TestUnit(f, f->neg_occurences + f->neg_occurences_index[var],
							f->neg_occurences + f->neg_occurences_index[var+1],
							s,v,var);
		}
		else // s->info[var] == False
		{
			//turn off negative occurences and test unitness in positive occurences
			TurnOffClauses(f, f->neg_occurences + f->neg_occurences_index[var], 
							f->neg_occurences + f->neg_occurences_index[var+1], 
							s, v);
			sat = TestUnit(f, f->pos_occurences + f->pos_occurences_index[var],
							f->pos_occurences + f->pos_occurences_index[var+1],
							s, v, var);
		}
	}
	return sat;
}
void SetInitialState(const Formula* f, State* s, VariableQueue* v)
{
	int nv = f->num_variables;

	s->info = new char[1 + nv + f->num_clauses_variables_index];

	s->var_pos_neg_count[0] = f->num_clauses_variables_index;

	for(int i=1; i < nv+1; i++)
		s->info[i] = Undef;

	// init the variable queue
	v->size = nv;
	v->top_index = 0;
	v->queue = new uint[v->size];

	//select the initial two watched literals
	// now: the first two literals
	for(uint i=0; i<f->num_clauses_variables_index; i++)
	{
		if (f->clauses_variables_index[i+1] - f->clauses_variables_index[i] < 2)
		{	// only one literal in the clause
			s->var_pos_neg_count[0]--; //decrease the number of unsat clauses
			int x = f->clauses_variables[f->clauses_variables_index[i]];
			if (x>0)
			{
				s->info[x] = True;
				v->queue[v->top_index] = x;
				v->top_index++;
				// one pos occurence down, but the value is already set, we do not care
				// s->var_pos_neg_count[x]--;
			}
			else
			{
				s->info[-x] = False;
				v->queue[v->top_index] = -x;
				v->top_index++;
				// one neg occurence down, but the value is already set, we do not care
				// s->var_pos_neg_count[x+f->num_variables]--;
			}
			s->info[1+nv+i] = INACTIVE;
			//s->data[1+nv+l+1] = 0; - not necessary
		}
		else
		{
			s->info[1+nv+i] = ACTIVE;
			// select the first 2 to be watched
			int l = 2*i;
			g_watched_lits[l] = f->clauses_variables[f->clauses_variables_index[i]];
			g_watched_lits[l+1] = f->clauses_variables[1 + f->clauses_variables_index[i]];
		}
	}
}

bool ReadFromFile(char* filename, Formula* f, State* s)
{
	std::ifstream file;
	file.open(filename, std::ios::in);
	
	if(!file.good())
		return false;

	std::string line;
	while(1)
	{
		std::getline(file, line);
		std::string dummy;
		if(line[0]=='c')
			continue;
		if(line[0]=='p') // problem definition line
		{
			std::stringstream iss(line);
			iss >> dummy; //ignore the "p"
			iss >> dummy; //ignore the "cnf"
			iss >> f->num_variables;
			iss >> f->num_clauses_variables_index;
			break;
		}		
	}
	f->pos_occurences_index = new uint[f->num_variables+2];
	f->neg_occurences_index = new uint[f->num_variables+2];
	f->clauses_variables_index = new uint[f->num_clauses_variables_index+1];

	//tmp arrays
	uint* num_pos_occ = new uint[f->num_variables+1];
	memset(num_pos_occ, 0, sizeof(uint)*(1+f->num_variables));
	uint* num_neg_occ = new uint[f->num_variables+1];
	memset(num_neg_occ, 0, sizeof(uint)*(1+f->num_variables));

	int* tmp_clauses_vars = new int[f->num_clauses_variables_index * BUFFSIZE];
	uint  position = 0;

	int variable;
	uint i;
	for(i=0; i < f->num_clauses_variables_index; i++)
	{
		f->clauses_variables_index[i]=position;
		//read line - formula
		while(1)
		{
			file >> variable;
			if(variable == 0)
				break;
			if(variable > 0)
				num_pos_occ[variable]++;
			else
				num_neg_occ[-variable]++;

			tmp_clauses_vars[position]=variable;
			position++;
		}
	}
	f->clauses_variables_index[i]=position;
	f->clauses_variables = new int[position];
	memcpy(f->clauses_variables, tmp_clauses_vars, sizeof(int)*position);
	delete [] tmp_clauses_vars;

	uint sum_pos = 0;
	uint sum_neg = 0;

	// set the statistics
	s->var_pos_neg_count = new uint[2 * f->num_variables + 1];
	memcpy(s->var_pos_neg_count+1, num_pos_occ+1, sizeof(uint)*f->num_variables);
	memcpy(s->var_pos_neg_count+1+f->num_variables, num_neg_occ+1, sizeof(uint)*f->num_variables);

	uint j = 1;
	while(j < f->num_variables+1)
	{
		f->pos_occurences_index[j] = sum_pos;
		f->neg_occurences_index[j] = sum_neg;

		sum_pos += num_pos_occ[j];
		sum_neg += num_neg_occ[j];

		num_pos_occ[j] = 0;
		num_neg_occ[j] = 0;
		j++;
	}
	f->pos_occurences_index[j] = sum_pos;
	f->neg_occurences_index[j] = sum_neg;
	// num_pos_occ and num_neg_occ changes meaning to number of actually set occurences
	f->pos_occurences = new uint[sum_pos];
	f->neg_occurences = new uint[sum_neg];

	int l;
	for(uint j = 0; j < f->num_clauses_variables_index; ++j)
	{
		//tu musis prechadzat jednotlive klauzule a u premennych nastavovat cislo tejto klauzule
		for(uint k = f->clauses_variables_index[j]; k < f->clauses_variables_index[j+1]; ++k)
		{
			l = f->clauses_variables[k];
			assert(l != 0);
			if(l > 0)
			{
				f->pos_occurences[f->pos_occurences_index[l]+num_pos_occ[l]] = j;
				num_pos_occ[l]++;
			}
			else
			{
				l = -l;
				f->neg_occurences[f->neg_occurences_index[l]+num_neg_occ[l]] = j;
				num_neg_occ[l]++;
			}
		}
	}

	delete [] num_pos_occ;
	delete [] num_neg_occ;

	return true;
}


inline uint SelectVariable(uint max, State* s, uint first = 1)
{
	// first undefined, if there is no undefined, it will fall
	while(s->info[first] != Undef)
	{
		first++;
		if (first >= max)
			first = 1;
	}
	return first;
	/*
	// number negative occurences
	uint i = 1;
	uint t, max = 0, maxi;
	for(i = 1; i <= vars; i++)
	{
		if(s->data[i] != Undef)
			continue;
		t = s->var_pos_neg_count[i+vars]; //+s->var_pos_neg_count[i+vars];
		if(t > max)
		{
			max = t;
			maxi = i;
		}		
	}
	return maxi;
	/**/
}
bool Sat(const Formula* f, State* s, VariableQueue* v)
{
	uint dataindexer = (1 + f->num_variables + f->num_clauses_variables_index);
	uint statsindexer = (1 + 2*f->num_variables);
	int array_size;

	// dataindexer > statsindexer - expected
	array_size = f->num_variables;
	uint block = dataindexer * sizeof(char) > statsindexer*sizeof(uint) ? dataindexer*sizeof(char) : statsindexer*sizeof(uint);

	uint div = f->num_variables;
	if (block * array_size > BLOCK_SIZE)
	{
		div = BLOCK_SIZE / block;
		if (div == 0) //in case of an extremly big formula
			div = 1;
		array_size = div;
	}

	char ** dataconts = new char*[f->num_variables/div];
	uint ** statsconts = new uint*[f->num_variables/div];

	// up to pos mem_alloc_level index dataconts and statsconts are allocated
	int mem_alloc_level = 0;

	dataconts[mem_alloc_level] = new char[array_size*dataindexer];
	statsconts[mem_alloc_level] = new uint[array_size*statsindexer];

	// actual used index.
	int mem_level = 0;

	char* datacont = dataconts[mem_level];
	uint* statscont = statsconts[mem_level];
	
	int current_state_num = 0;
	State* current_state = new State;
	memcpy(datacont, s->info, dataindexer*sizeof(char));
	memcpy(statscont, s->var_pos_neg_count, statsindexer*sizeof(uint));

	current_state->info = datacont + current_state_num * dataindexer;
	current_state->var_pos_neg_count = statscont + current_state_num * statsindexer;

	uint* varq = new uint[f->num_variables+1];//queue the top element indexed by varq_index
	uint varq_index = 0;

	uint var = 0;
	//Write(f,s,v);
	while(current_state->var_pos_neg_count[0] > 0)
	{
		if (var == 0) //going forward first
		{
			decisions++;
			if(conflicts / (restarts+1) > CONFLICTS_PER_RESTART)
			{
				//restarting
				restarts++;
				varq_index = current_state_num = mem_level = 0;
				// find the state from where we restart
				while(current_state->info[varq[varq_index]] == SECOND)
				{
					varq_index++;
					current_state_num++;
					if(current_state_num >= array_size)
					{
						mem_level++;
						current_state_num = 0;
					}
				}/**/
				datacont = dataconts[mem_level];
				statscont = statsconts[mem_level];
				current_state->info = datacont + current_state_num*dataindexer;
				current_state->var_pos_neg_count = statscont + current_state_num*statsindexer;

				// select a variable
				var = SelectVariable(f->num_variables, current_state, 1+(rand()%f->num_variables));
			}
			else
			{ 
				// not restarting, variable selection
				if (g_comp_var != 0 && current_state->info[g_comp_var] == Undef)
				{				
					var = g_comp_var;// we remain in the same component
					g_comp_var = 0;
				}
				else
					var = SelectVariable(f->num_variables, current_state);
			}

			// copy state
			varq[varq_index] = var;
			varq_index++;
			current_state_num++;

			if (current_state_num >= array_size)// new memory needed
			{
				mem_level++;
				if  (mem_level > mem_alloc_level)
				{
					mem_alloc_level++;
					dataconts[mem_alloc_level] = new char[array_size*dataindexer];
					statsconts[mem_alloc_level] = new uint[array_size*statsindexer];
				}
				datacont = dataconts[mem_level];
				statscont = statsconts[mem_level];
				current_state_num = 0;
				memcpy(datacont, dataconts[mem_level-1]+(array_size-1)*dataindexer, dataindexer*sizeof(char));
				memcpy(statscont, statsconts[mem_level-1]+(array_size-1)*statsindexer, statsindexer*sizeof(uint));
			}
			else
			{
				memcpy(datacont+(current_state_num)*dataindexer, datacont+(current_state_num-1)*dataindexer, dataindexer*sizeof(char));
				memcpy(statscont+(current_state_num)*statsindexer, statscont+(current_state_num-1)*statsindexer, statsindexer*sizeof(uint));
			}
			current_state->info = datacont + current_state_num * dataindexer;
			current_state->var_pos_neg_count = statscont + current_state_num * statsindexer;

			current_state->info[var] = FIRST;
		}
		v->queue[0] = var;
		v->top_index = 1;

		if(ProcessSubstitution(f, current_state, v))
		{
			// add to the queue
			var = 0;
			continue;
		}
		else
		{
			conflicts++;
			if (current_state->info[var] == FIRST)
			{
				// return to previous state
				if(current_state_num == 0) // previous state in the previous level
				{
					memcpy(datacont, dataconts[mem_level-1]+(array_size-1)*dataindexer, dataindexer*sizeof(char));
					memcpy(statscont, statsconts[mem_level-1]+(array_size-1)*statsindexer, statsindexer*sizeof(uint));
				}
				else
				{
					memcpy(datacont+(current_state_num)*dataindexer, datacont+(current_state_num-1)*dataindexer, dataindexer*sizeof(char));
					memcpy(statscont+(current_state_num)*statsindexer, statscont+(current_state_num-1)*statsindexer, statsindexer*sizeof(uint));
				}
				current_state->info[var] = SECOND;
				continue;
			}
			//else
			/*if (conflicts / (restarts+1) > CONFLICTS_PER_RESTART)
			{
				restarts++;
				varq_index = current_state_num = mem_level = 0;
				// find the state from where we restart
				while(current_state->info[varq[varq_index]] == SECOND)
				{
					varq_index++;
					current_state_num++;
					if(current_state_num >= array_size)
					{
						mem_level++;
						current_state_num = 0;
					}
				}
				datacont = dataconts[mem_level];
				statscont = statsconts[mem_level];
				current_state->info = datacont + current_state_num*dataindexer;
				current_state->var_pos_neg_count = statscont + current_state_num*statsindexer;

				// select a variable
				srand(g_comp_var);
				var = SelectVariable(f->num_variables, current_state, 1+(rand()%f->num_variables));
				current_state->info[var] = FIRST;
				continue;
			}/**/
			current_state_num--;
			varq_index--;
			while(mem_level >= 0)
			{
				while(current_state_num >= 0 && current_state->info[varq[varq_index]] == SECOND)
				{
					varq_index--;
					current_state_num--;
				}
				if (current_state_num < 0)
				{
					mem_level--;
					if(mem_level < 0)
						return false;
					datacont = dataconts[mem_level];
					statscont = statsconts[mem_level];
					current_state_num = array_size - 1;
				}
				else
					break;
			}

			var = varq[varq_index];

			current_state->info = datacont + current_state_num*dataindexer;
			current_state->var_pos_neg_count = statscont + current_state_num*statsindexer;

			current_state->info[var] = SECOND;
		}

		/* Pseudocode
		if var = 0 
			copy state
			select var
			add var to vars
			var = true

		if (processSubstiotion)
			current state num ++
			var = 0
			continue
		else
			if var == true
				var = false
				restore status
				continue
			else // var == false
				if (current state num < 1) return false
				current state num --
				restore status
				var = take top vars
				var = false	
		*/
	}

	memcpy(s->info, current_state->info, dataindexer*sizeof(char));
	memcpy(s->var_pos_neg_count, current_state->var_pos_neg_count, statsindexer*sizeof(uint));

	/* Time is precious ???
	delete[] varq;
	delete[] datacont;
	delete[] statscont;
	/**/
	return true;
}

clock_t start, end;

void write_end(void)
{
	printf("c time: %f s\n", (end-start)/(float)CLOCKS_PER_SEC);
	printf("c decisions: %d, conflicts: %d, restarts: %d\n", decisions, conflicts, restarts);
}

void killed(int)
{
	end = clock();
	puts("c Program terminated by the user");
	write_end();
	exit(0);
}

int main(int argv, char** argc)
{
	if(argv < 2)
	{
		puts("Usage: satsuki filename.cnf");
		return 0;
	}
	start = clock();
	signal(SIGINT, killed);

	Formula *f = new Formula;
	State *s = new State;

	if( ReadFromFile(argc[1], f, s) == false)
	{
		puts("File not Opened");
		exit(1);
	}
	puts("c Satsuki solver version 1.2");
	VariableQueue* v = new VariableQueue;
	g_watched_lits = new int[2*f->num_clauses_variables_index];
	srand(f->num_variables);
	
	SetInitialState(f, s, v);//WORKS

	InitialClearPures(f, s);//WORKS
	
	if (ProcessSubstitution(f,s,v) == false)
	{
		puts("UNSATISFIABLE");
		end = clock();
		write_end();
		return 0;
	}
	if (s->var_pos_neg_count[0] == 0)
	{
		// solved without decisions
		end = clock();
		Write(f,s,v);
		write_end();
		bool ok = CheckResult(f,s);
		if(ok) puts("c correct"); else puts("c incorrect");
		return 0;
	}

	if (Sat(f, s, v))
	{
		// output results
		end = clock();
		Write(f,s,v);
		write_end();
		bool ok = CheckResult(f,s);
		if(ok) puts("c correct"); else puts("c incorrect");
	}
	else
	{
		puts("UNSATISFIABLE");
		end = clock();
		write_end();
		// output unsat
	}
	return 0;
}
