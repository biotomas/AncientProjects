#include <Windows.h>
#include <d3dx9.h>
#include "DirectXGraphics.h"
#include "Camera.h"
#include "GameMap.h"
#include "Tank.h"
#include "UserInput.h"
#include "GameManager.h"
#include "WriteText.h"
#include "Skybox.h"
#include <sstream>

DirectXGraphics *g;
GameManager* manager;

enum Control_mode
{
	wasd,
	arrows,
	numpad,
	gamepad
};

struct Parameters
{
	int				resolutionx;
	int				resolutiony;
	Control_mode	control1;
	Control_mode	control2;
	std::string		level;
	std::string		name1;
	std::string		name2;
	bool			fullscreen;
	ScreenType		mode;
};


void InitGame(Parameters& params)
{
	g->SetSkybox(new Skybox("graphics/skycube.x", g->getDevice()));

	manager->pl1_name = params.name1;
	manager->pl2_name = params.name2;

	Tank * tank = new Tank(g->getDevice(), "graphics/tank.x", D3DXVECTOR3(0,0,0) );
	manager->AddTank(tank);
	g->AddRenderable(tank);
	Camera* cam = new Camera();
	cam->FollowTank(tank);
	cam->SetDistHeight(6,1,1.5f);
	g->SetCamera(0, cam);

	tank = new Tank(g->getDevice(), "graphics/tank.x", D3DXVECTOR3(10,0,0));
	manager->AddTank(tank);
	g->AddRenderable(tank);
	cam = new Camera();
	cam->FollowTank(tank);
	cam->SetDistHeight(6,1,1.5f);
	g->SetCamera(1, cam);

	// after the tanks, tanks would not be visible through transp. walls
	if (false == manager->LoadLevel(params.level.c_str()))
		exit(0);

	switch(params.control1)
	{
	case wasd:
		manager->SetControl(0, CTRL_TURN_LEFT, (ICODE_CONSTANTS)DIK_A);
		manager->SetControl(0, CTRL_TURN_RIGHT, (ICODE_CONSTANTS)DIK_D);
		manager->SetControl(0, CTRL_FORWARD, (ICODE_CONSTANTS)DIK_W);
		manager->SetControl(0, CTRL_BACKWARD, (ICODE_CONSTANTS)DIK_S);
		manager->SetControl(0, CTRL_FIRE, (ICODE_CONSTANTS)DIK_TAB);
		manager->SetControl(0, CTRL_BRAKE, (ICODE_CONSTANTS)DIK_LSHIFT);
		break;
	case arrows:
		manager->SetControl(0, CTRL_TURN_LEFT, (ICODE_CONSTANTS)DIK_LEFT);
		manager->SetControl(0, CTRL_TURN_RIGHT, (ICODE_CONSTANTS)DIK_RIGHT);
		manager->SetControl(0, CTRL_FORWARD, (ICODE_CONSTANTS)DIK_UP);
		manager->SetControl(0, CTRL_BACKWARD, (ICODE_CONSTANTS)DIK_DOWN);
		manager->SetControl(0, CTRL_FIRE, (ICODE_CONSTANTS)DIK_RALT);
		manager->SetControl(0, CTRL_BRAKE, (ICODE_CONSTANTS)DIK_SPACE);
		break;
	case numpad:
		manager->SetControl(0, CTRL_TURN_LEFT, (ICODE_CONSTANTS)DIK_NUMPAD4);
		manager->SetControl(0, CTRL_TURN_RIGHT, (ICODE_CONSTANTS)DIK_NUMPAD6);
		manager->SetControl(0, CTRL_FORWARD, (ICODE_CONSTANTS)DIK_NUMPAD8);
		manager->SetControl(0, CTRL_BACKWARD, (ICODE_CONSTANTS)DIK_NUMPAD5);
		manager->SetControl(0, CTRL_FIRE, (ICODE_CONSTANTS)DIK_NUMPAD1);
		manager->SetControl(0, CTRL_BRAKE, (ICODE_CONSTANTS)DIK_NUMPAD0);
		break;
	case gamepad:
		manager->SetControl(0, CTRL_TURN_LEFT, ICODE_gamepad_left);
		manager->SetControl(0, CTRL_TURN_RIGHT, ICODE_gamepad_right);
		manager->SetControl(0, CTRL_FORWARD, ICODE_gamepad_up);
		manager->SetControl(0, CTRL_BACKWARD, ICODE_gamepad_down);
		manager->SetControl(0, CTRL_FIRE, ICODE_gamepad_button0);
		manager->SetControl(0, CTRL_BRAKE, ICODE_gamepad_button1);
		break;
	}
	switch(params.control2)
	{
	case wasd:
		manager->SetControl(1, CTRL_TURN_LEFT, (ICODE_CONSTANTS)DIK_A);
		manager->SetControl(1, CTRL_TURN_RIGHT, (ICODE_CONSTANTS)DIK_D);
		manager->SetControl(1, CTRL_FORWARD, (ICODE_CONSTANTS)DIK_W);
		manager->SetControl(1, CTRL_BACKWARD, (ICODE_CONSTANTS)DIK_S);
		manager->SetControl(1, CTRL_FIRE, (ICODE_CONSTANTS)DIK_TAB);
		manager->SetControl(1, CTRL_BRAKE, (ICODE_CONSTANTS)DIK_LSHIFT);
		break;
	case arrows:
		manager->SetControl(1, CTRL_TURN_LEFT, (ICODE_CONSTANTS)DIK_LEFT);
		manager->SetControl(1, CTRL_TURN_RIGHT, (ICODE_CONSTANTS)DIK_RIGHT);
		manager->SetControl(1, CTRL_FORWARD, (ICODE_CONSTANTS)DIK_UP);
		manager->SetControl(1, CTRL_BACKWARD, (ICODE_CONSTANTS)DIK_DOWN);
		manager->SetControl(1, CTRL_FIRE, (ICODE_CONSTANTS)DIK_RALT);
		manager->SetControl(1, CTRL_BRAKE, (ICODE_CONSTANTS)DIK_SPACE);
		break;
	case numpad:
		manager->SetControl(1, CTRL_TURN_LEFT, (ICODE_CONSTANTS)DIK_NUMPAD4);
		manager->SetControl(1, CTRL_TURN_RIGHT, (ICODE_CONSTANTS)DIK_NUMPAD6);
		manager->SetControl(1, CTRL_FORWARD, (ICODE_CONSTANTS)DIK_NUMPAD8);
		manager->SetControl(1, CTRL_BACKWARD, (ICODE_CONSTANTS)DIK_NUMPAD5);
		manager->SetControl(1, CTRL_FIRE, (ICODE_CONSTANTS)DIK_NUMPAD1);
		manager->SetControl(1, CTRL_BRAKE, (ICODE_CONSTANTS)DIK_NUMPAD0);
		break;
	case gamepad:
		manager->SetControl(1, CTRL_TURN_LEFT, ICODE_gamepad_left);
		manager->SetControl(1, CTRL_TURN_RIGHT, ICODE_gamepad_right);
		manager->SetControl(1, CTRL_FORWARD, ICODE_gamepad_up);
		manager->SetControl(1, CTRL_BACKWARD, ICODE_gamepad_down);
		manager->SetControl(1, CTRL_FIRE, ICODE_gamepad_button0);
		manager->SetControl(1, CTRL_BRAKE, ICODE_gamepad_button1);
		break;
	}

}


LRESULT WINAPI MsgProc( HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam )
{
    switch( msg )
    {
        case WM_DESTROY:
            PostQuitMessage( 0 );
            return 0;
    }
    return DefWindowProc( hWnd, msg, wParam, lParam );
}

void parse_parameters(Parameters& params, char* args)
{
	/*
	Order of the parameters:
		game_mode (0 | 1 | 2)
		player 1 name
		player 2 name
		game map
		resolution string
		fullscreen (0 | 1)
		pl 1 controls (0 | 1 | 2 | 3)
		pl 2 controls (0 | 1 | 2 | 3)
	*/
	std::stringstream ss(args);
	int val;

	ss >> val;
	switch(val)
	{
	case 0:
		params.mode = ST_SINGLE;
		break;
	case 1:
		params.mode = ST_SPLIT_VERTICAL;
		break;
	case 2:
		params.mode = ST_SPLIT_HORIZONTAL;
		break;
	}
	ss >> params.name1;
	ss >> params.name2;
	ss >> params.level;

	char x;
	ss >> params.resolutionx;
	ss >> x;
	ss >> params.resolutiony;

	ss >> val;
	params.fullscreen = true;
	if(val == 0)
		params.fullscreen = false;
	ss >> val;
	switch(val)
	{
	case 0:
		params.control1 = wasd;
		break;
	case 1:
		params.control1 = arrows;
		break;
	case 2:
		params.control1 = numpad;
		break;
	case 3:
		params.control1 = gamepad;
		break;
	}
	ss >> val;
	switch(val)
	{
	case 0:
		params.control2 = wasd;
		break;
	case 1:
		params.control2 = arrows;
		break;
	case 2:
		params.control2 = numpad;
		break;
	case 3:
		params.control2 = gamepad;
		break;
	}
}

INT WINAPI WinMain( HINSTANCE hInst, HINSTANCE, LPSTR argv, INT)
{
	Parameters params;
	parse_parameters(params, argv);

    // Register the window class
    WNDCLASSEX wc = { sizeof(WNDCLASSEX), CS_CLASSDC, MsgProc, 0L, 0L,
                      GetModuleHandle(NULL), NULL, NULL, NULL, NULL,
                      "BNL2", NULL };
	wc.hCursor = NULL;
    RegisterClassEx( &wc );

    // Create the application's window
    HWND hWnd = CreateWindow( "BNL2", "BNL2",
							WS_OVERLAPPEDWINDOW, 0, 0, 
							params.resolutionx, params.resolutiony,
                              NULL, NULL, wc.hInstance, NULL );

	g = DirectXGraphics::getInstance();

	DisplayParameters dsp;
	dsp.fullscreen = params.fullscreen;
	dsp.resolution_x = params.resolutionx;
	dsp.resolution_y = params.resolutiony;
	dsp.sctype = params.mode;

	if( SUCCEEDED( g->InitGraphics(hWnd, dsp) ))
    {
		manager = new GameManager(hInst, hWnd);
		InitGame(params);
        ShowWindow( hWnd, SW_SHOWDEFAULT );
        UpdateWindow( hWnd );

        // Enter the message loop
        MSG msg;

		// FPS ----------------------------------------
		WriteText tfps;
		DWORD dfps = timeGetTime();
		
		tfps.set_color(0xffffffff);
		tfps.set_position(300, 5);
		tfps.set_font(30, 20, "Arial");
		char *cfps = new char[50];
		g->AddRenderable(&tfps);
		/**/// FPS ------------------------------------

        ZeroMemory( &msg, sizeof(msg) );
		while( msg.message!=WM_QUIT )
        {
            if( PeekMessage( &msg, NULL, 0U, 0U, PM_REMOVE ) )
            {
                TranslateMessage( &msg );
                DispatchMessage( &msg );
            }
            else
			{
				tfps.set_text(itoa(dfps-timeGetTime(), cfps, 10));
				dfps = timeGetTime();
				manager->GameCycle();
				g->Render();
			}
        }
    }

	if(manager)
		delete manager;
	delete g;
    UnregisterClass( "BNL2", wc.hInstance );
    return 0;
}