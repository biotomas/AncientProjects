#ifndef FORMULA
#define FORMULA

#include "Clause.h"
#include <vector>
#include <stdio.h>
#include <stdlib.h>

class Formula
{
private:
	std::vector<Clause*> clauses;
	std::vector<int> unaryClauses;
	int variables;

public:
	Formula(const char* filename);
	std::vector<int>* getUnaryClauses();
	std::vector<Clause*>* getClauses();
	int getVariables();
	~Formula(void);

private:
	void saveClause(int* buffer, int size);
	int getNextInt(FILE* file);
};

#endif