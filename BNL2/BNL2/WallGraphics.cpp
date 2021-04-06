#include "WallGraphics.h"
#include <assert.h>

struct CUSTOMVERTEX
{
    D3DXVECTOR3 position; // The position
    D3DCOLOR    color;    // The color
    FLOAT       tu, tv;   // The texture coordinates
};

#define D3DFVF_CUSTOMVERTEX (D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1)
#define D3DFVF_CUSTOMVERTEX2 (D3DFVF_XYZ|D3DFVF_DIFFUSE)


void WallGraphics::render(LPDIRECT3DDEVICE9 device)
{
    device->SetStreamSource( 0, pVB, 0, sizeof(CUSTOMVERTEX) );

	// render the walls around
	
	if (this->wall_height < 0)
	{
		device->SetRenderState( D3DRS_ALPHABLENDENABLE, TRUE );

		device->SetFVF( D3DFVF_CUSTOMVERTEX );
		device->SetTexture( 0, wall_texture );
		device->DrawPrimitive( D3DPT_TRIANGLESTRIP, 0, (UINT)wall_length-2);

		//render the top cover
		device->DrawPrimitive( D3DPT_TRIANGLEFAN, wall_length, cover_length-2);
		device->SetRenderState( D3DRS_ALPHABLENDENABLE, FALSE );
		return;
	}/**/
	device->SetFVF( D3DFVF_CUSTOMVERTEX );
	device->SetTexture( 0, wall_texture );
	device->DrawPrimitive( D3DPT_TRIANGLESTRIP, 0, (UINT)wall_length-2);

	//render the top cover
	device->DrawPrimitive( D3DPT_TRIANGLEFAN, wall_length, cover_length-2);
}

WallGraphics::WallGraphics(LPDIRECT3DDEVICE9 device, const char* texture_filename, 
						   float wall_height, points_vector& pts)
{
	cover_length = pts.size();
	wall_length = 2 * pts.size();
	this->wall_height = wall_height;

	if(FAILED(D3DXCreateTextureFromFile( device, texture_filename, &wall_texture)))
		MessageBox(NULL, "wall texture not found", "BNL2", MB_OK);

    device->CreateVertexBuffer( ( wall_length + cover_length )*sizeof(CUSTOMVERTEX), 
								0, D3DFVF_CUSTOMVERTEX, D3DPOOL_DEFAULT, &pVB, NULL );

	CUSTOMVERTEX* pVertices;
    if( FAILED( pVB->Lock( 0, 0, (void**)&pVertices, 0 ) ) )
	{
		assert("failed to lock the vertex buffer");     
		return;
	}

	size_t j=0;

	// the wall around
	for (size_t i = 0; i<wall_length; i+=2)
	{
		pVertices[i].position = D3DXVECTOR3(pts[j].x, 0, pts[j].y);
		pVertices[i+1].position = D3DXVECTOR3(pts[j].x, abs(wall_height), pts[j].y);

		pVertices[i].tv = 1.0f;
		pVertices[i+1].tv = 0.0f;
		if (j%2 == 0)
		{
			pVertices[i].tu = 1.0f;
			pVertices[i+1].tu = 1.0f;
		}
		else
		{
			pVertices[i].tu = 0.0f;
			pVertices[i+1].tu = 0.0f;
		}

		pVertices[i].color = 0xFFFFFFFF;
		pVertices[i+1].color = 0xFFFFFFFF;
		++j;
	}

	// the top cover
	j = 0;
	for (size_t i = wall_length; i<(wall_length+cover_length); i++)
	{
		pVertices[i].position = D3DXVECTOR3(pts[j].x, abs(wall_height), pts[j].y);
		pVertices[i].color = 0xFFFFFFFF;
		pVertices[i].tu = 0.0f;
		pVertices[i].tv = 0.0f;
		++j;
	}

	// the roof

	// ... not yet

	pVB->Unlock();
}

WallGraphics::~WallGraphics(void)
{
	if (pVB)
		pVB->Release();
}
