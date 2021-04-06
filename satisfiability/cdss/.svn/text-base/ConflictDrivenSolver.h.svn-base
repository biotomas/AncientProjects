#ifndef CONFLICTDRIVENSOLVER
#define CONFLICTDRIVENSOLVER

#include "Formula.h"
#include "Analyzer.h"
#include "Propagator.h"
#include "AssignmentStore.h"
#include "DecisionHeuristic.h"

class ConflictDrivenSolver
{
private:
	Formula* f;
	AssignmentStore* assignments;
	Propagator* propagator;
	Analyzer* analyzer;
	DecisionHeuristic* heuristic;

	bool dpll();
	bool checkResult();

public:
	int stat_decisions;

	ConflictDrivenSolver(void);
	bool solve(char* filename);
	~ConflictDrivenSolver(void);
};

#endif