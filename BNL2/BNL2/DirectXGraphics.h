#pragma once
#include <d3dx9.h>
#include <list>
#include <vector>
#include <algorithm>

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


class DirectXGraphics
	//singleton
{
	friend class Camera;
private:
	typedef std::list<Renderable*>			RenderableList;
	typedef RenderableList::iterator		RenderableListIterator;

	RenderableList							renderables;
	LPDIRECT3DDEVICE9						g_pd3dDevice;
	LPDIRECT3D9								g_pD3D;
	D3DPRESENT_PARAMETERS					present_parameters;
	static DirectXGraphics*					instance;
	bool									split_screen;
	D3DVIEWPORT9							screen1;
	D3DVIEWPORT9							screen2;
	Camera*									camera1;
	Camera*									camera2;
	Skybox*									my_skybox;

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
	void SetSkybox(Skybox* skb);

	void Render();

	~DirectXGraphics(void);
};
