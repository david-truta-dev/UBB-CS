#pragma once
#include <iostream>
//DO NOT INCLUDE BAGITERATOR


//DO NOT CHANGE THIS PART
#define NULL_TELEM -111111;
typedef int TElem;
class BagIterator; 

class DLLANode {
public:
	int prev;
	std::pair<TElem, int> info;
	int next;
};

//  4.ADT Bag–using a DLLA with(element, frequency) pairs.

class Bag {

private:
	DLLANode* nodes;
	int head;
	int tail;
	int firstEmpty;
	int cap;
	int length;
	int uniqueSize;


	//DO NOT CHANGE THIS PART
	friend class BagIterator;
public:
	//constructor
	Bag();

	int allocate();

	void free(int poz);

	//adds an element to the bag
	void add(TElem e);

	//removes one occurence of an element from a bag
	//returns true if an element was removed, false otherwise (if e was not part of the bag)
	bool remove(TElem e);

	//checks if an element appearch is the bag
	bool search(TElem e) const;

	//returns the number of occurrences for an element in the bag
	int nrOccurrences(TElem e) const;

	int removeAllOccurrences(TElem elem);

	//returns the number of elements from the bag
	int size() const;

	//returns an iterator for this bag
	BagIterator iterator() const;

	//checks if the bag is empty
	bool isEmpty() const;

	//destructor
	~Bag();
};