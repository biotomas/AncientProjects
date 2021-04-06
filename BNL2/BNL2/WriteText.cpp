#include "WriteText.h"

void WriteText::set_color(D3DCOLOR color)
{
	this->color = color;
}

void WriteText::set_font(int height, UINT width, char* facename)
{
	LPDIRECT3DDEVICE9 device = DirectXGraphics::getInstance()->getDevice();

	if(font)
		font->Release();
	font = NULL;
	D3DXCreateFont(device, height, width, FW_NORMAL, 1, false, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS,
		DEFAULT_QUALITY, FF_DONTCARE || DEFAULT_PITCH, facename, &font);
}

void WriteText::set_position(DWORD x, DWORD y)
{
	rect.left = x;
	rect.top = y;
	rect.right = x+1;
	rect.bottom = y+1;
}

void WriteText::set_text(std::string text)
{
	
	this->text = text;
}

void WriteText::render(LPDIRECT3DDEVICE9)
{
	font->DrawTextA(NULL, text.c_str(), -1, &rect, DT_NOCLIP, color);
}

WriteText::~WriteText(void)
{
	if (font)
		font->Release();
}
