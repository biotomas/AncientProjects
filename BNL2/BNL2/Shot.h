#pragma once
#include "directxgraphics.h"
#include "mesh.h"
#include <list>

using namespace bnl;

struct ShotParameters
{
	float		velocity;
	size_t		damage;
	DWORD		timeout; // in miliseconds
	float		size;
};

class Shot
{
private:
	ShotParameters				parameters;
	D3DXVECTOR3					position;
	D3DXVECTOR3					direction;
	bool						active;
	static Mesh*				ball_mesh;
	static LPDIRECT3DDEVICE9	device;


public:
	Shot(D3DXVECTOR3& position, D3DXVECTOR3& direction, ShotParameters& parameters);
	void bounce(const D3DXVECTOR3& obstruction_normal);
	bool is_active();
	void deactivate();

	void render();
	void update_position();
	size_t get_damage();

	D3DXVECTOR3& get_position(D3DXVECTOR3& position) const;
	virtual ~Shot(void);
};
