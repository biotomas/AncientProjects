#include "Formula.h"
#include "Utilities.h"
#include <ctype.h>
#include <string.h>

const size_t BUFFSIZE = 2048;

Formula::Formula(const char* filename)
{
	FILE* file = fopen(filename, "r");
	if (file != NULL)
	{
		int clauses = 0;
		char buffer[BUFFSIZE];
		while (!feof(file))
		{
			fgets(buffer, BUFFSIZE, file);
			if (buffer[0] == 'c')
				continue;
			if (buffer[0] == 'p')
			{
				sscanf(buffer, "p cnf %d %d", &variables, &clauses);
				break;
			}
		}
		//Reading the clauses
		int litBuffer[BUFFSIZE];
		int litInd = 0;
		while (clauses > 0) {
			int lit = getNextInt(file);
			while (lit != 0)
			{
				litBuffer[litInd] = Utilities::encodeLiteral(lit);
				litInd++;
				lit = getNextInt(file);
			}
			saveClause(litBuffer, litInd);
			litInd = 0;
			clauses--;
		}		
	} else {
		puts("Error opening file");
		exit(1);
	}
	fclose(file);
}

void Formula::saveClause(int* buffer, int size)
{
	if (size == 1)
	{
		unaryClauses.push_back(buffer[0]);
	}
	else
	{
		int* lits = new int[size];
		memcpy(lits, buffer, size*sizeof(int));
		Clause* c = new Clause(lits, size);
		clauses.push_back(c);
	}
}

int Formula::getNextInt(FILE* file)
{
	int value = 0;
	int mult = 1;
	int c = fgetc(file);
	while (!isdigit(c) && c != '-')
		c = fgetc(file);
	if (c == '-')
	{
		mult = -1;
		c = fgetc(file);
	}
	while (isdigit(c))
	{
		value = 10*value + c - '0';
		c = fgetc(file);
	}
	return value * mult;
}

std::vector<int>* Formula::getUnaryClauses()
{
	return &unaryClauses;
}

std::vector<Clause*>* Formula::getClauses()
{
	return &clauses;
}

int Formula::getVariables()
{
	return variables;
}

Formula::~Formula(void)
{
	for (size_t i = 0; i < clauses.size(); ++i)
	{
		delete clauses[i];
	}
}
