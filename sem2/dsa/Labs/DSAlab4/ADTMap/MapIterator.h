#pragma once
#include "Map.h"
class MapIterator
{
	//DO NOT CHANGE THIS PART
	friend class Map;
private:
	const Map& map;
	int currentPos;
	TElem currentElem;

	MapIterator(const Map& m);
public:
	void first();
	void next();
	void jumpForward(int);
	TElem getCurrent();
	bool valid() const;
};


