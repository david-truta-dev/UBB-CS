#include <exception>
#include "BagIterator.h"
#include "Bag.h"

using namespace std;


BagIterator::BagIterator(const Bag& c): bag(c)
{
	this->currentElem = this->bag.head;
	this->currentFreq = this->bag.nodes[this->bag.head].info.second - 1;
}

void BagIterator::first() {
	this->currentElem = this->bag.head;
	this->currentFreq = this->bag.nodes[this->bag.head].info.second - 1;
}


void BagIterator::next() {
	if (this->valid() == false)
		throw std::exception();
	if (this->currentFreq)
		this->currentFreq--;
	else {
		this->currentElem = this->bag.nodes[this->currentElem].next;
		this->currentFreq = this->bag.nodes[this->currentElem].info.second - 1;
	}	
}


bool BagIterator::valid() const {
	if (this->currentElem == -1)
		return false;
	return true;
}



TElem BagIterator::getCurrent() const {
	if (this->valid() == false)
		throw std::exception();
	return this->bag.nodes[this->currentElem].info.first;
}
