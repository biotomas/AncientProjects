#include "CollisionDetection.h"

CollisionDetection global_collision_detector;

CollisionDetection::CollisionDetection(void)
{
}

// calculates the bounding rect
CollisionDetection::BoundingRect CollisionDetection::calculate_bounding_rect(points_vector& ngon)
{
	CollisionDetection::BoundingRect br;
	br.upleft = ngon[0];
	br.downright = ngon[0];
	float x,y;

	for (size_t i = 0; i < ngon.size(); i++)
	{
		x = ngon[i].x;
		y = ngon[i].y;

		if (x < br.upleft.x)
			br.upleft.x = x;
		if (x > br.downright.x)
			br.downright.x = x;
		if (y < br.upleft.y)
			br.upleft.y = y;
		if (y > br.downright.y)
			br.downright.y = y;
	}
	return br;
}

CollisionDetection::PolyEquation CollisionDetection::calculate_equations(points_vector &ngon)
	// the polygon is closed: first point = last point
{
	CollisionDetection::PolyEquation pe;
	pe.n = ngon.size() -1;
	pe.eqs = new Equation[pe.n];

	size_t i;
	Equation eq;
	Fpoint p1, p2;
	D3DXVECTOR3 normalizer;

	for (i = 0; i < pe.n; i++)
	{
		p1 = ngon[i];
		p2 = ngon[i+1];

		// vector [a,b] is perpendicular to [p2-p1]
		eq.a = p2.y - p1.y;
		eq.b = - (p2.x - p1.x);

		normalizer.x = eq.a;
		normalizer.y = eq.b;
		normalizer.z = 0;

		D3DXVec3Normalize(&normalizer, &normalizer);

		eq.a = normalizer.x;
		eq.b = normalizer.y;

		eq.c = - (eq.a * p1.x + eq.b * p1.y);

		pe.eqs[i] = eq;
	}
	return pe;
}

void CollisionDetection::add_obstruction(points_vector &newobst)
{
	bounding_rects.push_back(calculate_bounding_rect(newobst));
	CollisionDetection::PolyEquation pe = calculate_equations(newobst);

	equations.push_back(pe);
}

void CollisionDetection::clear_obstructions()
{
	bounding_rects.clear();
	equations.clear();
}

bool CollisionDetection::PolyCollide(CollisionDetection::PolyEquation &object, const Fpoint &pt, D3DXVECTOR3 &normal)
{
	size_t i, minn = 0;
	float val, min = -90000.0f; // infinity
	bool allnegative = true;
	Equation eq;

	for (i = 0; i < object.n; i++)
	{
		eq = object.eqs[i];
		val = eq.a * pt.x + eq.b * pt.y + eq.c;
		if (val > min)
		{
			min = val;
			minn = i;
		}
		if (val > 0) allnegative = false;
	}

	if (allnegative)
	{
		// the point is in the polygon
		// let us set the normal vector
		normal.x = object.eqs[minn].a;
		normal.z = object.eqs[minn].b;
		normal.y = 0;
		return true;
	}
	else
		return false;
}


bool CollisionDetection::collide(D3DXVECTOR3 &normal, const Fpoint& me)
{
	size_t n;
	Fpoint upleft, downright;

	for (n = 0; n < bounding_rects.size(); n++)
	{
		upleft = bounding_rects[n].upleft;
		downright = bounding_rects[n].downright;

		if (me.x >= upleft.x && me.x <= downright.x && me.y >= upleft.y && me.y <= downright.y)
			//it might collide with the n-th pollygon
			if (PolyCollide(equations[n], me, normal))
				return true;
	}
	return false;
}

CollisionDetection::~CollisionDetection(void)
{
}
