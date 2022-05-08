#include "SortedSetIterator.h"
#include <exception>

using namespace std;

SortedSetIterator::SortedSetIterator(SortedSet& m) : multime(m){
	this->currentNode = multime.head;
}


void SortedSetIterator::first() {
	this->currentNode = multime.head;
}


void SortedSetIterator::next() {
	if (this->valid() == false)
		throw exception();
	this->currentNode = this->currentNode->next;
}


TElem SortedSetIterator::getCurrent(){
	if (this->valid() == false)
		throw exception();
	return this->currentNode->value;
}

TElem SortedSetIterator::removeCurrent(){
	if (this->valid() == false)
		throw exception();
	TElem current = this->getCurrent();
	this->next();
	this->multime.remove(current);
	return current;
/*
	BC:Theta(1) not valid 
	AC:O(n)
	WC:Theta(n)
	Complexity: O(n)
	It takes the complexity of remove from sorted set.
*/
}

bool SortedSetIterator::valid() const {
	if (this->currentNode != NULL)
		return true;
	return false;
}

