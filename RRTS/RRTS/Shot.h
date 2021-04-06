#pragma once
#include "DirectXGraphics.h"
#include <list>
#include "mesh.h"

class Shot
{
private:
	D3DXVECTOR3 diff,from,position;
	float		speed;
	bool		active;
	DWORD		start_time;
public:
	Shot(D3DXVECTOR3 from, D3DXVECTOR3 to, float speed = DEFAULT_SHOT_SPEED);
	const D3DXVECTOR3* GetActualPosition(DWORD time);
	bool IsActive();
	~Shot(void);
};
/**/
class ShotManager : public Renderable
{
private:
	typedef std::list<Shot*> ShotList;

	rts::Mesh*				shot_mesh;
	ShotList				shots;
	static ShotManager*		default_instance;
public:
	static ShotManager* GetDefaultInstance();
	virtual void render(LPDIRECT3DDEVICE9 device);
	void AddShot(Shot* newshot);
	ShotManager();
	~ShotManager(void);
};
