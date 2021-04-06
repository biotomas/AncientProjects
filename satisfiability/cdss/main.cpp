#include <stdio.h>
#include "ConflictDrivenSolver.h"
#include <signal.h>
#include <stdlib.h>

ConflictDrivenSolver solver;

void beingKilled(int param)
{
	printf("Decisions %d\nKILLED\n", solver.stat_decisions);
	exit(1);
}

int main(int argc, char** argv)
{
	signal(SIGINT, beingKilled);
	signal(SIGTERM, beingKilled);

	bool sat = solver.solve(argv[1]);
	printf("%s\n", sat ? "SAT" : "UNSAT");
	return 0;
}