#pragma once

#include <vector>
#include <d3dx9.h>
#include "CommonStructures.h"

class CollisionDetection
{
private:

	struct BoundingRect
	{
		Fpoint upleft;
		Fpoint downright;
	};

	struct Equation
		//Equation defining a 2D plane: a*x + b*y + c > 0
	{
		float a,b,c;
	};

	struct PolyEquation
	{
		size_t n;
		Equation* eqs;

		PolyEquation():eqs(NULL){}
	};

	typedef std::vector<BoundingRect> TBrectVector;
	typedef std::vector<PolyEquation> TPolyEqVector;

	TPolyEqVector		equations;
	TBrectVector		bounding_rects;

private:
	// calculate the bounding rectangle of a polygon
	BoundingRect calculate_bounding_rect(points_vector& ngon);
	// calculate the equations of halfplanes defined by polygon edges
	PolyEquation calculate_equations(points_vector& ngon);
	// decide whether a point is inside a polygon and return a normal to the closest edge if so
	bool PolyCollide(PolyEquation& object, const Fpoint& pt, D3DXVECTOR3& normal);

public:
	CollisionDetection(void);
	void add_obstruction(points_vector& newobst);
	void clear_obstructions();
	bool collide(D3DXVECTOR3& normal, const Fpoint& me);
	~CollisionDetection(void);
};

extern CollisionDetection global_collision_detector;
