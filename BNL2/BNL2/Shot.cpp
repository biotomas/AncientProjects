#include "Shot.h"

Mesh* Shot::ball_mesh = NULL;
LPDIRECT3DDEVICE9 Shot::device = NULL;

Shot::Shot(D3DXVECTOR3 &position, D3DXVECTOR3 &direction, ShotParameters &parameters)
{
	if (this->device == 0)
		device = DirectXGraphics::getInstance()->getDevice();

	this->position = position;
	this->direction = direction;
//	D3DXVec3Normalize(&this->direction, &this->direction);
	this->parameters = parameters;
	this->active = true;

	if (ball_mesh == NULL)
	{
		ball_mesh = new Mesh("graphics\\ball.x", this->device);
	}
}

void Shot::deactivate()
{
	this->active = false;
}

size_t Shot::get_damage()
{
	return this->parameters.damage;
}

void Shot::bounce(const D3DXVECTOR3 &obstruction_normal)
{
	// !!!!!!!!!!!!!
	float a,b,c,d;
	a = obstruction_normal.x;
	b = obstruction_normal.z;
	c = direction.x;
	d = direction.z;

	float s1 = (c*b)+(d*-a);
	float s2 = -((a*c)+(b*d));
		
	direction.x = s1*b + s2*a;
	direction.z = s1*-a + s2*b;
//	direction.y = 0;
//	D3DXVec3Normalize(&direction, &direction);
}

bool Shot::is_active()
{
	return active;
}

void Shot::render()
{
	D3DXMATRIXA16 scale;
	D3DXMATRIXA16 translation;

	D3DXMatrixScaling(&scale, parameters.size, parameters.size, parameters.size);
	D3DXMatrixTranslation(&translation, position.x, position.y, position.z);

	device->SetTransform(D3DTS_WORLD, &(scale * translation));
	ball_mesh->render(device);
}

void Shot::update_position()
{
	if (!active)
		return;
	parameters.timeout--;
	if (parameters.timeout <= 1)
	{
		active = false;
		return;
	}

	position += parameters.velocity * direction;
}

D3DXVECTOR3& Shot::get_position(D3DXVECTOR3 &position) const
{
	position = this->position;
	return position;
}

Shot::~Shot(void)
{
}
