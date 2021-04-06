#ifndef PROPAGATOR
#define PROPAGATOR

#include <list>
#include <vector>
#include "Clause.h"
#include "AssignmentStore.h"

class Propagator
{
private:
	typedef std::list<Clause*> ClauseList;
	typedef std::vector<int> IntVector;

	ClauseList* watchedClauses;
	IntVector* binaryClauses;
	int* propStack;
	int propStackTop;
	AssignmentStore* assignments;

private:
	void startWatching(int lit1, int lit2, Clause* clause);
	void addLiteralToWatch(int lit, Clause* clause);
	void removeWatching(int lit, Clause* clause);

	/**
	 * Checks the clause if not unit or conflicting. Updates watched literals
	 * and adds propagated literals to the assignment store.
	 * Return true if no conflict appeared
	 */
	bool checkClause(Clause* clause, int lit, ClauseList::iterator* iterator);
	void registerBinaryClause(Clause* clause);

public:
	Propagator(int variables, AssignmentStore* assignments);
	void registerClause(Clause* clause);
	void registerLearnedClause(Clause* clause);
	void unregisterClause(Clause* clause);
	Clause* propagate(int lit);
	~Propagator(void);
};

#endif