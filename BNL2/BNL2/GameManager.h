#pragma once

//#define DEBUG
#include "GameMap.h"
#include "Tank.h"
#include "UserInput.h"
#include "DirectXGraphics.h"
#include <list>
#include "Shot.h"
#include "WriteText.h"
#include <string>

const size_t NUM_PLAYERS = 2; //max players
const float STEER_ANGLE = 0.03f;
const float ACCELERATION = 0.02f;
const DWORD SHOT_TIME_DIST = 200;
const size_t STARTING_HP = 50; // starting hitpoints

enum CONTROLS
{
	CTRL_TURN_LEFT,
	CTRL_TURN_RIGHT,
	CTRL_FORWARD,
	CTRL_BACKWARD,
	CTRL_BRAKE,
	CTRL_FIRE,
	NUM_CONTROLS
};

enum GAMESTATE
{
	ST_GAME,
	ST_END,
	ST_START
};

typedef std::list<Shot*> Tshot_list;
typedef Tshot_list::iterator Tshot_iterator;

class ShotList : public Renderable
{
public:
	Tshot_list	shots;
	virtual void render(LPDIRECT3DDEVICE9);
	virtual ~ShotList(){}
};

class GameManager
{
private:
	class ExitGame: public InputAction
	{
	public:
		virtual void Perform_action(int x, int y);
	};
	class RestartGame: public InputAction
	{
	private:
		GameManager* manager;
	public:
		RestartGame(GameManager* my_manager);
		virtual void Perform_action(int x, int y);
	};

	class TankControl: public InputAction
	{
	protected:
		Tank*			my_tank;
		DWORD			lastshot;
	public:
		GameManager*	my_manager;
		void SetTank(Tank* tank);
		virtual void Perform_action(int x, int y) = 0;
	};

	class TurnLeft:	public TankControl	{public:virtual void Perform_action(int x, int y);};
	class TurnRight:public TankControl	{public:virtual void Perform_action(int x, int y);};
	class Forward:	public TankControl	{public:virtual void Perform_action(int x, int y);};
	class Backward:	public TankControl	{public:virtual void Perform_action(int x, int y);};
	class Brake:	public TankControl	{public:virtual void Perform_action(int x, int y);};
	class Fire:		public TankControl	{public:virtual void Perform_action(int x, int y);};

	LPDIRECT3DDEVICE9	gdevice;

	GameMap				actual_map;
	UserInput*			direct_input;

	size_t				num_players; // the real number of players
	Tank*				tank[NUM_PLAYERS];
	WriteText*			scores[NUM_PLAYERS];
	ShotList*			shots;
	GAMESTATE			state;
	// ending scene texts
	WriteText*			text_end;
	WriteText*			text_escape;


	void won(int player);

public:
	std::string			pl1_name;
	std::string			pl2_name;

	GameManager(HINSTANCE hInst, HWND hWnd /*, size_t num_players*/);

	void GameCycle();

	bool LoadLevel(const char* filename);
	bool AddTank(Tank* new_tank);
	void SetControl(size_t player, CONTROLS action, ICODE_CONSTANTS key);

	~GameManager(void);
};
