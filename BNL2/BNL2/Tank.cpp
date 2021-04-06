#include "Tank.h"

float Tank::multiplier = 1.0f;

void Tank::update_position()
{
	DWORD now = timeGetTime();
	DWORD time = now - last_updated;
	if (last_updated == 0)
		time = 1;
	last_updated = now;
	// multiplier ~ time/10 and stable
	multiplier = ((90 * multiplier) + time) / 100.0f;
	/**/

/*	if (direction != orientation)
	{
		int sgn;
		if (orientation > direction)
			sgn = 1;
		else
			sgn = -1;

		direction += sgn * rtime * rotation_rate;
		if (direction - orientation < 0.1)
			direction = orientation;
		if (direction > D3DX_PI)
			direction = -D3DX_PI;
		if (direction < -D3DX_PI)
			direction = D3DX_PI;
	}	/**/
	direction = orientation;
	position.x += velocity * multiplier * sinf(direction);
	position.z += velocity * multiplier * cosf(direction);
	velocity -= multiplier * velocity * deacceleration;
}

void Tank::bounce(const D3DXVECTOR3 &obst_normal, float force)
{
	// obst is (x,0,y), add to position (-y, 0, x)
	position += multiplier * abs(force) * obst_normal;

	float obst_angle = atan2f(obst_normal.x, obst_normal.z);

	float absang = abs(obst_angle - orientation);
	if( absang >= D3DX_PI*0.5 && absang <= D3DX_PI*1.5 )
	{
		// backward
		velocity += cos(absang) * force;
		if(velocity < -speed_limit)
			velocity = -speed_limit;
	}
	else
	{
		// forward
		velocity += cos(absang) * force;
		if(velocity > speed_limit)
			velocity = speed_limit;
	}
}

void Tank::bounce_wall(const D3DXVECTOR3 &wall_normal)
{
	position += multiplier * abs(velocity) * wall_normal;
	velocity = - velocity;
	velocity /= 2;
}

float Tank::get_range()
{
	return velocity * multiplier;
}

void Tank::render(LPDIRECT3DDEVICE9 device)
{
	update_position();

	D3DXMATRIXA16 rotation, translation;
	D3DXMatrixRotationY(&rotation, orientation);
	D3DXMatrixTranslation(&translation, position.x, 0, position.z);
												// z is y
	device->SetTransform(D3DTS_WORLD, &(rotation*translation));
	tank_mesh->render(device);
}

void Tank::accelerate(float speed)
{
	if (velocity + speed > speed_limit)
		velocity = speed_limit;
	else if (velocity + speed  < -(speed_limit/2))
		velocity = -(speed_limit/2);
	else
		velocity += speed;
}

void Tank::brake_tank(float percent)
{
	velocity *= percent;
}

void Tank::steer(float angle)
{
	orientation+=angle;
	if (orientation > D3DX_PI)
		orientation = - D3DX_PI;
	else
		if (orientation < -D3DX_PI)
			orientation = D3DX_PI;
}

D3DXVECTOR3 Tank::get_position()
{
	return position;
}

D3DXVECTOR3 Tank::get_orientation()
{
	D3DXVECTOR3 orient;
	orient.x = sinf(orientation);
	orient.y = 0.0f;
	orient.z = cosf(orientation);

	return orient;
}

void Tank::set_position(D3DXVECTOR3& newpos)
{
	position = newpos;
}

float Tank::get_velocity()
{
	return velocity;
}

Tank::Tank(LPDIRECT3DDEVICE9 device, char* mesh_filename, D3DXVECTOR3 &position_)
{
	position = position_;
	velocity = 0;
	direction = 0;
	orientation = 0;

	rotation_rate = 0.01f;
	speed_limit = 0.2f;
	deacceleration = 0.005f;
	multiplier = 0.0f;

	tank_mesh = new bnl::Mesh(mesh_filename, device);

	last_updated = 0;
}

Tank::~Tank(void)
{
	if (tank_mesh)
		delete tank_mesh;
}
