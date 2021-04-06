#pragma once
#include <vector>

struct Fpoint
{
	Fpoint(){}
	Fpoint(float x, float y)
	{
		this->x = x;
		this->y = y;
	}
	float x;
	float y;
};

typedef std::vector<Fpoint> points_vector;

