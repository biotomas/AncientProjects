#pragma once
#include <d3dx9.h>
#include <list>
#include <vector>
#include <algorithm>
#include "CONSTANTS.h"

class Camera;
class Skybox;

class Renderable 
	//interface
{
public:
	virtual void render(LPDIRECT3DDEVICE9 device) = NULL;
	virtual ~Renderable()
	{}
};

class Sprite
	//interface
{
public:
	virtual void render(LPD3DXSPRITE spritedevice) = NULL;
	virtual ~Sprite()
	{}
};

//class Sprite

enum ScreenType
{
	ST_SINGLE,
	ST_SPLIT_VERTICAL,
	ST_SPLIT_HORIZONTAL
};

struct DisplayParameters
{
	bool		fullscreen;
	size_t		resolution_x;
	size_t		resolution_y;
	ScreenType	sctype;
};

typedef LPDIRECT3DTEXTURE9 TexturePtr;


class DirectXGraphics
	//singleton
{
	friend class Camera;
private:
	typedef std::list<Renderable*>			RenderableList;
	typedef RenderableList::iterator		RenderableListIterator;
	typedef std::list<Sprite*>				SpriteList;
	typedef SpriteList::iterator			SpriteListIterator;

	SpriteList								sprites;
	RenderableList							renderables;
	LPDIRECT3DDEVICE9						g_pd3dDevice;
	LPD3DXSPRITE							sprite_device;
	LPDIRECT3D9								g_pD3D;
	D3DPRESENT_PARAMETERS					present_parameters;
	static DirectXGraphics*					instance;
	bool									split_screen;
	D3DVIEWPORT9							screen1;
	D3DVIEWPORT9							screen2;
	Camera*									camera1;
	Camera*									camera2;
	Skybox*									my_skybox;
	D3DXMATRIXA16							matProj; //projection matrix
	int										resolutionx, resolutiony;

	DirectXGraphics(void);
	// Set the world matrix to identity
	void ResetWorldMatrix();

public:
	LPDIRECT3DDEVICE9 getDevice();
	static DirectXGraphics* getInstance();
	HRESULT InitGraphics(HWND hWnd, DisplayParameters& dsp);

	// Add, remove a renderable object
	void SetCamera(int i, Camera* cam);
	void AddRenderable(Renderable* robject);
	void RemoveRenderable(Renderable* robject);
	void AddSprite(Sprite* sprite);
	void RemoveSprite(Sprite* sprite);
	void SetSkybox(Skybox* skb);

	D3DXVECTOR3* UnprojectToYPlane(float screen_x, float screen_y, D3DXVECTOR3* output);
	D3DXVECTOR3* Project(D3DXVECTOR3* out, D3DXVECTOR3 in);
	TexturePtr LoadTexture(char* filename, UINT width=0, UINT height=0);

	int GetScreenSizeX(void);
	int GetScreenSizeY(void);

	void Render();

	~DirectXGraphics(void);
};
