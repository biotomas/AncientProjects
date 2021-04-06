#pragma once
#include "directxgraphics.h"
#include "mesh.h"
#include <list>
#include "csound.h"
#include "Shot.h"
#include <string>

enum UnitStatus
{
	US_MOVING,
	US_IDLE,
	US_ATTACKING
};

enum UnitAttackType
{
	UAT_MELEE,
	UAT_RANGED,
	UAT_BUILDER
};


struct UnitType
{
	// graphics
	std::string		name;
	rts::Mesh*		mesh;
	rts::Mesh*		attack_mesh;
	// sounds
	SoundPtr		snd_seleceted;
	SoundPtr		snd_attack;
	SoundPtr		snd_move;
	// logic
	int				initial_hitpoints;
	int				attack;
	UnitAttackType	attack_type;
	int				range;
	float			speed;
};

class Unit : public Renderable
{
	friend class UnitMap;
private:
	int				posx;
	int				posy; // position
	D3DXVECTOR3		start;
	D3DXVECTOR3		goal;
	D3DXVECTOR3		pos;
	D3DXVECTOR3		diff;
	D3DXMATRIXA16	orientation;

	int				hitpoints;
	UnitStatus		status;
	DWORD			start_time;
	DWORD			last_frame_time;

	Csound*			player;
	UnitType*		type;

public:
	virtual void render(LPDIRECT3DDEVICE9 device);
	void UpdatePosition();
	Unit(UnitType* type, int posx, int posy);
	void Move(int newx, int newy);
	void Selected();
	void StartMoving();
	// return true if attack is possible (in range, in time, ...)
	bool Attack(int newx, int newy);
	const UnitType* GetType();
	const int* GetHPPointer();

	int GetPosX();
	int GetPosY();
	bool Moving();
	~Unit(void);
};

typedef std::list<Unit*> UnitList;
typedef UnitList::iterator UnitListIterator;