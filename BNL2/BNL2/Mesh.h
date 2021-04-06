#pragma once
#include "DirectXGraphics.h"

namespace bnl
{
	class Mesh : public Renderable
	{
	private:
		LPD3DXMESH			mesh;
		D3DMATERIAL9*		materials;
		LPDIRECT3DTEXTURE9*	textures;
		DWORD				NumMaterials;
		D3DXMATRIXA16		default_transformation;
		LPDIRECT3DDEVICE9	device;

		void InnerRender();

	public:
		Mesh(char* filename, LPDIRECT3DDEVICE9 device_);

		virtual void render(LPDIRECT3DDEVICE9 device);
		void Render(const D3DXVECTOR3& offset);
		void RenderAbsolute(const D3DXVECTOR3& position);

		D3DXMATRIXA16& GetDefaultTransformation();
		void SetDefaultTransformation(D3DXMATRIXA16& transformation);

		virtual ~Mesh(void);
	};
};