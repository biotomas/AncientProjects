#include "Selector.h"
#include <math.h>
struct SELECTORCUSTOMVERTEX
{
    FLOAT x, y, z;
    DWORD color;
};
#undef D3DFVF_CUSTOMVERTEX //custom vertex from multilayer tile
#define D3DFVF_CUSTOMVERTEX (D3DFVF_XYZ|D3DFVF_SPECULAR)

LPDIRECT3DVERTEXBUFFER9 pVB;			// vertex buffer

void Selector::LeftMouseDown(int x, int y)
{
	this->selected_panel_item = DownPanel::GetDefaultInstance()->PanelItemClicked(x, y);
	if(this->selected_panel_item >= 0)
		return;
	this->mousedown = true;
	D3DXVECTOR3 vec; 
	g->UnprojectToYPlane(float(x), float(y), &vec);
	this->box_x = vec.x;
	this->box_y = vec.z;
	this->box_size_x = 0.0f;
	this->box_size_y = 0.0f;

}

void Selector::LeftMouseUp(int , int )
{
	this->mousedown = false;
}

void Selector::RightMouse(int x, int y)
{
	g->UnprojectToYPlane(float(x), float(y), &this->order);
//	x = int(order.x/0.2f + 0.5f);
//	y = int(order.z/0.2f + 0.5f);	
}

void Selector::GetOrderLocation(const UnitMap* map, int& outx, int& outy)
{
	outx = int(order.x/map->tilesize + 0.5f);
	outy = int(order.z/map->tilesize + 0.5f);	
}

int Selector::GetSelectedPanelItem()
{
	return this->selected_panel_item;
}

void Selector::MouseMove(int x, int y)
{	
	if(mousedown)
	{
		D3DXVECTOR3 vec; 
		g->UnprojectToYPlane(float(x), float(y), &vec);
		this->box_size_x = vec.x - box_x;
		this->box_size_y = vec.z - box_y;
	}
	/**/

}

UnitList Selector::GetSelectedUnits(const UnitMap* map)
{
	UnitList ul;
	int x, y, lx, ly, dx, dy;
	x = int(this->box_x/map->tilesize);
	y = int(this->box_y/map->tilesize);
	lx = int(this->box_size_x/map->tilesize);
	ly = int(this->box_size_y/map->tilesize);
	if(lx >= 0) 
		dx = 1;
	else
		dx = -1;
	if(ly >= 0)
		dy = 1;
	else
		dy = -1;

	lx+=x+dx;
	ly+=y+dy;
	for(x; x != lx; x+=dx)
		for(int i = y; i != ly; i+=dy)
		{
			if(x < 0 || i < 0 || x >= map->sizex || i >= map->sizey)
				continue;
			if(map->unit_map[x+i*map->sizex] != NULL)
				ul.push_back(map->unit_map[x+i*map->sizex]);
		}

	return ul;
}

int Selector::InitSelectionBox(LPDIRECT3DDEVICE9 device)
{
	SELECTORCUSTOMVERTEX vertices[] = 
	{
		{ 0.0f, 0.05f, 1.0f, 0xFFFFFFFF },
		{ 1.0f, 0.05f, 1.0f, 0xFFFFFFFF },
		{ 1.0f, 0.05f, 0.0f, 0xFFFFFFFF },
		{ 0.0f, 0.05f, 0.0f, 0xFFFFFFFF },
		{ 0.0f, 0.05f, 1.0f, 0xFFFFFFFF },
	};
    if( FAILED( device->CreateVertexBuffer( 5*sizeof(SELECTORCUSTOMVERTEX),
                                                  0, D3DFVF_CUSTOMVERTEX,
                                                  D3DPOOL_DEFAULT, &pVB, NULL ) ) )
    {
        return E_FAIL;
    }
	void * vp;
	if (FAILED (pVB->Lock(0, sizeof(vertices), &vp, 0)))
		return E_FAIL;
	memcpy(vp, &vertices, sizeof(vertices));
	pVB->Unlock();
	return 0;
}

void Selector::render(LPDIRECT3DDEVICE9 device)
{
	if(pVB == NULL)
		InitSelectionBox(device);
	if(mousedown)
	{
		device->SetStreamSource(0, pVB, 0, sizeof(SELECTORCUSTOMVERTEX));
		device->SetFVF(D3DFVF_CUSTOMVERTEX);

		D3DXMATRIXA16 trans, scale;
		D3DXMatrixTranslation(&trans, box_x, 0, box_y);
		D3DXMatrixScaling(&scale, box_size_x, 1, box_size_y);
		device->SetTransform(D3DTS_WORLD, &(scale*trans));
		device->DrawPrimitive(D3DPT_LINESTRIP, 0, 4);
	}
}

Selector::Selector(void)
{
	pVB = NULL;
	this->mousedown = false;
	this->selected_panel_item = -1;
	g = DirectXGraphics::getInstance();
}

Selector::~Selector(void)
{
}
