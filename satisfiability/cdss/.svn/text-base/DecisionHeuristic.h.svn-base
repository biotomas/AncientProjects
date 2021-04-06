#ifndef DECISIONHEURISTIC
#define DECISIONHEURISTIC

#include "Clause.h"
#include "AssignmentStore.h"
#include <list>

class DecisionHeuristic
{
private:
	int* scores;
	int variables;
	AssignmentStore* assignments;
	std::list<Clause*>* learnedClauses;

	int bestLiteral(Clause* clause);
	int bestLiteral();

public:
	DecisionHeuristic(AssignmentStore* assignments, int variables);
	void registerConflictParticipant(Clause* clause);
	void registerRegularClause(Clause* clause);
	void setLearnedClausesContainer(std::list<Clause*>* learnedClauses);
	int getNextVariable();
	~DecisionHeuristic(void);
};

#endif