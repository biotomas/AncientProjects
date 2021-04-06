#include "FormulaParser.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <malloc.h>
#include <string.h>

const unsigned int lineBufferSize = 512;
const unsigned int expectedAverageLitsPerClause = 5;
static char* lineBuffer;
static int lineNumber = 0;
static FILE* file = NULL;

static void readLine(char* buffer) {
    buffer = fgets(buffer, lineBufferSize, file);
    lineNumber++;
}

int getNextNumber() {
    int number = 0;
    int sign = 1;
    static int k = 0;
    while (!isdigit(lineBuffer[k]) && lineBuffer[k] != '\n' && lineBuffer[k] != '-') {
        k++;
    }
    while (lineBuffer[k] == '\n' || lineBuffer[0] == 'c') {
        readLine(lineBuffer);
        k = 0;
    }
    if (lineBuffer[k] == '-') {
        sign = -1;
        k++;
    }
    while (isdigit(lineBuffer[k])) {
        number = 10 * number + lineBuffer[k] - '0';
        k++;
    }
    return sign * number;
}

void loadFormula(Formula* f, char* filename, Valuation* impliedValues) {
    int literal;
    int clause;
    file = fopen(filename, "r");
    if (file == NULL) {
        exception = "ERROR: file could not be opened.";
        return;
    }
    lineBuffer = (char*)malloc(lineBufferSize*sizeof(char));
    readLine(lineBuffer);

    // skip initiall comments and empty lines
    while (lineBuffer[0] == '\n' || lineBuffer[0] == 'c') {
        readLine(lineBuffer);
    }
    // problem definition line should follow
    if (lineBuffer[0] != 'p') {
        exception = "ERROR: problem definition line missing.";
        return;
    }
    f->varNum = getNextNumber(file);
    f->clauseNum = getNextNumber(file);

    // reading the clauses
    f->clauseIndex = malloc((1 + f->clauseNum)*sizeof(int));
    f->clauses = malloc(f->clauseNum*expectedAverageLitsPerClause*sizeof(int));

    // variable appearance statistics
    int * numPosOccurences = malloc((1 + f->varNum)*sizeof(int));
    int * numNegOccurences = malloc((1 + f->varNum)*sizeof(int));
    memset(numPosOccurences, 0, sizeof(f->varNum*sizeof(int)));
    memset(numNegOccurences, 0, sizeof(f->varNum*sizeof(int)));
    int sumPosOccurences = 0;
    int sumNegOccurences = 0;
    int literalPosition = 0;


    f->clauseIndex[0] = 0;
    for (clause = 1; clause < f->clauseNum; clause++) {
        while(1) {
            literal = getNextNumber();
            if (literal == 0)
                break;
            f->clauses[literalPosition] = literal;
            if (literal > 0) {
                sumPosOccurences++;
                numPosOccurences[literal]++;
            } else {
                sumNegOccurences++;
                numNegOccurences[-literal]++;
            }
            literalPosition++;
        }
        f->clauseIndex[clause] = literalPosition;
    }
    f->clauses = realloc(f->clauses, f->clauseIndex[f->clauseNum]*sizeof(int));

    // f->clauses and f->clauseIndex done

    f->posOccurenceIndex = malloc((1 + f->varNum)*sizeof(int));
    f->negOccurenceIndex = malloc((1 + f->varNum)*sizeof(int));
    f->posOccurences = malloc(sumPosOccurences*sizeof(int));
    f->negOccurences = malloc(sumNegOccurences*sizeof(int));


    int i;
    sumPosOccurences = 0;
    sumNegOccurences = 0;
    for (i = 1; i < f->varNum + 1; i++) {
        f->posOccurenceIndex[i] = sumPosOccurences;
        f->negOccurenceIndex[i] = sumNegOccurences;
        sumPosOccurences += numPosOccurences[i];
        sumNegOccurences += numNegOccurences[i];
    }

    int * offsetPosOccurences = malloc((1 + f->varNum)*sizeof(int));
    int * offsetNegOccurences = malloc((1 + f->varNum)*sizeof(int));
    memset(offsetPosOccurences, 0, (1 + f->varNum)*sizeof(int));
    memset(offsetNegOccurences, 0, (1 + f->varNum)*sizeof(int));

    puts("ahoj");
    for (clause = 0; clause < f->clauseNum; clause++) {
        for (i = f->clauseIndex[clause]; i < f->clauseIndex[clause+1]; i++) {
            literal = f->clauses[i];
            if (literal > 0) {

            } else {

            }
        }
    }

/**/

    puts("vypis:");
    for (i = 0 ; i < f->clauseNum; i++)
        printf("%d, ",f->clauseIndex[i]);
    puts("");
    for (i = 0 ; i < f->clauseIndex[f->clauseNum]; i++)
        printf("%d, ",f->clauses[i]);
    puts("");


    return;
}
