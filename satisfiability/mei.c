// version 1.2
#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <time.h>
#include <signal.h>

enum Tristate
{
	UNDEF=0, //dont change
	TRUE=1,
	FALSE=2
} Tristate;

typedef enum bool
{
	false,
	true
} bool;

typedef struct Formula
{
	int		num_vars;
	int*	vars_pos_occurences_index; //of size num_vars
	int*	vars_pos_occurences;
	int*	vars_neg_occurences_index;
	int*	vars_neg_occurences;
	
	int		num_clauses;
	int*	clauses_variables_index; // of size num_clauses
	int*	clauses_variables;
} Formula;

/*
	pos 0: num of unsat clauses
	pos 1..num_vars : values true, false, undef
	pos num_vars+1 .. num_vars+1+num_clauses : number of active clasues
*/
typedef struct State
{
	int* varslits;
} State;

typedef struct VarQueue
{
	int*	queue;
	int		top;
} VarQueue;

#define BUFFSIZE 512000 // max characters per line in the input file
const int LITSPERCLAUSE = 12;
const int BLOCKLIMIT = 1024*1024*16; //16 MB
const int FIRST = TRUE;
const int SECOND = FALSE;
const char VISIT = 1;
const unsigned int CONFLICTS_TO_RESTART = 1500;

VarQueue g_vq; // global variable queue
int	g_clnum; // last recently visited clause
time_t start, end; // time
unsigned int decisions, conflicts, restarts; //statistics
char* visited_clauses;

void GetNumber(const char* buff, int* index, int* number)
{
	char k;
	int m = 1;
	*number = 0;
	k = buff[*index];
	while(!isdigit(k) && k != '-')
	{
		(*index)++;
		k = buff[*index];
	}
	if(k == '-')
	{
		m = -1;
		(*index)++;
	}
	while(isdigit(k = buff[*index]))
	{
		*number = (*number) * 10 + k - '0';
		(*index)++;
	}
	*number = m*(*number);
}

bool LoadFromFile(char* filename, Formula* f, State* s)
{
	FILE* inf = fopen(filename, "r");
	char buff[BUFFSIZE];
	int i, l, cls, num, lit;
	int sumpos, sumneg;
	int *p1, *p2;

	if(inf == NULL) //file not found
		return false;

	while(!feof(inf))
	{
		if (fgets(buff, BUFFSIZE, inf)) 
		{
			//no error occured
			if(buff[0]=='c') // comment
				continue;
			else
			if(buff[0]=='p') // problem definition line
			{
				i = 0;

				GetNumber(buff, &i, &(f->num_vars));
				GetNumber(buff, &i, &(f->num_clauses));
				break;
			} // end of p
		} // end of fgets
		else
			return false;
	}
	s->varslits = malloc(sizeof(int)*(f->num_clauses+f->num_vars+1));
	s->varslits[0] = f->num_clauses;
	memset(1+s->varslits, 0, sizeof(int)*f->num_vars);

	f->clauses_variables_index = malloc(sizeof(int)*f->num_clauses + 1);
	f->clauses_variables = malloc(sizeof(int)*f->num_clauses*LITSPERCLAUSE);

	// now used to count the occurences
	f->vars_neg_occurences_index = malloc(sizeof(int)*(f->num_vars + 2));
	f->vars_pos_occurences_index = malloc(sizeof(int)*(f->num_vars + 2));

	memset(f->vars_neg_occurences_index, 0, sizeof(int)*(f->num_vars+2));
	memset(f->vars_pos_occurences_index, 0, sizeof(int)*(f->num_vars+2));
	
	lit = 0;    //number of literals (in the whole formula)
	sumneg = 0; //number of neg literals
	sumpos = 0; //number of positive literals
	// read the claues
	f->clauses_variables_index[0] = 0;
	for (cls = 0; cls < f->num_clauses; cls++)
	{
		if(fgets(buff, BUFFSIZE, inf))
		{
			if(buff[0]=='c') //comment
			{
				cls--;
				continue;
			}
			i = 0; //index in the line
			l = 0; //number of literals in this clause
			GetNumber(buff, &i, &num);
			while(num != 0)
			{
				if(num>0)
				{
					f->vars_pos_occurences_index[num]++;
					sumpos++;
				}
				else
				{
					f->vars_neg_occurences_index[-num]++;
					sumneg++;
				}
				l++;
				f->clauses_variables[lit] = num;
				lit++;
				GetNumber(buff, &i, &num);
			}
			s->varslits[1 + f->num_vars + cls] = l;
			f->clauses_variables_index[cls + 1] = lit;
		}
	}
	// we are finished with this file
	fclose(inf);

	// downsize to the actual used size
	f->clauses_variables = realloc(f->clauses_variables, sizeof(int)*lit);

	f->vars_pos_occurences = malloc(sizeof(int)*sumpos);
	f->vars_neg_occurences = malloc(sizeof(int)*sumneg);

	sumpos = 0; //
	sumneg = 0; //
	// vars_..._occurences_index changes meaning.
	for(i = 1; i < f->num_vars+1; i++)
	{
		l = f->vars_pos_occurences_index[i];
		f->vars_pos_occurences_index[i] = sumpos;
		sumpos += l;

		l = f->vars_neg_occurences_index[i];
		f->vars_neg_occurences_index[i] = sumneg;
		sumneg += l;
	}
	f->vars_pos_occurences_index[i] = sumpos;
	f->vars_neg_occurences_index[i] = sumneg;

	p1 = malloc(sizeof(int)*(f->num_vars+1)); //number of actually set occurences
	p2 = malloc(sizeof(int)*(f->num_vars+1));
	memset(p1, 0, sizeof(int)*(f->num_vars+1));
	memset(p2, 0, sizeof(int)*(f->num_vars+1));

	for(cls = 0; cls < f->num_clauses; cls++)
	{
		for(l = f->clauses_variables_index[cls]; l < f->clauses_variables_index[cls+1]; l++)
		{
			num = f->clauses_variables[l];
			if(num > 0)
			{
				f->vars_pos_occurences[f->vars_pos_occurences_index[num] + p1[num]] = cls;
				p1[num]++;
			}
			else
			{
				num = -num;
				f->vars_neg_occurences[f->vars_neg_occurences_index[num] + p2[num]] = cls;
				p2[num]++;
			}
		}
	}

	free(p1);
	free(p2);
	return true;
}
void WriteResult(const Formula* f, const State * s)
{
	int i;
	for(i = 1; i <= f->num_vars; ++i)
		if(s->varslits[i] == TRUE)
			printf("%d ", i);
		else
			printf("-%d ", i);
	puts("");
}
void Contradiction(const Formula*f, const State* s)
{
	int c,i,l;
	bool sat;
	for(c = 0; c < f->num_clauses; c++)
	{
		sat = false;
		for(i = f->clauses_variables_index[c]; i < f->clauses_variables_index[c+1]; i++)
		{
			l = f->clauses_variables[i];
			if(l>0 && (s->varslits[l] == TRUE || s->varslits[l] == UNDEF))
				sat = true;
			if(l<0 && (s->varslits[-l] == FALSE || s->varslits[-l] == UNDEF))
				sat = true;
		}
		if(sat == false) 
		{
			printf("contradiction: %d bad\n", c);
			return;
		}
	}
	puts("no contradiction");
}

bool CheckResult(const Formula*f, const State * s)
{
	int c,i,l;
	bool sat;
	for(c = 0; c < f->num_clauses; c++)
	{
		sat = false;
		for(i = f->clauses_variables_index[c]; i < f->clauses_variables_index[c+1]; i++)
		{
			l = f->clauses_variables[i];
			if(l>0 && s->varslits[l] == TRUE)
				sat = true;
			if(l<0 && s->varslits[-l] == FALSE)
				sat = true;
		}
		if(sat == false) 
		{
			printf("clause: %d bad\n", c);
			return false;
		}
	}
	return true;
}
int SelectVariable(const Formula* f, const State* s)
{
	int i,lit,c;
	for(c = g_clnum; c < f->num_clauses; c++)
	{
		for(i = f->clauses_variables_index[c]; i < f->clauses_variables_index[c+1]; ++i)
		{
			lit = f->clauses_variables[i];
			lit = abs(lit);

			if(s->varslits[lit] == UNDEF)
				return lit;
		}
	}
	for(c = 0; c < g_clnum; c++)
	{
		for(i = f->clauses_variables_index[c]; i < f->clauses_variables_index[c+1]; ++i)
		{
			lit = f->clauses_variables[i];
			lit = abs(lit);

			if(s->varslits[lit] == UNDEF)
				return lit;
		}
	}

	// if it gets here, no undefined variable exists
	// return an invalid value.
	return -1;
}

// return false if this clause is false
bool UnitClause(const Formula* f, State* s, int clause)
{
	int lit=0, i;
	// find the last literal
	for(i = f->clauses_variables_index[clause]; i < f->clauses_variables_index[clause+1]; ++i)
	{
		lit = f->clauses_variables[i];
		
		if(lit>0)
		{
			if(s->varslits[lit] == TRUE) //this clause is already satisfied
				return true;
			if(s->varslits[lit] == UNDEF)
				break;
		}
		else
		{
			if(s->varslits[-lit] == FALSE)
				return true;
			if(s->varslits[-lit] == UNDEF)
				break;
		}
	}
	//if last literal not found -> contradiction
	if(i == f->clauses_variables_index[clause+1])
		return false;
	//last literal found, add to the variable queue
	if (lit > 0)
	{
		s->varslits[lit] = TRUE;
		g_vq.queue[g_vq.top] = lit;
		g_vq.top++;
	}
	else
	{
		lit = -lit;
		s->varslits[lit] = FALSE;
		g_vq.queue[g_vq.top] = lit;
		g_vq.top++;
	}
	return true;
}

bool ProcessSubstitution(const Formula*f, State*s, int var)
{
	int i,c; //clause
	int vars1 = f->num_vars+1;

	g_vq.queue[0] = var;
	g_vq.top = 1;

	while(g_vq.top > 0)
	{
		g_vq.top--;
		var = g_vq.queue[g_vq.top];

		if(s->varslits[var] == TRUE)
		{
			//turn off clauses with POSITIVE occurences
			for(i = f->vars_pos_occurences_index[var]; i < f->vars_pos_occurences_index[var+1]; i++)
			{
				c = f->vars_pos_occurences[i];
				visited_clauses[c] = VISIT;
				if (s->varslits[vars1 + c] > 0)
					s->varslits[0]--;
				s->varslits[vars1 + c] = 0;
			}

			//dec lits count in NEGATIVE occurences
			for(i = f->vars_neg_occurences_index[var]; i < f->vars_neg_occurences_index[var+1]; i++)
			{
				c = f->vars_neg_occurences[i];
				visited_clauses[c] = VISIT;
				if(s->varslits[c + vars1] == 0)
					continue;

				s->varslits[c + vars1]--;
				g_clnum = c; // set the global heuristic variable

				if(s->varslits[c + vars1] == 1)
				{
					if(false == UnitClause(f, s, c)) //modifies g_vq
						return false;
					s->varslits[0]--;
					s->varslits[vars1 + c] = 0;
				}
			}		
		}
		else
		{
			// var == false
			//turn off clauses with NEGATIVE occurences
			for(i = f->vars_neg_occurences_index[var]; i < f->vars_neg_occurences_index[var+1]; i++)
			{
				c = f->vars_neg_occurences[i];
				visited_clauses[c] = VISIT;

				if (s->varslits[vars1 + c] > 0)
					s->varslits[0]--;
				s->varslits[vars1 + c] = 0;
			}

			//decrease lits count in POSITIVE occurences
			for(i = f->vars_pos_occurences_index[var]; i < f->vars_pos_occurences_index[var+1]; i++)
			{
				c = f->vars_pos_occurences[i];
				visited_clauses[c] = VISIT;

				if(s->varslits[c + vars1] == 0)
					continue;

				s->varslits[c + vars1]--;
				g_clnum = c; // set the global heuristic variable

				if(s->varslits[c + vars1] == 1)
				{
					if(false == UnitClause(f, s, c)) //modifies g_vq
						return false;
					s->varslits[0]--;
					s->varslits[vars1 + c] = 0;
				}
			}
		}
	} // end of while g_vq.top >= 0
	return true;
}

bool Sat(Formula* f, State* s)
{
	// state containers
	int ** states_conts;
	int BLOCKSIZE, BLOCKS_PER_CONT;
	int allocated_cont_num, state_num, CONTS_NUM;
	int index_cont, index_state;

	// solving
	int var;
	VarQueue localvq;

	BLOCKSIZE = f->num_vars + f->num_clauses + 1;
	BLOCKS_PER_CONT = f->num_vars;

	if(BLOCKSIZE * (int)sizeof(int) > (BLOCKLIMIT / BLOCKS_PER_CONT)) //to avoid owerflow
	{
		BLOCKS_PER_CONT = BLOCKLIMIT / (BLOCKSIZE*sizeof(int));
		if (BLOCKS_PER_CONT == 0)
			BLOCKS_PER_CONT = 1;
	}
	CONTS_NUM = f->num_vars / BLOCKS_PER_CONT;

	states_conts = malloc(sizeof(int*)*CONTS_NUM);

	allocated_cont_num = 0;
	state_num = 0;

	states_conts[0] = malloc(sizeof(int)*BLOCKSIZE*BLOCKS_PER_CONT);

	memcpy(states_conts[0]/* + 0*BLOCKSIZE */, s->varslits, sizeof(int)*BLOCKSIZE);

	s->varslits = states_conts[0]/* + 0*BLOCKSIZE */;

	var = 0; // selected variable 0 means none is selected
	localvq.queue = malloc(sizeof(int)*f->num_vars);
	localvq.top = 0;

	while(s->varslits[0] > 0)
	{
		if(var == 0)
		{
			var = SelectVariable(f, s);
			decisions++;

			localvq.queue[localvq.top] = var;
			localvq.top++;

			state_num++;
			index_cont = state_num / BLOCKS_PER_CONT;
			index_state = state_num % BLOCKS_PER_CONT;

			if(index_cont > allocated_cont_num)
			{
				allocated_cont_num++;
				states_conts[allocated_cont_num] = malloc(sizeof(int)*BLOCKSIZE*BLOCKS_PER_CONT);
			}

			//copy state
			memcpy(states_conts[index_cont] + index_state*BLOCKSIZE, s->varslits, sizeof(int)*BLOCKSIZE);
			s->varslits = states_conts[index_cont] + index_state*BLOCKSIZE;

			s->varslits[var] = FIRST;
		}
		//printf("var %d set to %d\n", var, s->varslits[var]);
		//WriteResult(f,s);
		//Contradiction(f, s);

		if(ProcessSubstitution(f, s, var))
		{
			//printf("after succesfull process subst of %d \n", var);
			//WriteResult(f,s);
			//Contradiction(f, s);
			var = 0;
		}
		else if (s->varslits[var] == FIRST)
		{
			conflicts++;
			//printf("NOT succesfull process subst of %d value was FIRST \n", var);
			//WriteResult(f,s);
			//Contradiction(f, s);

			index_cont = (state_num-1) / BLOCKS_PER_CONT;
			index_state = (state_num-1) % BLOCKS_PER_CONT;
			memcpy(s->varslits, states_conts[index_cont] + index_state*BLOCKSIZE, sizeof(int)*BLOCKSIZE);

			//WriteResult(f,s);
			//Contradiction(f, s);

			s->varslits[var] = SECOND;
		}
		else //varslits[var] == SECOND
		{
			conflicts++;
			//printf("NOT succesfull process subst of %d value was SECOND \n", var);
			//WriteResult(f,s);
			//Contradiction(f, s);
		
			if(conflicts / (restarts+1) > CONFLICTS_TO_RESTART)
			{
				// GOING TO RESTART
				int clause,i;
				restarts++;
				//find the first variable with FIRST value, we will restart from there
				localvq.top = 0;
				while(s->varslits[localvq.queue[localvq.top]] == SECOND)
				{
					localvq.top++;
				}
				state_num = localvq.top+1;
				index_cont = state_num / BLOCKS_PER_CONT;
				index_state = state_num % BLOCKS_PER_CONT;
				s->varslits = states_conts[index_cont] + index_state*BLOCKSIZE;

				// select a variable
				for(clause = 0; clause < f->num_clauses; clause++)
				{
					if(visited_clauses[clause] == 0)
						for(i = f->clauses_variables_index[clause]; i<f->clauses_variables_index[clause+1]; i++)
						{
							var = abs(f->clauses_variables[i]);
							if(s->varslits[var] == UNDEF)
								goto endfor;
						}
				}
				// not found a good variable, select a random variable
				g_clnum = rand() % f->num_clauses;
				var = SelectVariable(f, s);
endfor:
				memset(visited_clauses, 0, sizeof(char)*f->num_clauses);
				localvq.queue[localvq.top] = var;
				localvq.top++;
				s->varslits[var] = FIRST;
				continue;
			} // of RESTART

			localvq.top--;
			state_num--;
			var = localvq.queue[localvq.top];
			while(localvq.top >= 0 && s->varslits[var] == SECOND)
			{
				localvq.top--;
				var = localvq.queue[localvq.top];
				state_num--;
			}
			if (localvq.top < 0)
				return false;
			index_cont = state_num / BLOCKS_PER_CONT;
			index_state = state_num % BLOCKS_PER_CONT;
			s->varslits = states_conts[index_cont] + index_state*BLOCKSIZE;
			s->varslits[var] = SECOND;
		}
	}//of while s->varslits[0] > 0

	// copy the result to the output
	index_cont = state_num / BLOCKS_PER_CONT;
	index_state = state_num % BLOCKS_PER_CONT;
	s->varslits = states_conts[index_cont] + index_state*BLOCKSIZE;
	return true;
}

bool initial_unit_clauses(const Formula*f, State*s)
{
	int i,lit,var,c;
	int vars1 = f->num_vars+1;
	//find initial unit clauses
	for(i = 0; i < f->num_clauses; i++)
	{
		if(s->varslits[vars1 + i] == 1)
		{
			lit = f->clauses_variables[f->clauses_variables_index[i]];
			g_vq.queue[g_vq.top] = abs(lit);
			g_vq.top++;

			if(lit > 0)
				s->varslits[lit] = TRUE;		
			else
				s->varslits[-lit] = FALSE;
		}
	}
	while(g_vq.top > 0)
	{
		g_vq.top--;
		var = g_vq.queue[g_vq.top];

		if(s->varslits[var] == TRUE)
		{
			//turn off clauses with POSITIVE occurences
			for(i = f->vars_pos_occurences_index[var]; i < f->vars_pos_occurences_index[var+1]; i++)
			{
				c = f->vars_pos_occurences[i];
				if (s->varslits[vars1 + c] > 0)
					s->varslits[0]--;
				s->varslits[vars1 + c] = 0;
			}

			//dec lits count in NEGATIVE occurences
			for(i = f->vars_neg_occurences_index[var]; i < f->vars_neg_occurences_index[var+1]; i++)
			{
				c = f->vars_neg_occurences[i];
				if(s->varslits[c + vars1] == 0)
					continue;

				s->varslits[c + vars1]--;
				g_clnum = c; // set the global heuristic variable

				if(s->varslits[c + vars1] == 1)
				{
					if(false == UnitClause(f, s, c)) //modifies g_vq
						return false;
					s->varslits[0]--;
					s->varslits[vars1 + c] = 0;
				}
			}		
		}
		else
		{
			// var == false
			//turn off clauses with NEGATIVE occurences
			for(i = f->vars_neg_occurences_index[var]; i < f->vars_neg_occurences_index[var+1]; i++)
			{
				c = f->vars_neg_occurences[i];
				//printf("%d, %d, %d \n", c, var, i);
				if (s->varslits[vars1 + c] > 0)
					s->varslits[0]--;
				s->varslits[vars1 + c] = 0;
			}

			//decrease lits count in POSITIVE occurences
			for(i = f->vars_pos_occurences_index[var]; i < f->vars_pos_occurences_index[var+1]; i++)
			{
				c = f->vars_pos_occurences[i];

				if(s->varslits[c + vars1] == 0)
					continue;

				s->varslits[c + vars1]--;
				g_clnum = c; // set the global heuristic variable

				if(s->varslits[c + vars1] == 1)
				{
					if(false == UnitClause(f, s, c)) //modifies g_vq
						return false;
					s->varslits[0]--;
					s->varslits[vars1 + c] = 0;
				}
			}
		}
	} // end of while g_vq.top >= 0
	return true;
}

void write_end()
{
	printf("c time: %f seconds\n", (end-start)/(float)CLOCKS_PER_SEC);
	printf("c decisions: %d conflicts: %d restarts: %d \n", decisions, conflicts, restarts);
}

void killed(int x)
{
	x;
	end = clock();
	puts("c Program terminated by the user");
	write_end();
	exit(0);
}

int main(int argc, char** argv)
{
	Formula *f;
	State* s;

	if(argc < 2)
	{
		puts("Usage: sat3 formula.cnf");
		return 0;
	}

	signal(SIGINT, killed);
	start = clock();
	conflicts = 0;
	decisions = 0;
	restarts = 0;

	f = malloc(sizeof(Formula));
	s = malloc(sizeof(State));

	if(false == LoadFromFile(argv[1], f, s))
	{
		puts("ERROR: File not opened");
		return 1;
	}
	puts("c Mei solver version 1.1");

	visited_clauses = malloc(f->num_clauses * sizeof(char));
	memset(visited_clauses, 0, f->num_clauses * sizeof(char));
	g_vq.queue = malloc(sizeof(int)*f->num_vars);
	g_vq.top = 0;
	srand(f->num_vars);

	if(initial_unit_clauses(f,s) == false)
	{
		puts("s UNSATISFIABLE");
		puts("c solved without a decision");
		return 0;
	}
	if(Sat(f,s))
	{
		WriteResult(f, s);
		puts("s SATISFIABLE");
		end = clock();
		write_end();

		//*
		if(CheckResult(f,s) == true)
			puts("c correct");
		else
			puts("c INCORRECT !!");
		/**/
	}
	else
	{
		puts("s UNSATISFIABLE");
		end = clock();
		write_end();
	}
	return 0;
}
