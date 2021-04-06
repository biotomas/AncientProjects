#pragma once
#include "directxgraphics.h"
#include "mesh.h"

class Skybox
{
private:
	rts::Mesh*		skybox_mesh;
public:
	Skybox(char* filename, LPDIRECT3DDEVICE9 device);
	virtual void render(LPDIRECT3DDEVICE9 device, const D3DXVECTOR3& position);
	virtual ~Skybox(void);
};
