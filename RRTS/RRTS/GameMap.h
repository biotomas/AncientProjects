#pragma once
#include "MultiLayerTile.h"
#include <map>
#include <vector>

class SyntaxErrorException : std::exception {};
class LexicalErrorException : std::exception {};
class FileNotFoundException : std::exception {};
	
class GameMap:public Renderable
{
private:
	typedef std::map<std::string,  LPDIRECT3DTEXTURE9> TextureMap;
	typedef std::pair<std::string, LPDIRECT3DTEXTURE9> TexturePair;
//	std::m
 
	int				size_X;
	int				size_Y;
	int				layers;
	float				tile_size;
	MultiLayerTile**	ground_map;
//	tile_map			unique_tiles;
	TextureMap			textures;
	
public:
	// implementing the render functuion
	virtual void render(LPDIRECT3DDEVICE9 device);

	GameMap(void);
	void LoadMapFromFile(const char * filename, LPDIRECT3DDEVICE9 device);
	virtual ~GameMap(void);
};
