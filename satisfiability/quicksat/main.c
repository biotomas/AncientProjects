#include "FormulaParser.h"
#include <stdio.h>
#include "CommonStructures.h"

static Valuation actualValuation;
static Valuation valuationQueue;
static int* indexValuationQueue;
static int decisionLevel;

int main(int argc, char** argv) {
    Formula f;
    loadFormula(&f, "test2.cnf", &actualValuation);
    if (exception != NULL) {
        puts(exception);
        return 1;
    }
    puts("koniec");
    return 0;
}
