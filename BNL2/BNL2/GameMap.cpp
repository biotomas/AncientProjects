#include "GameMap.h"
#include <fstream>
#include <string>
#include <sstream>


using namespace std;
const string::size_type npos = string::npos;
typedef vector<string> Tparameters;

enum Attributes
{
	sizex_attribute,
	sizey_attribute,
	tilesize_attribute,
	texture_attribute,
	tilemap_attribute,
	layers_attribute,
	wall_attribute,
	none
};

// clears the comments, newlines, multiple spaces
void ClearLine(string& line)
{
	string::size_type pos1, pos2;
	//delete comments
	while (string::npos != (pos1 = line.find("//")))
	{
		pos2 = line.find('\n', pos1);
		line = line.erase(pos1, pos2-pos1);
	}
	string::iterator it = line.begin();
	// replace \n by ' '
	for (it; it != line.end(); ++it)
	{
		if (*it == '\n' || *it == '\t')
			*it = ' ';
	}

	string::iterator it2 = line.begin();
	int i2 = 0;
	bool last_space = false;

	// delete multiple spaces, and spaces around ';'
	for (it = line.begin(); it != line.end(); ++it)
	{
		if (*it == ' ' || *it == ';')
		{
			if (!last_space)
			{
				*it2 = *it;
				++it2;
				++i2;
			}
			if(*it ==  ';')
				*(it2-1) = ';';
			last_space = true;
		}
		else
		{
			*it2 = *it;
			++it2;
			++i2;
			last_space = false;
		}
	}
	line.erase(i2);
}

struct Element
{
	Attributes		type;
	Tparameters		parameters;	
};

bool GetNextElement(Element& elem, string& line)
{
	if (line.length() == 0)
		return false;

	string subline, attr;
	string::size_type pos;
	pos = line.find(';');
	subline = line.substr(0, pos);
	line = line.erase(0, pos+1);

	pos = subline.find(' ');
	attr = subline.substr(0, pos);
	subline = subline.erase(0, pos+1);

	// here add new attributes
	 	 if (0 == attr.compare("sizex"))			elem.type = sizex_attribute;
	else if (0 == attr.compare("sizey"))			elem.type = sizey_attribute;
	else if (0 == attr.compare("texture"))			elem.type = texture_attribute;
	else if (0 == attr.compare("tilesize"))			elem.type = tilesize_attribute;
	else if (0 == attr.compare("tilemap"))			elem.type = tilemap_attribute;
	else if (0 == attr.compare("ground_layers"))	elem.type = layers_attribute;
	else if (0 == attr.compare("wall"))				elem.type = wall_attribute;
	else											elem.type = none;

	// fill in the parameters also if elem type is none
	elem.parameters.clear();
	while (npos != (pos = subline.find(' ')))
	{
		attr = subline.substr(0, pos);
		subline = subline.erase(0, pos+1);
		elem.parameters.push_back(attr);
	}
	elem.parameters.push_back(subline);

	return true;
}

size_t StringTosize_t(string& s)
{
	size_t retval;
	istringstream ss(s);
	ss >> retval;
	return retval;
}

float StringTofloat(string& s)
{
	float retval;
	istringstream ss(s);
	ss >> retval;
	return retval;
}

void GameMap::LoadMapFromFile(const char* filename)
{
	LPDIRECT3DDEVICE9 device = DirectXGraphics::getInstance()->getDevice();

	ifstream myfile(filename);
	Element elem;
	size_t layers=1;
	string alllines;
	string line;
	if (myfile.is_open())
	{
		while(!myfile.eof())
		{
			getline(myfile, line);
			alllines +=line+'\n';
		}
	}
	else
	{
		MessageBox(NULL, "Level file not found", "BNL2", MB_OK);
		PostQuitMessage(1);
	}
	myfile.close();

	ClearLine(alllines);
	MultiLayerTile *tile;
	WallGraphics* wall;
	points_vector ptsv;

	while(GetNextElement(elem, alllines))
	{
		Tparameters::size_type i = 0;
		ptsv.clear();
		switch(elem.type)
		{
		// define the interpretation of the attributes
		case sizex_attribute:
			size_X = StringTosize_t(elem.parameters[0]);
			break;

		case sizey_attribute:
			size_Y = StringTosize_t(elem.parameters[0]);
			break;

		case layers_attribute:
			layers = StringTosize_t(elem.parameters[0]);
			break;

		case tilesize_attribute:
			tile_size = StringTofloat(elem.parameters[0]);
			break;

//		inserting a texture
		case texture_attribute:
			tile = new MultiLayerTile(device, tile_size, layers);
			tile->SetLayer(0, elem.parameters[1].c_str());
			unique_tiles.insert(map_pair(elem.parameters[0], tile));
			break;
//		creating a tilemap
		case tilemap_attribute:
			ground_map = new MultiLayerTile*[size_X * size_Y];
			for (i; i<elem.parameters.size(); ++i)
				ground_map[i] = unique_tiles.find(elem.parameters[i])->second;
			break;
//		creating a wall
		case wall_attribute:
			for(i = 2; i<elem.parameters.size(); i+=2)
			{
				ptsv.push_back(Fpoint(StringTofloat(elem.parameters[i]), StringTofloat(elem.parameters[i+1])));
			}
			ptsv.push_back(ptsv[0]);

			global_collision_detector.add_obstruction(ptsv);

			wall = new WallGraphics(device, 
									elem.parameters[0].c_str(), 
									StringTofloat(elem.parameters[1]), 
									ptsv);
			walls.push_back(wall);
			break;
		}
	}

	DirectXGraphics::getInstance()->AddRenderable(this);
}

void GameMap::render(LPDIRECT3DDEVICE9 device)
{
	size_t i,j;
	D3DXMATRIXA16 translation;
	D3DXMATRIXA16 id;
	D3DXMatrixIdentity(&id);

	for (j = 0; j<size_Y; ++j)
		for (i = 0; i<size_X; ++i)
		{
			D3DXMatrixTranslation(&translation, i * tile_size, 0, j * tile_size);
			device->SetTransform(D3DTS_WORLD, &translation);
			ground_map[i+(size_Y-1-j)*size_X]->render(device);
		}

	device->SetTransform(D3DTS_WORLD, &id);
	for (j = 0; j<walls.size(); j++)
		walls[j]->render(device);
}

GameMap::GameMap(void)
{
}

GameMap::~GameMap(void)
{
	DirectXGraphics::getInstance()->RemoveRenderable(this);
	// todo:
	// deallocate tiles
	// unregister and deallocate walls
}
