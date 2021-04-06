#ifndef ASSIGNMENTSTORE
#define ASSIGNMENTSTORE

#include "Clause.h"
#include "Constants.h"

class AssignmentStore
{
private:
	VarState* varsState;
	VarState* phaseLog;
	Clause** reasons;
	int* levelOf;

	int* varsStack;
	int varsStackTop;
	int* varsStackIndex;

	int level;

public:
	AssignmentStore(int variables);

	bool setLiteralTrue(int lit, Clause* reason);

	Clause* getReason(int lit);
	
	int getLevelOf(int lit);
	
	int nextLevel();
	
	void revertTo(int level);
	
	VarState getLiteralState(int lit);

	VarState* getPhaseLog();
	
	bool isClauseSatisfied(Clause* clause);

	~AssignmentStore(void);
};

#endif