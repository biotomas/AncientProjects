#pragma once
#include "Tank.h"
#include <d3dx9.h>

class Camera
{
private:
	D3DXVECTOR3			vEyePt;
    D3DXVECTOR3			vLookatPt;
    D3DXVECTOR3			vUpVec;
	LPDIRECT3DDEVICE9	mydevice;
	Tank*				mytank;
	float				dist;
	float				cam_height;
	float				look_height;

public:
	Camera();
	//set camera explicitly
	void SetCameraExplicit(D3DXVECTOR3& eyept, D3DXVECTOR3& lookatpt, D3DXVECTOR3& upvec = D3DXVECTOR3(0.0f, 1.0f, 0.0f));
	//set this camera as the actual camera
	void ActivateThisCamera();

	void UpdateCamera();
	void FollowTank(Tank* tank);
	void SetDistHeight(float dist, float cam_height, float look_height);

	const D3DXVECTOR3& get_position();
	
	//after the following functions call ActivateThisCamera to aply changes

	//move eye point and lookat point
	void MoveCamera(D3DXVECTOR3& move);
	~Camera(void);
};
