#include "Skybox.h"

Skybox::Skybox(char *filename, LPDIRECT3DDEVICE9 device)
{
	this->skybox_mesh = new bnl::Mesh(filename, device);
}

void Skybox::render(LPDIRECT3DDEVICE9 device, const D3DXVECTOR3& position)
{
	this->skybox_mesh->RenderAbsolute(position);
	// clear the z-buffer
	device->Clear(0,0, D3DCLEAR_ZBUFFER, 0, 1, 0);
}
Skybox::~Skybox(void)
{
	if(this->skybox_mesh)
		delete this->skybox_mesh;
}
