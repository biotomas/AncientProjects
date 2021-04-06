#pragma once
#include "directxgraphics.h"
#include <list>

struct CUSTOMVERTEX
{
    D3DXVECTOR3 position; // The position
    D3DCOLOR    color;    // The color
    FLOAT       tu, tv;   // The texture coordinates
};

#define D3DFVF_CUSTOMVERTEX (D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1)
	
class MultiLayerTile
{
private:
	typedef std::list<LPDIRECT3DTEXTURE9> TexturesList;

	float						tile_size;
	size_t						tile_layers;
	LPDIRECT3DVERTEXBUFFER9		pVB;		// Buffer to hold vertices
	LPDIRECT3DTEXTURE9*			pTextures; // Our textures (layers)
	LPDIRECT3DDEVICE9			my_device;
	TexturesList				TexturesToRelease;

public:
	void render(LPDIRECT3DDEVICE9 device);

	size_t GetNumLayers();
	void SetLayer(size_t layer, const char* filename);
	void SetLayer(size_t layer, LPDIRECT3DTEXTURE9 texture);

	MultiLayerTile(LPDIRECT3DDEVICE9 device, float size = 1.0f, size_t layers = 4);
	~MultiLayerTile(void);
};
