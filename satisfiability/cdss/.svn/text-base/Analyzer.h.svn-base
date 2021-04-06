#ifndef ANALYZER
#define ANALYZER

#include "Propagator.h"
#include "AssignmentStore.h"
#include "DecisionHeuristic.h"
#include "IntArray.h"
#include <list>
#include <set>

class Analyzer
{
private:
	typedef std::list<int> IntList;

	AssignmentStore* assignments;
	Propagator* propagator;
	DecisionHeuristic* heuristic;

	std::list<Clause*> learnedClauses;
	unsigned learnedLimit;
	Clause* lastLearned;
	int assertedLiteral;

	Clause* generateNewClause(Clause* conflict, int level);
	void resolve(IntList* list, std::set<int>* set, IntArray* cl2, int lit);
	int findLiteralForResolution(IntList* clause, int level);
	int computeBackTrackLevel(Clause* clause, int level);
	/**
	 * Delete some of the learned clauses to save some memory
	 */
	void reduceLearnedClauses();

public:
	Analyzer(AssignmentStore* assignments, Propagator* propagator, DecisionHeuristic* heuristic, int learnedLimit);
	/**
	 * Analyze the conflict in order to learn new clause(s) and compute
	 * the proper backtrack level
	 * @param conflict conflict clause
	 * @param level current decision level
	 * @return level of backtrack
	 */
	int analyzeConflict(Clause* conflict, int level);
	Clause* getLearnedClause();
	int getAssertedLiteral();
	~Analyzer(void);
};

#endif