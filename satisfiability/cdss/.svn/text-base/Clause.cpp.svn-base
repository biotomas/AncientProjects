#include "Clause.h"

Clause::Clause(int* lits, int size):literals(IntArray(lits, size))
{
	locked = false;
	hits = 0;
}

void Clause::lock()
{
	locked = true;
	hits++;
}

void Clause::unlock()
{
	locked = false;
}

bool Clause::isLocked()
{
	return locked;
}

IntArray* Clause::getLiterals()
{
	return &literals;
}

void Clause::setWatch1(int lit)
{
	watch1 = lit;
}

void Clause::setWatch2(int lit)
{
	watch2 = lit;
}

int Clause::getWatch1()
{
	return watch1;
}

int Clause::getWatch2()
{
	return watch2;
}

int Clause::getHits()
{
	return hits;
}

void Clause::halfHits()
{
	hits = hits >> 1;
}

Clause::~Clause()
{
}

