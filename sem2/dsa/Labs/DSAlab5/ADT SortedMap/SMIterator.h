#pragma once
#include <vector>
#include "SortedMap.h"

//DO NOT CHANGE THIS PART
class SMIterator{
	friend class SortedMap;
private:
	const SortedMap& map;
	SMIterator(const SortedMap& mapionar);
	std::vector<BSTNode*> inOrder;
	BSTNode* currentNode;

public:
	void first();
	void inOrderTraversal(BSTNode*);
	void next();
	bool valid() const;
    TElem getCurrent() const;
};

