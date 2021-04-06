#pragma once
#include "directxgraphics.h"
#include "Mesh.h"
#include "CollisionDetection.h"

class Tank : public Renderable
{
private:
	D3DXVECTOR3			position;

	float				direction; // where is the tank going
	float				orientation; // where the tank wants to go
	float				velocity;
	float				rotation_rate; // how fast does the direction angle aproach the orientation angle

	float				speed_limit;
	float				deacceleration; //0.0 - 1.0
	static float		multiplier;

	DWORD				last_updated;
	bnl::Mesh*			tank_mesh;


public:
	size_t				hitpoints;

	virtual void render(LPDIRECT3DDEVICE9 device);
	void update_position();

	void steer(float angle);
	void accelerate(float speed);
	void brake_tank(float percent); // 1.0 stop immediately, 0.0 do nothing
	void bounce(const D3DXVECTOR3& obst_normal, float force);
	void bounce_wall(const D3DXVECTOR3& wall_normal);
	float get_range();

	D3DXVECTOR3 get_position();
	D3DXVECTOR3 get_orientation();
	float		get_velocity();
	void set_position(D3DXVECTOR3& newpos);
	
	Tank(LPDIRECT3DDEVICE9 device, char* mesh_filename, D3DXVECTOR3& position_);
	virtual ~Tank(void);
};
