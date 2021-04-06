#pragma once
#include <vector>

const int list_size = 9000;
const int max_path_length = 2000;	

struct Point2D
{
	int x;
	int y;
	Point2D(int x, int y)
	{
		this->x = x;
		this->y = y;
	}
	Point2D(){}
};

struct CAnode
	//uzol pre algoritmus A*
{
	CAnode*		parent;
	Point2D		position;
	int			base_cost,
				distart_cost,
				distgoal_cost,
				total_cost;
};

struct Cpath
{
	int				length;
	Point2D*		path;
	~Cpath()
	{
		if (path != NULL)
			delete [] path;
	}
};

class Cheap
{
private:
	CAnode*		heap;
	int			size,
				elements;
public:
	void clear();
	bool insert(CAnode element);
	CAnode get_min(void);
	int num_elements(void);
	Cheap(int size = 900);
	~Cheap();
};

class Cpathfinder
	// algoritmus A*
{
private:
	bool*				path_map; //can i pass?
	bool*				used_list;
						// ktore uzly nie su ani v open_list ani v closed_list, true ak je v niektorom.
	CAnode				closed_list[list_size];
	Cheap				open_list;
	int					width,
						height;
public:
	void CreateRectangle(int sizex, int sizey);
	void set_position(int x, int y, bool passable);
	Cpath* find_path(Point2D from, Point2D to);

	Cpathfinder(void);
	~Cpathfinder(void);
private:
	void add_to_open_list(Point2D position, Point2D goal, CAnode* parent, int base_cost);
};
/**/