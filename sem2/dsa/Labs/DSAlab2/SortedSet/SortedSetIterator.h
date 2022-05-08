#pragma once
#include "SortedSet.h"

//DO NOT CHANGE THIS PART
class SortedSetIterator
{
	friend class SortedSet;
private:
	SortedSet& multime;
	SortedSetIterator(SortedSet& m);

	Node* currentNode;

public:
	void first();
	void next();
	TElem getCurrent();
	TElem removeCurrent();
	bool valid() const;
};

