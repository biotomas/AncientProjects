#include "UnitMap.h"

UnitMap::UnitMap(int sizex, int sizey, float tilesize)
{
	this->sizey = sizey;
	this->sizex = sizex;
	this->tilesize = tilesize;
	this->unit_map = new Unit*[sizex*sizey];
	memset(this->unit_map, 0, sizeof(Unit*)*sizex*sizey);
}

bool UnitMap::IsFree(int x, int y)
{
	return this->unit_map[x + y* this->sizex] == NULL;
}

bool UnitMap::AddUnit(int x, int y, Unit *unit)
{
	if(x >= this->sizex || y >= this->sizey || x < 0 || y < 0)
		return false;

	if(	this->unit_map[x + this->sizex * y] == NULL )
	{
		this->active_units.push_back(unit);
		this->unit_map[x + this->sizex * y] = unit;
		return true;
	}
	return false;
}

bool UnitMap::ClearUnit(Unit *unit)
{
	int x, y;
	x = unit->posx;
	y = unit->posy;

	if(x >= this->sizex || y >= this->sizey || x < 0 || y < 0)
		return false;
	
	this->unit_map[x + (y * this->sizex)] = NULL;
	this->active_units.remove(unit);
	return true;
}

bool UnitMap::MoveUnit(Unit *unit, int x, int y)
{
	// test the new position
	if (x < 0 || y < 0 || x >= this->sizex || y >= this->sizey)
		return false;
	if (this->unit_map[x + (y * this->sizex)] == NULL)
	{
		// free the old position
		this->unit_map[unit->posx + (unit->posy * this->sizex)] = NULL;
		// occupy the new position
		this->unit_map[x + (y * this->sizex)] = unit;
		return true;
	}
	return false;
}

void UnitMap::render(LPDIRECT3DDEVICE9 device)
{
	D3DXMATRIXA16 trans;
//	Unit* unit;
	for(UnitListIterator it = this->active_units.begin(); it != this->active_units.end(); ++it)
	{
//		unit = (*it);
//		D3DXMatrixTranslation(&trans, unit->posx * this->tilesize, 0, unit->posy * this->tilesize);
//		device->SetTransform(D3DTS_WORLD, &trans);
		(*it)->render(device);
	}	
}

UnitMap::~UnitMap(void)
{
	delete this->unit_map;
}
