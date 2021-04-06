#include "AssignmentStore.h"
#include <string.h>
#include "Utilities.h"

AssignmentStore::AssignmentStore(int variables)
{
	varsState = new VarState[variables+1];
	reasons = new Clause*[variables+1];
	phaseLog = new VarState[variables+1];
	levelOf = new int[variables+1];

	varsStackIndex = new int[variables+1];
	varsStack = new int[variables];

	varsStackTop = 0;
	level = 0;
	varsStackIndex[0] = 0;
	memset(varsState, 0, sizeof(VarState)*(1+variables));
	memset(varsStackIndex, 0, sizeof(int)*(1+variables));
	memset(phaseLog, 0, sizeof(VarState)*(1+variables));
	memset(reasons, NULL, sizeof(Clause*)*(1+variables));
}

bool AssignmentStore::setLiteralTrue(int lit, Clause* reason)
{
	int var = Utilities::getVarFromLit(lit);
	VarState newState = Utilities::isPositive(lit) ? True : False;
	VarState oldState = varsState[var];
	if (oldState != Unknown) {
		if (oldState == newState) {
			return true;
		} else {
			return false;
		}
	}
	varsState[var] = newState;
	phaseLog[var] = newState;

	if (reason != NULL) {
		reason->lock();
		reasons[var] = reason;
	}
	
	levelOf[var] = level;
	varsStack[varsStackTop] = var;
	varsStackTop++;
	return true;
}

Clause* AssignmentStore::getReason(int lit)
{
	return reasons[Utilities::getVarFromLit(lit)];
}

int AssignmentStore::getLevelOf(int lit)
{
	return levelOf[Utilities::getVarFromLit(lit)];
}

int AssignmentStore::nextLevel()
{
	level = level + 1;
	varsStackIndex[level] = varsStackTop;
	return level;
}

void AssignmentStore::revertTo(int level)
{
	int start = level + 1;
	for (int i = varsStackIndex[start]; i < varsStackTop; i++) {
		int var = varsStack[i];
		varsState[var] = Unknown;
		if (reasons[var] != NULL) {
			Clause* clause = reasons[var];
			clause->unlock();
			if (clause->getLiterals()->getSize() == 2)
				delete clause;
			reasons[var] = NULL;
		}
	}
	varsStackTop = varsStackIndex[start];
	this->level = level;
}

VarState AssignmentStore::getLiteralState(int lit)
{
	int var = Utilities::getVarFromLit(lit);
	VarState st = varsState[var];
	if (Utilities::isPositive(lit)) {
		return st;
	} else {
		return negateVarState(st);
	}
}

bool AssignmentStore::isClauseSatisfied(Clause* clause)
{
	IntArray* lits = clause->getLiterals();
	int size = lits->getSize();
	for (int i = 0; i < size; i++)
	{
		if (getLiteralState(lits->getElements()[i]) == True)
			return true;
	}
	return false;
}

VarState* AssignmentStore::getPhaseLog()
{
	return phaseLog;
}

AssignmentStore::~AssignmentStore()
{
	// no need for destructor
	//delete varsState;
	//delete reasons;
	//delete phaseLog;
	//delete levelOf;
	//delete varsStack;
	//delete varsStackIndex;
}
