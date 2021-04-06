#ifndef UTILITIES
#define UTILITIES

class Utilities
{
public:
	static int encodeLiteral(int lit)
	{
		if (lit > 0)
			return (lit << 1) + 1;
		else
			return (-lit) << 1;
	}

	static int getVarFromLit(int lit)
	{
		return lit >> 1;
	}

	static bool isPositive(int lit)
	{
		return (lit & 1) == 1;
	}

	static int negateLiteral(int lit)
	{
		return ((lit >> 1) << 1) + (~lit & 1);
	}
};

#endif