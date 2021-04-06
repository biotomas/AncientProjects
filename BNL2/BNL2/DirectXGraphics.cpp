#include "DirectXGraphics.h"
#include <assert.h>
#include "Camera.h"
#include "Skybox.h"

void DirectXGraphics::ResetWorldMatrix()
{
	D3DXMATRIXA16 id;
	D3DXMatrixIdentity(&id);
	g_pd3dDevice->SetTransform(D3DTS_WORLD, &id);
}

DirectXGraphics::DirectXGraphics()
{
	camera1 = NULL;
	camera2 = NULL;
	g_pd3dDevice = NULL;
}

DirectXGraphics* DirectXGraphics::instance = NULL;

LPDIRECT3DDEVICE9 DirectXGraphics::getDevice()
{
	return g_pd3dDevice;
}

DirectXGraphics* DirectXGraphics::getInstance()
{
	if (instance == NULL)
		instance = new DirectXGraphics();
	return instance;
}

void DirectXGraphics::SetSkybox(Skybox *skb)
{
	my_skybox = skb;
}

void DirectXGraphics::SetCamera(int i, Camera* cam)
{
	if (i == 0)
	{
		if (camera1 != NULL)
			delete camera1;
		camera1 = cam;
	}
	if (i == 1)
	{
		if (camera2 != NULL)
			delete camera2;
		camera2 = cam;
	}
}

HRESULT DirectXGraphics::InitGraphics(HWND hWnd, DisplayParameters& dsp)
{
    if( NULL == ( g_pD3D = Direct3DCreate9( D3D_SDK_VERSION ) ) )
        return E_FAIL;

    ZeroMemory( &present_parameters, sizeof(present_parameters) );
	
	RECT rect;
	GetClientRect(hWnd, &rect);

	D3DDISPLAYMODE mode;
	g_pD3D->GetAdapterDisplayMode(D3DADAPTER_DEFAULT, &mode);

	present_parameters.Windowed     = true;
	present_parameters.BackBufferFormat   = mode.Format;
	present_parameters.BackBufferCount   = 1;
	present_parameters.SwapEffect    = D3DSWAPEFFECT_DISCARD;
	present_parameters.EnableAutoDepthStencil = true; 
	present_parameters.AutoDepthStencilFormat = D3DFMT_D24S8;
	present_parameters.Flags     = 0;
	present_parameters.hDeviceWindow   = hWnd;

	if(dsp.fullscreen)
	{
		present_parameters.Windowed     = false;
		present_parameters.BackBufferWidth = dsp.resolution_x;
		present_parameters.BackBufferHeight = dsp.resolution_y;
	}

	HRESULT hr;
	if( FAILED(hr = g_pD3D->CreateDevice( D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, hWnd,
                                      D3DCREATE_SOFTWARE_VERTEXPROCESSING,
                                      &present_parameters, &g_pd3dDevice ) ) )
    {
        return E_FAIL;
    }

	split_screen = false;
	float aspect = 1.0f;

	if (dsp.sctype != ST_SINGLE)
	{
		size_t width;
		size_t height;
		split_screen = true;
		if(dsp.fullscreen)
		{
			width = dsp.resolution_x;
			height = dsp.resolution_y;
		}
		else
		{
			RECT rect;
			GetClientRect(hWnd, &rect);
			width = rect.right - rect.left;
			height = rect.bottom - rect.top;
		}

		screen1.MinZ = 0.0f;
		screen1.MaxZ = 1.0f;
		screen2.MinZ = 0.0f;
		screen2.MaxZ = 1.0f;

		if(dsp.sctype == ST_SPLIT_VERTICAL)
		{
			screen1.X = 0;
			screen1.Width = width/2;
			screen1.Y = 0;
			screen1.Height = height;

			screen2.X = width/2;
			screen2.Width = width/2;
			screen2.Y = 0;
			screen2.Height = height;

			aspect = 0.5f;
		}
		else if (dsp.sctype == ST_SPLIT_HORIZONTAL)
		{
			screen1.X = 0;
			screen1.Width = width;
			screen1.Y = 0;
			screen1.Height = height/2;
			
			screen2.X = 0;
			screen2.Width = width;
			screen2.Y = height/2;
			screen2.Height = height/2;

			aspect = 2.0f;
		}
	}
    // Turn off culling
    g_pd3dDevice->SetRenderState( D3DRS_CULLMODE, D3DCULL_NONE );

    // Turn on the zbuffer
    g_pd3dDevice->SetRenderState( D3DRS_ZENABLE, TRUE );

	g_pd3dDevice->SetRenderState(D3DRS_LIGHTING, false);

	// Set up projection matrix
    D3DXMATRIXA16 matProj;
    D3DXMatrixPerspectiveFovLH( &matProj, D3DX_PI/4, aspect, 1.0f, 300.0f );
    g_pd3dDevice->SetTransform( D3DTS_PROJECTION, &matProj );


	// Turn on ambient lightning
//    g_pd3dDevice->SetRenderState( D3DRS_AMBIENT, 0xFFFFFFFF );

	// Turn on alpha blending - we need this for multiple layer tiles
	g_pd3dDevice->SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
	g_pd3dDevice->SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);
	
	// set the timer resolution to 1 milisecond - used with timeGetTime()
//	MMRESULT res = timeBeginPeriod(1);
//	assert(res == TIMERR_NOERROR && "timer resolution setting error");
	return S_OK;
}

DirectXGraphics::~DirectXGraphics(void)
{
    if( g_pd3dDevice != NULL )
        g_pd3dDevice->Release();

    if( g_pD3D != NULL )
        g_pD3D->Release();

	if (my_skybox != NULL)
		delete my_skybox;
}

void DirectXGraphics::AddRenderable(Renderable *robject)
{
	renderables.push_back(robject);
}

void DirectXGraphics::RemoveRenderable(Renderable *robject)
{
	renderables.remove(robject);
}

void DirectXGraphics::Render()
{
	HRESULT hr;

	if (split_screen == false)
	{
		camera2->UpdateCamera();
		camera2->ActivateThisCamera();
		g_pd3dDevice->Clear( 0, NULL, D3DCLEAR_TARGET|D3DCLEAR_ZBUFFER, 0, 1.0f, 0 );
		// Begin the scene
		if( SUCCEEDED( g_pd3dDevice->BeginScene() ) )
		{
			my_skybox->render(g_pd3dDevice, camera2->get_position());
			RenderableListIterator it;
			for(it = renderables.begin(); it != renderables.end(); ++it)
			{
				ResetWorldMatrix();
				(*it)->render(g_pd3dDevice);
			}
			// End the scene
			g_pd3dDevice->EndScene();
		}

		// Present the backbuffer contents to the display
		hr = g_pd3dDevice->Present( NULL, NULL, NULL, NULL );
	}
	else
	{
		// render the first half
		g_pd3dDevice->SetViewport(&screen1);
		g_pd3dDevice->Clear( 0, NULL, D3DCLEAR_TARGET|D3DCLEAR_ZBUFFER, 0, 1.0f, 0 );
		if( SUCCEEDED( g_pd3dDevice->BeginScene() ) )
		{
			my_skybox->render(g_pd3dDevice, camera2->get_position());
			RenderableListIterator it;
			for(it = renderables.begin(); it != renderables.end(); ++it)
			{
				ResetWorldMatrix();
				(*it)->render(g_pd3dDevice);
			}
			g_pd3dDevice->EndScene();
		}
		//hr = g_pd3dDevice->Present( NULL, NULL, NULL, NULL );
		camera1->UpdateCamera();
		camera1->ActivateThisCamera();

		// render the second half;
		g_pd3dDevice->SetViewport(&screen2);
		g_pd3dDevice->Clear( 0, NULL, D3DCLEAR_TARGET|D3DCLEAR_ZBUFFER, 0, 1.0f, 0 );
		if( SUCCEEDED( g_pd3dDevice->BeginScene() ) )
		{
			my_skybox->render(g_pd3dDevice, camera1->get_position());
			RenderableListIterator it;
			for(it = renderables.begin(); it != renderables.end(); ++it)
			{
				ResetWorldMatrix();
				(*it)->render(g_pd3dDevice);
			}
			g_pd3dDevice->EndScene();
		}
		camera2->UpdateCamera();
		camera2->ActivateThisCamera();
		hr = g_pd3dDevice->Present( NULL, NULL, NULL, NULL );

	}
}