#ifndef INTARRAY
#define INTARRAY

class IntArray
{
private:
	int size;
	int* elements;

public:
	IntArray(int* elements, int size)
	{
		this->elements = elements;
		this->size = size;
	}

	int getSize()
	{
		return size;
	}

	int* getElements()
	{
		return elements;
	}

	~IntArray()
	{
		delete elements;
	}
};

#endif