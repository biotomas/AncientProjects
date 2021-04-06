#pragma once
#include "MultiLayerTile.h"
#include "WallGraphics.h"
#include <map>
#include <vector>
#include "CollisionDetection.h"
	
class GameMap:public Renderable
{
private:
	typedef std::map<std::string, MultiLayerTile*> tile_map;
	typedef std::pair<std::string, MultiLayerTile*> map_pair;
	typedef std::vector<WallGraphics*> wall_vector;

	size_t				size_X;
	size_t				size_Y;
	float				tile_size;
	MultiLayerTile**	ground_map;
	tile_map			unique_tiles;
	wall_vector			walls;
	
public:
	// implementing the render functuion
	virtual void render(LPDIRECT3DDEVICE9 device);

	GameMap(void);
	void LoadMapFromFile(const char * filename);
	virtual ~GameMap(void);
};
