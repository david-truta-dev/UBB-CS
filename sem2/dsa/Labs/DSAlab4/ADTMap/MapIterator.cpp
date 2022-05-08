#include "Map.h"
#include "MapIterator.h"
#include <exception>
using namespace std;


MapIterator::MapIterator(const Map& d) : map(d){
	this->first();
}


void MapIterator::first() {
	this->currentPos = 0;
	while (this->currentPos < this->map.cap && this->map.T[this->currentPos] == NULL_TELEM)
		this->currentPos++;
	if (this->currentPos < this->map.cap)
		this->currentElem = this->map.T[this->currentPos];
	else this->currentElem = NULL_TELEM;
}


void MapIterator::next() {
	if (this->valid() == false)
		throw std::exception();
	this->currentPos++;
	while (this->currentPos < this->map.cap && this->map.T[this->currentPos] == NULL_TELEM)
		this->currentPos++;
	if (this->currentPos < this->map.cap)
		this->currentElem = this->map.T[this->currentPos];
}

void MapIterator::jumpForward(int k) {
	if (k <= 0)
		throw std::exception();
	for (int i = 0; i < k; i++)
		this->next();
}


TElem MapIterator::getCurrent(){
	if (this->valid() == false)
		throw std::exception();
	return this->currentElem;
}


bool MapIterator::valid() const {
	if(this->currentPos >= this->map.cap || this->map.isEmpty())
		return false;
	return true;
}



