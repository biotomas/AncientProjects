#pragma once
#include "directxgraphics.h"
#include "tank.h"
#include "mesh.h"

class Skybox
{
private:
	bnl::Mesh*		skybox_mesh;
public:
	Skybox(char* filename, LPDIRECT3DDEVICE9 device);
	virtual void render(LPDIRECT3DDEVICE9 device, const D3DXVECTOR3& position);
	virtual ~Skybox(void);
};
