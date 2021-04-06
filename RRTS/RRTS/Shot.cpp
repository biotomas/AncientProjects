#include "Shot.h"


Shot::Shot(D3DXVECTOR3 from, D3DXVECTOR3 to, float speed)
{
	this->speed = speed;
	this->from = from;
	this->diff = to - from;
	this->active = true;
	this->start_time = timeGetTime();
}

bool Shot::IsActive()
{
	return this->active;
}

const D3DXVECTOR3* Shot::GetActualPosition(DWORD time)
{
	DWORD time_elapsed = time - this->start_time;
	if(time_elapsed*this->speed > 1.0f)
	{
		this->active = false;
		return &this->position;
	}
	this->position = this->from + time_elapsed*this->speed*this->diff;
	return &this->position;
}

Shot::~Shot(void)
{
}

void ShotManager::AddShot(Shot *newshot)
{
	this->shots.push_back(newshot);
	int jano = this->shots.size();
}

ShotManager::ShotManager()
{
	this->shot_mesh = NULL;
}

ShotManager::~ShotManager()
{
	if(this->shot_mesh)
		delete this->shot_mesh;
}

void ShotManager::render(LPDIRECT3DDEVICE9 device)
{
	ShotList::iterator it;
	DWORD time = timeGetTime();
	const D3DXVECTOR3* pos;

	if(this->shot_mesh == NULL)
	{
		this->shot_mesh = new rts::Mesh("ball.x", device);
	}

	for(it = this->shots.begin(); it!=this->shots.end(); ++it)
	{
		if((*it)->IsActive())
		{
			pos = (*it)->GetActualPosition(time);
			this->shot_mesh->RenderAbsolute(UNIT_TILESIZE*(*pos));			
		}
		else
		{
			delete (*it);
			it = this->shots.erase(it);
			if(it == this->shots.end())
				break;
		}
	}
}

ShotManager* ShotManager::default_instance = NULL;

ShotManager* ShotManager::GetDefaultInstance()
{
	if(default_instance == NULL)
		default_instance = new ShotManager();
	return default_instance;
}