#define _CRT_SECURE_NO_WARNINGS 
#include "GameMap.h"
#include <stdio.h>
#include <ctype.h>
#include <string>

const int BUFFSIZE = 500;

enum tokens
{
	LAYERS,
	SIZEX,
	SIZEY,
	TILE,
	STRING,
	LAYER,
	NUMBER,
	SEMICOLON,
	ENDOFFILE
};

struct token
{
	tokens		type;
	int			value;
	char*		content;
};

token GetNextToken(FILE* f)
{
	static int k = 0;
	static char* buffer = NULL;
	if(buffer == NULL)
		buffer = new char[BUFFSIZE];
	int pos = 0;
	token retval;
	retval.content=0;

	if(k==0)
		k = fgetc(f);

	// skip white characters
	while(k == ' ' || k == '\t' || k == '\n')
		k = fgetc(f);
	if(k == ';')
	{
		retval.type = SEMICOLON;
		k = fgetc(f);
		return retval;
	}
	if(EOF == k)
	{
		retval.type = ENDOFFILE;
		delete [] buffer;
		buffer = NULL;
		return retval;
	}
	while(isalnum(k) || k == '.' || k == ':' || k == '\\' || k == '/' || k == '-' || k == '_')
	{
		buffer[pos] = (char)k;
		k = fgetc(f);
		pos++;
	}
	buffer[pos] = 0; //null terminated string

	if(strcmp("layers", buffer)==0)
		retval.type = LAYERS;
	else if(strcmp("sizex", buffer)==0)
		retval.type = SIZEX;
	else if(strcmp("sizey", buffer)==0)
		retval.type = SIZEY;
	else if(strcmp("tile", buffer)==0)
		retval.type = TILE;
	else if(strcmp("layer", buffer)==0)
		retval.type = LAYER;
	else if(isdigit(buffer[0]))
	{
		sscanf(buffer, "%d", &retval.value);
		retval.type = NUMBER;
	}
	else //string
	{
		retval.type = STRING;
		retval.content = _strdup(buffer);
		if(retval.content[0] == 0)
			throw LexicalErrorException();
	}

	return retval;
}


void GameMap::LoadMapFromFile(const char *filename, LPDIRECT3DDEVICE9 device)
{
	FILE* infile;
	infile = fopen(filename, "r");
	if(infile == NULL)
		throw FileNotFoundException();

	token t;
	LPDIRECT3DTEXTURE9 tex;

	// layers
	t = GetNextToken(infile);
	if(t.type == LAYERS)
	{
		t = GetNextToken(infile);
		if(t.type == NUMBER)
			layers = t.value;
		else
			throw SyntaxErrorException();
	}
	else
		throw SyntaxErrorException();

	// size x
	t = GetNextToken(infile);
	if(t.type == SIZEX)
	{
		t = GetNextToken(infile);
		if(t.type == NUMBER)
			size_X = t.value;
		else
			throw SyntaxErrorException();
	}
	else
		throw SyntaxErrorException();

	// suze y
	t = GetNextToken(infile);
	if(t.type == SIZEY)
	{
		t = GetNextToken(infile);
		if(t.type == NUMBER)
			size_Y = t.value;
		else
			throw SyntaxErrorException();
	}
	else
		throw SyntaxErrorException();

	t = GetNextToken(infile);
	while(t.type == TILE)
	{
		t = GetNextToken(infile);
		if(t.type != STRING)
			throw SyntaxErrorException();
		std::string name = t.content;
		t = GetNextToken(infile);
		if(t.type != STRING)
			throw SyntaxErrorException();
		if(FAILED(D3DXCreateTextureFromFile(device, t.content, &tex)))
			throw FileNotFoundException();

		textures.insert(TexturePair(name, tex));
		t = GetNextToken(infile);
	}
	// layers
	ground_map = new MultiLayerTile*[size_X*size_Y];
	for(int i = 0; i < size_X * size_Y; i++)
		ground_map[i] = new MultiLayerTile(device, 1.0f, layers);

	for(int i = 0; i < layers; i++)
	{
		if(t.type != LAYER)
			throw SyntaxErrorException();
		for(int y = 0; y < size_Y; y++)
			for(int x = 0; x < size_X; x++)
			{
				t = GetNextToken(infile);
				if(t.type != STRING)
					throw SyntaxErrorException();
				std::string key = t.content;

				//textures.find(key);
				if(key == "-")
					ground_map[x+y*size_X]->SetLayer(i, (LPDIRECT3DTEXTURE9)0);
				else
					ground_map[x + y*size_X]->SetLayer(i, textures.find(key)->second);
			}
		t = GetNextToken(infile);
	}
	if(t.type != ENDOFFILE)
		throw SyntaxErrorException();

	// done parsing
	fclose(infile);
}

void GameMap::render(LPDIRECT3DDEVICE9 device)
{
	int i,j;
	D3DXMATRIXA16 trans;

	device->SetRenderState( D3DRS_ALPHABLENDENABLE, TRUE );
	for(j = 0; j < size_Y; j++)
		for(i = 0; i < size_X; i++)
		{
			D3DXMatrixTranslation(&trans, i*tile_size, 0, j*tile_size);
			device->SetTransform(D3DTS_WORLD, &trans);
			ground_map[i + size_X*j]->render(device);
		}
	device->SetRenderState( D3DRS_ALPHABLENDENABLE, FALSE );
}

GameMap::GameMap()
{
	this->tile_size = 1.0f;
}

GameMap::~GameMap()
{
	for(int i = 0; i < size_X * size_Y; i++)
		delete ground_map[i];
	delete [] ground_map;
}
