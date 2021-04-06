#include "ConflictDrivenSolver.h"

static const long restartInit = 1000;
static const float restartIncrease = 1.2f;
static const int learningMultiplier = 2;

bool ConflictDrivenSolver::solve(char* filename)
{
	f = new Formula(filename);
	assignments = new AssignmentStore(f->getVariables());
	propagator = new Propagator(f->getVariables(), assignments);
	heuristic = new DecisionHeuristic(assignments, f->getVariables());
	analyzer = new Analyzer(assignments, propagator, heuristic, f->getClauses()->size()*learningMultiplier);

	std::vector<Clause*>::iterator it = f->getClauses()->begin();
	for (it; it != f->getClauses()->end(); ++it) {
		Clause* cl = *it;
		propagator->registerClause(cl);
		heuristic->registerRegularClause(cl);
	}
	
	// deal with the unary clauses first
	std::vector<int>::iterator intIt = f->getUnaryClauses()->begin();
	for (intIt; intIt != f->getUnaryClauses()->end(); ++intIt) {
		int lit = *intIt;
		assignments->setLiteralTrue(lit, NULL);
		Clause* cl = propagator->propagate(lit);
		if (cl != NULL) {
			// Conflict encountered at level 0 => formula UNSATISFIABLE
			return false;
		}
	}
	stat_decisions = 0;
	bool sat = dpll();
	
	if (sat) {
		if (false == checkResult()) {
			puts("Invalid result");
			exit(1);
		}
	}
	printf("decisions %d\n", stat_decisions);
	return sat;
}

bool ConflictDrivenSolver::checkResult()
{
	// normal clauses
	std::vector<Clause*>::iterator it = f->getClauses()->begin();
	for (it; it != f->getClauses()->end(); ++it) {
		Clause* cl = *it;
		if (assignments->isClauseSatisfied(cl) == false) {
			return false;
		}
	}
	// unary clauses
	std::vector<int> ::iterator intIt = f->getUnaryClauses()->begin();
	for (intIt; intIt != f->getUnaryClauses()->end(); ++intIt) {
		int lit = *intIt;
		if (assignments->getLiteralState(lit) != True) {
			return false;
		}
	}
	return true;
}

bool ConflictDrivenSolver::dpll()
{
	long restartLimit = restartInit;
	long conflictsToRestart = restartLimit;
	int startLevel = assignments->nextLevel();
	int level = startLevel;
	
	while(true) {
		stat_decisions++;
		int lit = heuristic->getNextVariable(); //lefvDecide();
		if (lit == 0) {
			// F should be satisfied
			return true;
		}
		//lit = phaseHeuristic(lit);
		assignments->setLiteralTrue(lit, NULL);
		Clause* conflict = propagator->propagate(lit);
		while (conflict != NULL) {
			if (level == 0) {
				return false;
			}
			conflictsToRestart--;
			if (conflictsToRestart == 0) {
				restartLimit = (long) (restartLimit * restartIncrease);
				conflictsToRestart = restartLimit;
				assignments->revertTo(0);
				level = 0;
				break;
			}
			int newLevel = analyzer->analyzeConflict(conflict, level);
			assignments->revertTo(newLevel);
			level = newLevel;
			int propLiteral = analyzer->getAssertedLiteral();
			if (level == 0) {
				assignments->setLiteralTrue(propLiteral, NULL);
			} else {
				assignments->setLiteralTrue(propLiteral, analyzer->getLearnedClause());
			}
			conflict = propagator->propagate(propLiteral);
		}
		level = assignments->nextLevel();
	}
}



ConflictDrivenSolver::ConflictDrivenSolver(void)
{
}

ConflictDrivenSolver::~ConflictDrivenSolver(void)
{
}
