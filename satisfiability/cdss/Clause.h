#ifndef CLAUSE
#define CLAUSE

#include "IntArray.h"

class Clause
{
private:
	IntArray literals;
	int hits;
	bool locked;
	int watch1;
	int watch2;

public:
	Clause(int* lits, int size);
	void lock();
	void unlock();
	bool isLocked();
	IntArray* getLiterals();
	void setWatch1(int lit);
	void setWatch2(int lit);
	int getWatch1();
	int getWatch2();
	int getHits();
	void halfHits();

	~Clause(void);
};

#endif