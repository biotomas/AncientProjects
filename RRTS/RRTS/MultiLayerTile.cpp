#include "MultiLayerTile.h"



void MultiLayerTile::render(LPDIRECT3DDEVICE9 device)
{
    device->SetStreamSource( 0, pVB, 0, sizeof(CUSTOMVERTEX) );
    device->SetFVF( D3DFVF_CUSTOMVERTEX );
	for (size_t i = 0; i<tile_layers; i++)
		if(pTextures[i])
		{			
			device->SetTexture( 0, pTextures[i] );
			device->DrawPrimitive( D3DPT_TRIANGLESTRIP, 0, 2 );
		}
}

size_t MultiLayerTile::GetNumLayers()
{
	return tile_layers;
}

void MultiLayerTile::SetLayer(size_t layer, const char* filename)
{
	if (layer < 0 || layer >= tile_layers)
		return;

    if(FAILED(D3DXCreateTextureFromFile( my_device, filename, &(pTextures[layer]))))
		MessageBox(NULL, "tile texture not found", "BNL2", MB_OK);
	TexturesToRelease.push_back(pTextures[layer]);
}

void MultiLayerTile::SetLayer(size_t layer, LPDIRECT3DTEXTURE9 texture)
{
	if (layer < 0 || layer >= tile_layers)
		return;
	pTextures[layer] = texture;
}

MultiLayerTile::MultiLayerTile(LPDIRECT3DDEVICE9 device, float size, size_t layers)
{
	my_device = device;
	tile_size = size;
	tile_layers = layers;

	pTextures = new LPDIRECT3DTEXTURE9[tile_layers];
	memset(pTextures, 0, tile_layers*sizeof(LPDIRECT3DTEXTURE9));

    device->CreateVertexBuffer( 4*sizeof(CUSTOMVERTEX), 0, D3DFVF_CUSTOMVERTEX,
                                                  D3DPOOL_DEFAULT, &pVB, NULL );

	CUSTOMVERTEX* pVertices;
    if( FAILED( pVB->Lock( 0, 0, (void**)&pVertices, 0 ) ) )
        return;

	pVertices[0].position = D3DXVECTOR3(0.0f, 0.0f, size);
	pVertices[1].position = D3DXVECTOR3(size, 0.0f, size);
	pVertices[2].position = D3DXVECTOR3(0.0f, 0.0f, 0.0f);
	pVertices[3].position = D3DXVECTOR3(size, 0.0f, 0.0f);
/*
	pVertices[0].position = D3DXVECTOR3(-half, 0.0f, +half);
	pVertices[1].position = D3DXVECTOR3(+half, 0.0f, +half);
	pVertices[2].position = D3DXVECTOR3(-half, 0.0f, -half);
	pVertices[3].position = D3DXVECTOR3(+half, 0.0f, -half);
*/
	pVertices[0].color = 0xffffffff;
	pVertices[1].color = 0xffffffff;
	pVertices[2].color = 0xffffffff;
	pVertices[3].color = 0xffffffff;

	pVertices[0].tu = 0.0f;
	pVertices[0].tv = 0.0f;
	pVertices[1].tu = 1.0f;
	pVertices[1].tv = 0.0f;
	pVertices[2].tu = 0.0f;
	pVertices[2].tv = 1.0f;
	pVertices[3].tu = 1.0f;
	pVertices[3].tv = 1.0f;

    pVB->Unlock();
}

MultiLayerTile::~MultiLayerTile(void)
{
	if(pVB)
		pVB->Release();
	for(TexturesList::iterator it = TexturesToRelease.begin(); it != TexturesToRelease.end(); ++it)
		(*it)->Release();
	delete [] pTextures;
}
