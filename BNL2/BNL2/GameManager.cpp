#include "GameManager.h"
#include <assert.h>
#include <sstream>
#include "Camera.h"


void ShotList::render(LPDIRECT3DDEVICE9)
{
	Tshot_iterator it;
	it = this->shots.begin();
	for (it; it != this->shots.end(); ++it)
		(*it)->render();
}

void GameManager::ExitGame::Perform_action(int, int)
{
	PostQuitMessage(0);
}
GameManager::RestartGame::RestartGame(GameManager *my_manager)
{
	this->manager = my_manager;
}
void GameManager::RestartGame::Perform_action(int, int)
{
	if(manager->state == ST_GAME)
		return;

	// restarting the game
	DirectXGraphics* g = DirectXGraphics::getInstance();
	// set up the tanks
	manager->tank[0]->set_position(D3DXVECTOR3(0,0,0));
	manager->tank[1]->set_position(D3DXVECTOR3(10, 0, 0));
	// set tank hitpoints
	manager->tank[0]->hitpoints = STARTING_HP;
	manager->tank[1]->hitpoints = STARTING_HP;
	// clear the shots
	manager->shots->shots.clear();
	// remove ending writings
	g->RemoveRenderable(manager->text_end);
	g->RemoveRenderable(manager->text_escape);
	// write HP
	g->AddRenderable(manager->scores[0]);
	g->AddRenderable(manager->scores[1]);
	
	// restore cameras
	Camera* cam = new Camera();
	cam->FollowTank(manager->tank[0]);
	cam->SetDistHeight(6,1,1.5f);
	g->SetCamera(0, cam);

	cam = new Camera();
	cam->FollowTank(manager->tank[1]);
	cam->SetDistHeight(6,1,1.5f);
	g->SetCamera(1,cam);

	manager->state = ST_GAME;
}

void GameManager::TankControl::SetTank(Tank *tank)
{
	lastshot = 0;
	my_tank = tank;
}

/*
 **************************************
 *	controls						  *
 **************************************
*/
void GameManager::TurnLeft::Perform_action(int , int )
{
	my_tank->steer(-STEER_ANGLE);
}

void GameManager::TurnRight::Perform_action(int , int )
{
	my_tank->steer(+STEER_ANGLE);
}

void GameManager::Forward::Perform_action(int , int )
{
	my_tank->accelerate(+ACCELERATION);
}

void GameManager::Backward::Perform_action(int , int )
{
	my_tank->accelerate(-ACCELERATION);
}

void GameManager::Brake::Perform_action(int , int )
{
	my_tank->brake_tank(0.8f);
}

void GameManager::Fire::Perform_action(int , int )
{
	DWORD now = timeGetTime();

	if (now < lastshot+SHOT_TIME_DIST)
		return;

	lastshot = now;

	ShotParameters params;
	params.damage = 1;
	params.size = 0.3f;
	params.timeout = 300;
	params.velocity = 0.4f ;//+ abs(my_tank->get_velocity());

	D3DXVECTOR3 pos = my_tank->get_position();
	D3DXVECTOR3 orient = my_tank->get_orientation();

	pos += 3*orient;
	pos.y += 0.5f;
	Shot* ns = new Shot(pos,
						orient,
						params);
	my_manager->shots->shots.push_back(ns);	
}
/*
 **************************************
 *	end of controls					  *
 **************************************
 */



GameManager::GameManager(HINSTANCE hInst, HWND hWnd /*, size_t num_players*/)
{
	state = ST_GAME;
	num_players = 0;

	memset(tank, 0, NUM_PLAYERS*sizeof(Tank*));
	// init input
	direct_input = new UserInput(hInst, hWnd);
	InputAction *escape = new ExitGame();
	InputAction *restart = new RestartGame(this);

	direct_input->AddInputAction((ICODE_CONSTANTS)DIK_ESCAPE, escape);
	direct_input->AddInputAction((ICODE_CONSTANTS)DIK_R, restart);

	shots = new ShotList();
	shots->shots.clear();
	DirectXGraphics::getInstance()->AddRenderable(shots);

	// ending scene texts
	text_end = new WriteText();
	text_end->set_color(0xffff0000);
	text_end->set_font(100, 30, "Arial");
	text_end->set_position(20, 120);
	text_escape = new WriteText();
	text_escape->set_color(0xffff0000);
	text_escape->set_font(50, 20, "Arial");
	text_escape->set_position(20, 220);
	text_escape->set_text("escape to exit, r to restart");

}

void GameManager::won(int player)
{
	state = ST_END;
	DirectXGraphics* g = DirectXGraphics::getInstance();

	std::stringstream ss;
	ss << "The Winner is ";
	if(player == 0)
		ss << pl1_name;
	else
		ss << pl2_name;
	text_end->set_text(ss.str());

	g->AddRenderable(text_end);
	g->AddRenderable(text_escape);
	
	Camera* ending_cam1 = new Camera();
	Camera* ending_cam2 = new Camera();

	ending_cam1->SetCameraExplicit(D3DXVECTOR3(-25, 25, -25), D3DXVECTOR3(0, 0, 0));
	ending_cam2->SetCameraExplicit(D3DXVECTOR3(25, 25, 25), D3DXVECTOR3(0, 0, 0));

	g->SetCamera(0, ending_cam1);
	g->SetCamera(1, ending_cam2);
	g->RemoveRenderable(scores[0]);
	g->RemoveRenderable(scores[1]);
}

void GameManager::GameCycle()
{
	direct_input->CollectInput(id_keyboard);
	direct_input->CollectInput(id_gamepad);

	if (state == ST_GAME)
	{
		if (tank[0]->hitpoints == 0)
			won(1);
		if (tank[1]->hitpoints == 0)
			won(0);
	}

	size_t i;
	D3DXVECTOR3 pos_shot, pos_tank, normal;
	float range =  max(tank[0]->get_range(), tank[1]->get_range());
	// tank vs tank collision
	if ( D3DXVec3LengthSq( &(tank[0]->get_position() - tank[1]->get_position()) ) < 2+range)
	{
		normal = tank[0]->get_position() - tank[1]->get_position();
		D3DXVec3Normalize(&normal, &normal);
		float v0 = tank[0]->get_velocity();
		tank[0]->bounce(normal, tank[1]->get_velocity());
		tank[1]->bounce(-normal, v0);
	}

	// tank vs wall
	pos_tank = tank[0]->get_position();
	if (global_collision_detector.collide(normal, Fpoint(pos_tank.x, pos_tank.z)))
		tank[0]->bounce_wall(normal);
	pos_tank = tank[1]->get_position();
	if (global_collision_detector.collide(normal, Fpoint(pos_tank.x, pos_tank.z)))
		tank[1]->bounce_wall(normal);

	// shots
	Tshot_iterator it;
	for(it = shots->shots.begin(); it != shots->shots.end(); )
	{
		Shot* ps = *it;
		if (ps->is_active())
		{
			ps->update_position();
			ps->get_position(pos_shot);

			// shot vs walls collision
			Fpoint fp(pos_shot.x, pos_shot.z);
			if (global_collision_detector.collide(normal, fp))
			{
				ps->bounce(normal);
				continue;
			}
			// shot vs tank collision
			for(i = 0; i < num_players; i++)
			{
				pos_tank = tank[i]->get_position();
				if (D3DXVec3LengthSq(&(pos_shot- pos_tank)) < 2)
				{
					ps->deactivate();
					tank[i]->hitpoints -= ps->get_damage();
				}
			}
			++it;
		}
		else
			it = shots->shots.erase(it);
	}

	std::stringstream ss;
	ss << pl1_name << ": " << tank[0]->hitpoints;
	scores[0]->set_text(ss.str());
	std::stringstream ss2;
	ss2 << pl2_name << ": " << tank[1]->hitpoints;
	scores[1]->set_text(ss2.str());
	/**/
}

bool GameManager::AddTank(Tank *new_tank)
{
	if (num_players < NUM_PLAYERS)
	{
		new_tank->hitpoints = STARTING_HP;
		tank[num_players] = new_tank;
		scores[num_players] = new WriteText();
		scores[num_players]->set_color(0xffffff00);
		scores[num_players]->set_font(20, 10, "Arial");
		scores[num_players]->set_position(5, num_players*20+5);
		DirectXGraphics::getInstance()->AddRenderable(scores[num_players]);		
		
		num_players++;
		return true;
	}
	else
		return false;
}

bool GameManager::LoadLevel(const char *filename)
{
	actual_map.LoadMapFromFile(filename);

	return true;
}

void GameManager::SetControl(size_t player, CONTROLS action, ICODE_CONSTANTS key)
{
	if (player < num_players)
	{
		TankControl* tptr = 0;
		switch(action)
		{
		case CTRL_TURN_LEFT:
			tptr = new TurnLeft();
			break;
		case CTRL_TURN_RIGHT:
			tptr = new TurnRight();
			break;
		case CTRL_FORWARD:
			tptr = new Forward();
			break;
		case CTRL_BACKWARD:
			tptr = new Backward();
			break;
		case CTRL_FIRE:
			tptr = new Fire();
			break;
		case CTRL_BRAKE:
			tptr = new Brake();
			break;
		}
		assert(tptr);
		tptr->SetTank(tank[player]);
		tptr->my_manager = this;
		direct_input->AddInputAction(key, tptr);
	}
}

GameManager::~GameManager()
{
	size_t i;
	if(direct_input)
		delete direct_input;
	if (shots)
	{
		DirectXGraphics::getInstance()->RemoveRenderable(shots);
		delete shots;
	}
	// otazne ci sa maju tanky dealokovat tu
	for (i = 0; i < num_players; i++)
		if (tank[i])
			delete tank[i];
}
