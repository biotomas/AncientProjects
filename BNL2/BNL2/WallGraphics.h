#pragma once
#include "directxgraphics.h"
#include "CommonStructures.h"

class WallGraphics
{
private:
	size_t						wall_length; //num of faces of the wall
	size_t						cover_length; //num of vertices of the top cover of the wall
	float						wall_height;
	LPDIRECT3DVERTEXBUFFER9		pVB;		// Buffer to hold vertices
	LPDIRECT3DTEXTURE9			wall_texture; // Our wall texture


public:
	void render(LPDIRECT3DDEVICE9 device);

	WallGraphics(LPDIRECT3DDEVICE9 device, const char* texture_filename, 
				float wall_height, points_vector& pts);
	~WallGraphics(void);
};
