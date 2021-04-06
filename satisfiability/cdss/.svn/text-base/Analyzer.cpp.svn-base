#include "Analyzer.h"
#include "Utilities.h"

/**
 * Increase the maximum number of learned clauses by this
 * number each time the former limit is reached
 */
static const float learnedLimitMultiplier = 1.5f;
/**
 * Learned clauses with lower hit counts will be deleted
 */
static const int hitLimit = 3;
/**
 * How much of the learned clauses is to be deleted at garbage collection
 */
static const float deletingFraction = 0.5f;
/**
 * Shorter clauses are never removed
 */
static const int lengthLimit = 4;


Clause* Analyzer::generateNewClause(Clause* conflict, int level)
{
	IntList literals;
	std::set<int> literalSet;
	heuristic->registerConflictParticipant(conflict);
	IntArray* lits = conflict->getLiterals();
	for (int i = 0; i < lits->getSize(); i++) {
		int lit = lits->getElements()[i];
		if (literalSet.insert(lit).second) {
			literals.push_back(lit);
		}
	}
	int resolutionLit = findLiteralForResolution(&literals, level);
	// Resolve antecendent until necessary
	while (resolutionLit != 0) {
		Clause* reason = assignments->getReason(resolutionLit);
		heuristic->registerConflictParticipant(reason);
		resolve(&literals, &literalSet, reason->getLiterals(), resolutionLit);
		resolutionLit = findLiteralForResolution(&literals, level);
	}
	// Convert the result
	int* result = new int[literals.size()];
	int ind = 0;
	for (IntList::iterator it = literals.begin(); it != literals.end(); ++it) {
		result[ind] = *it;
		ind++;
	}
	return new Clause(result, literals.size());
}

int Analyzer::findLiteralForResolution(IntList* clause, int level)
{
	int found = 0;
	int retLit = 0;
	for (IntList::iterator it = clause->begin(); it != clause->end(); ++it) {
		int lit = *it;
		if (assignments->getLevelOf(lit) == level) {
			found++;
			assertedLiteral = lit;
			if (assignments->getReason(lit) != NULL) {
				// the first such a literal is the best,
				// this way it is more 1-UIP-ish.
				if (retLit == 0) {
					retLit = lit;
				}
			}
			if (found >= 2 && retLit != 0) {
				break;
			}
		}
	}
	return found >= 2 ? retLit : 0;
}

void Analyzer::resolve(std::list<int> *list, std::set<int> *set, IntArray *cl2, int lit)
{
	list->remove(lit);
	set->erase(set->find(lit));
	int var = Utilities::getVarFromLit(lit);

	for (int i = 0; i < cl2->getSize(); i++) {
		int clLit = cl2->getElements()[i];
		int clVar = Utilities::getVarFromLit(clLit);
		if (clVar != var && set->insert(clLit).second) {
			list->push_back(clLit);
		}
	}
}

int Analyzer::computeBackTrackLevel(Clause* clause, int level)
{
	int maxLev = -1;
	IntArray* lits = clause->getLiterals();
	for (int i = 0; i < lits->getSize(); i++) {
		int lit = lits->getElements()[i];
		int lev = assignments->getLevelOf(lit);
		if (lev > maxLev && lev != level) {
			maxLev = lev;
		}
	}
	return maxLev == -1 ? level : maxLev;
}

Analyzer::Analyzer(AssignmentStore* assignments, Propagator* propagator, DecisionHeuristic* heuristic, int learnedLimit)
{
	this->assignments = assignments;
	this->propagator = propagator;
	this->heuristic = heuristic;
	this->learnedLimit = learnedLimit;
	heuristic->setLearnedClausesContainer(&learnedClauses);
}

int Analyzer::analyzeConflict(Clause* conflict, int level)
{
	Clause* newClause = generateNewClause(conflict, level);
	if (learnedClauses.size() > learnedLimit) {
		learnedLimit = (int) (learnedLimit * learnedLimitMultiplier);
		reduceLearnedClauses();
	}
	lastLearned = newClause;
	if (newClause->getLiterals()->getSize() > 1) {
		if (newClause->getLiterals()->getSize() > 2) {
			learnedClauses.push_back(newClause);
		}
		propagator->registerLearnedClause(newClause);
		return computeBackTrackLevel(newClause, level);
	}
	return 0;
}

void Analyzer::reduceLearnedClauses()
{
	int toDelete = (int) (learnedClauses.size()*deletingFraction);
	std::list<Clause*>::iterator it = learnedClauses.begin();
	
	while (it != learnedClauses.end()) {
		Clause* cl = *it;
		// we never delete locked or short clauses
		if (cl->isLocked() || cl->getLiterals()->getSize() < lengthLimit) {
			++it;
			continue;
		}
		// we have deleted enough
		if (toDelete == 0) {
			break;
		}
		if (cl->getHits() < hitLimit) {
			propagator->unregisterClause(cl);
			it = learnedClauses.erase(it);
			toDelete--;
		} else {
			cl->halfHits();
			++it;
		}
	}
}

Clause* Analyzer::getLearnedClause()
{
	return lastLearned;
}

int Analyzer::getAssertedLiteral()
{
	return assertedLiteral;
}

Analyzer::~Analyzer(void)
{
	//no need for destructor
}
