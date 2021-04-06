#include "Propagator.h"
#include "Utilities.h"

Propagator::Propagator(int variables, AssignmentStore* assignments)
{
	watchedClauses = new ClauseList[2 * variables + 2];
	binaryClauses = new IntVector[2 * variables + 2];
	propStack = new int[variables];
	this->assignments = assignments;
}

void Propagator::registerClause(Clause* clause)
{
	if (clause->getLiterals()->getSize() == 2) {
		registerBinaryClause(clause);
	} else {
		int* literals = clause->getLiterals()->getElements();
		startWatching(literals[0], literals[1], clause);
	}
}

void Propagator::registerLearnedClause(Clause* clause)
{
	int clauseSize = clause->getLiterals()->getSize();
	if (clauseSize == 2) {
		registerBinaryClause(clause);
		return;
	}
	int highestLevel = -1;
	int secondHighestLevel = -1;
	int watched1 = 0;
	int watched2 = 0;
	for (int i = 0; i < clauseSize; i++) {
		int lit = clause->getLiterals()->getElements()[i];
		int level = assignments->getLevelOf(lit);
		if (level > highestLevel) {
			secondHighestLevel = highestLevel;
			watched2 = watched1;
			highestLevel = level;
			watched1 = lit;
		} else if (level > secondHighestLevel) {
			secondHighestLevel = level;
			watched2 = lit;
		}
	}
	startWatching(watched1, watched2, clause);
}

void Propagator::registerBinaryClause(Clause *clause)
{
	int lit1 = clause->getLiterals()->getElements()[0];
	int lit2 = clause->getLiterals()->getElements()[1];
	binaryClauses[lit1].push_back(lit2);
	binaryClauses[lit2].push_back(lit1);
}

void Propagator::startWatching(int lit1, int lit2, Clause* clause)
{
	addLiteralToWatch(lit1, clause);
	addLiteralToWatch(lit2, clause);
	clause->setWatch1(lit1);
	clause->setWatch2(lit2);
}

void Propagator::unregisterClause(Clause *clause)
{
	if (clause->isLocked() == false && clause->getLiterals()->getSize() > 2) {
		removeWatching(clause->getWatch1(), clause);
		removeWatching(clause->getWatch2(), clause);
	}
}

Clause* Propagator::propagate(int lit)
{
	propStack[0] = lit;
	propStackTop = 1;
	while (propStackTop > 0) {
		propStackTop--;
		int lit = propStack[propStackTop];
		int negLit = Utilities::negateLiteral(lit);
		// binary clauses
		for (unsigned i = 0; i < binaryClauses[negLit].size(); i++) {
			int l = binaryClauses[negLit][i];
			if (assignments->getLiteralState(l) == True) {
				continue;
			}
			int* lits = new int[2];
			lits[0] = l;
			lits[1] = negLit;
			Clause* reason = new Clause(lits, 2);
			if (assignments->getLiteralState(l) == Unknown) {
				assignments->setLiteralTrue(l, reason);
				propStack[propStackTop] = l;
				propStackTop++;
			} else {
				// literal is false, return conflict
				return reason;
			}
		}
		//}
		// longer clauses (longer than 2)
		ClauseList::iterator iter = watchedClauses[negLit].begin();
		while (iter != watchedClauses[negLit].end()) {
			Clause* cl = *iter;
			if (checkClause(cl, negLit, &iter) == false) {
				return cl;
			}
		}
	}
	return NULL;
}

/**
 * Check the clause for unitness and update watched literals. Also update the iterator
 */
bool Propagator::checkClause(Clause *clause, int propLit, Propagator::ClauseList::iterator *iterator)
{
	IntArray* clauseLits = clause->getLiterals();
	for (int i = 0; i < clauseLits->getSize(); i++) {
		int lit = clauseLits->getElements()[i];
		if (assignments->getLiteralState(lit) == True) {
			// satisfied clause
			++(*iterator);
			return true;
		}
		if (assignments->getLiteralState(lit) == Unknown) {
			if (lit != clause->getWatch1() && lit != clause->getWatch2()) {
				// This is equivalent to removeWatching(literal, cl)
				addLiteralToWatch(lit, clause);
				if (clause->getWatch1() == propLit) {
					clause->setWatch1(lit);
				} else {
					clause->setWatch2(lit);
				}
				// new watched literal found
				*iterator = watchedClauses[propLit].erase(*iterator);
				return true;
			}
		}
	}
	// if we got here the clause is not satisfied and no new
	// watched literal was found. We are dealing with a unit clause
	// or a conflict
	int lastLit = clause->getWatch1() == propLit ? clause->getWatch2() : 
			clause->getWatch1();
	if (assignments->getLiteralState(lastLit) == Unknown) {
		assignments->setLiteralTrue(lastLit, clause);
		propStack[propStackTop] = lastLit;
		propStackTop++;
		++(*iterator);
		return true;
	} else {
		// lastLit must be false, but then a conflict has occurred.
		return false;
	}
}

void Propagator::addLiteralToWatch(int lit, Clause* clause)
{
	watchedClauses[lit].push_front(clause);
}

void Propagator::removeWatching(int lit, Clause *clause)
{
	watchedClauses[lit].remove(clause);
}

Propagator::~Propagator(void)
{
	//no need for destructor
}
