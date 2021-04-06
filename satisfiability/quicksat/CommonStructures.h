#ifndef COMMONSTRUCTURES_H_INCLUDED
#define COMMONSTRUCTURES_H_INCLUDED

/************************************************
** CONSTANTS
************************************************/

extern const char FALSE = 0;
extern const char TRUE = 1;
extern const char UNDEF = 2;

/************************************************
** GLOBAL VARIABLES
************************************************/

extern char* exception;

/************************************************
** TYPES
************************************************/

typedef struct Formula {
    int clauseNum;
    int varNum;

    int* posOccurenceIndex; // length = varNum
    int* posOccurences; // length = sum of positive occurences in clauses
    int* negOccurenceIndex; // length = varNum
    int* negOccurences; // length = sum of negative occurences in clauses

    int* clauseIndex; // length = clauseNum
    int* clauses; // length = sum of literals in clauses

    int* pos1WatchedOccurences; // length = varNum
    int* pos2WatchedOccurences; // length = varNum
    int* neg1WatchedOccurences; // length = varNum
    int* neg2WatchedOccurences; // length = varNum
} Formula;

typedef char* Valuation;

typedef enum bool {
    true,
    false
} bool;

#endif // COMMONSTRUCTURES_H_INCLUDED
