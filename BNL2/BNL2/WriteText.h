#pragma once
#include "directxgraphics.h"
#include <string>

class WriteText :	public Renderable
{
private:
	std::string			text;
	D3DCOLOR			color;
	LPD3DXFONT			font;
	RECT				rect;

public:
	WriteText(void):font(NULL){}

	void set_text(std::string text);
	void set_color(D3DCOLOR color);
	void set_font(int height, UINT width, char* facename);
	void set_position(DWORD x, DWORD y);

	virtual void render(LPDIRECT3DDEVICE9);
	virtual ~WriteText(void);
};
