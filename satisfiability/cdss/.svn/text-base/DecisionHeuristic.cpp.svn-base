#include "DecisionHeuristic.h"
#include "Utilities.h"


DecisionHeuristic::DecisionHeuristic(AssignmentStore *assignments, int variables)
{
	this->variables = variables;
	this->assignments = assignments;
	scores = new int[variables+1];
	memset(scores, 0, sizeof(int)*(variables+1));
}

void DecisionHeuristic::setLearnedClausesContainer(std::list<Clause*>* learnedClauses)
{
	this->learnedClauses = learnedClauses;
}

int DecisionHeuristic::getNextVariable()
{
	if (learnedClauses->empty() == false) {
		std::list<Clause*>::iterator it = learnedClauses->end();
		--it;
		for (it; it != learnedClauses->begin(); --it) {
			Clause* cl = *it;
			if (assignments->isClauseSatisfied(cl) == false) {
				return bestLiteral(cl);
			}
		}
	}
	// find any unvalued literal
	return bestLiteral();
}

void DecisionHeuristic::registerRegularClause(Clause *clause)
{
	IntArray* lits = clause->getLiterals();
	for (int i = 0; i < lits->getSize(); i++) {
		int lit = lits->getElements()[i];
		int var = Utilities::getVarFromLit(lit);
		scores[var]++;
	}
}

void DecisionHeuristic::registerConflictParticipant(Clause* clause)
{
	registerRegularClause(clause);
}

int DecisionHeuristic::bestLiteral()
{
	int bestValue = 0;
	int bestLit = 0;
	for (int var = 1; var <= variables; ++var) {
		if (scores[var] > bestValue) {
			int lit = Utilities::encodeLiteral(var);
			if (assignments->getLiteralState(lit) == Unknown) {
				bestValue = scores[var];
				bestLit = lit;
			}
		}
	}
	return bestLit;
}

int DecisionHeuristic::bestLiteral(Clause* clause)
{
	int bestValue = 0;
	int bestLit = 0;
	IntArray* lits = clause->getLiterals();
	for (int i = 0; i < lits->getSize(); ++i) {
		int lit = lits->getElements()[i];
		int var = Utilities::getVarFromLit(lit);
		if (scores[var] > bestValue && assignments->getLiteralState(lit) == Unknown) {
			bestValue = scores[var];
			bestLit = lit;
		}
	}
	return bestLit;
}


DecisionHeuristic::~DecisionHeuristic(void)
{
	// no need for destructor
}
