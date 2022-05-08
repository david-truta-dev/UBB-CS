#include "Bag.h"
#include "BagIterator.h"
#include <exception>
#include <iostream>
using namespace std;


Bag::Bag() {
	this->nodes = new DLLANode[10];
	this->cap = 10;
	this->length = 0;
	this->uniqueSize = 0;
	this->head = -1;
	this->tail = -1;
	for (int i = 0; i < cap - 1; i++) {
		this->nodes[i].next = i + 1;
		this->nodes[i].prev = -1;
	}
	this->nodes[this->cap-1].next = -1;
	this->nodes[this->cap-1].prev = -1;
	this->firstEmpty = 0;
}

int Bag::allocate() {
	TElem newElem = this->firstEmpty;
	if (newElem != -1) {
		this->firstEmpty = this->nodes[this->firstEmpty].next;
		if (this->firstEmpty != -1)
			this->nodes[this->firstEmpty].prev = -1;
		this->nodes[newElem].next = -1;
		this->nodes[newElem].prev = -1;
	}
	return newElem;
}

void Bag::add(TElem elem) {
	int poz = this->uniqueSize;
	int currentNode = this->head;
	while (currentNode != -1) {
		if (this->nodes[currentNode].info.first == elem) {
			this->nodes[currentNode].info.second += 1;
			this->length++;
			return;
		}
		currentNode = this->nodes[currentNode].next;
	}
	TElem newElem = this->allocate();
	if (newElem == -1) {
		DLLANode* newNodes = new DLLANode[this->cap * 2];
		for (int i = 0; i < this->cap; i++) {
			newNodes[i].prev = this->nodes[i].prev;
			newNodes[i].info.first = this->nodes[i].info.first;
			newNodes[i].info.second = this->nodes[i].info.second;
			newNodes[i].next = this->nodes[i].next;
		}
		for (int i = this->cap; i < this->cap * 2 - 1; i++) {
			newNodes[i].next = i + 1;
			newNodes[i].prev = - 1;
		}
		newNodes[this->cap * 2 - 1].next = -1;
		newNodes[this->cap * 2 - 1].prev = -1;
		delete[] this->nodes;
		this->nodes = newNodes;
		this->firstEmpty = this->cap;
		this->cap = this->cap * 2;

		newElem = this->allocate();
	}
	this->nodes[newElem].info.first = elem;
	this->nodes[newElem].info.second = 1; 
	this->length++;
	this->uniqueSize++;
	if (poz == 0) {
		if (this->head == -1) {
			this->head = newElem;
			this->tail = newElem;
		}
		else {
			this->nodes[newElem].next = this->head;
			this->nodes[this->head].prev = newElem;
			this->head = newElem;
		}
	}
	else {
		TElem nodC = this->head;
		int pozC = 0;
		while (nodC != -1 && pozC < poz - 1) {
			nodC = this->nodes[nodC].next;
			pozC = pozC + 1;
		}
		if (nodC != -1) {
			TElem nodNext = this->nodes[nodC].next;
			this->nodes[newElem].next = nodNext;
			this->nodes[newElem].prev = nodC;
			this->nodes[nodC].next = newElem;
			if (nodNext == -1)
				this->tail = newElem;
			else
				this->nodes[nodNext].prev = newElem;
		}
	}
} // O(n)

void Bag::free(int poz) {
	this->nodes[poz].next = this->firstEmpty;
	this->nodes[poz].prev = -1;
	if (this->firstEmpty != -1)
		this->nodes[this->firstEmpty].prev = poz;
	this->firstEmpty = poz;
}

bool Bag::remove(TElem elem) {
	int nodC = this->head;
	while (nodC != -1 && this->nodes[nodC].info.first != elem) {
		nodC = this->nodes[nodC].next;
	}
	if (nodC != -1) {
		if (this->nodes[nodC].info.second == 1) {
			if (this->head == nodC && this->tail == nodC) {
				this->head = -1;
				this->tail = -1;
			}else if (this->head == nodC) {
				this->head = this->nodes[this->head].next;
				this->nodes[this->head].prev = -1;
			} else if (this->tail == nodC) {
				this->tail = this->nodes[this->tail].prev;
				this->nodes[this->tail].next = -1;
			} else {
				this->nodes[this->nodes[nodC].prev].next = this->nodes[nodC].next;
				this->nodes[this->nodes[nodC].next].prev = this->nodes[nodC].prev;
			}
			this->free(nodC);
			this->length--;
			this->uniqueSize--;
			return true;
		}
		else {
			this->nodes[nodC].info.second--;
			this->length--;
			return true;
		}
	}
	return false;
}


bool Bag::search(TElem elem) const {
	int currentNode = this->head;
	while (currentNode != -1) {
		if (this->nodes[currentNode].info.first == elem) return true;
		currentNode = this->nodes[currentNode].next;
	}
	return false;
}

int Bag::nrOccurrences(TElem elem) const {
	int currentNode = this->head;
	while (currentNode != -1) {
		if (this->nodes[currentNode].info.first == elem) return this->nodes[currentNode].info.second;
		currentNode = this->nodes[currentNode].next;
	}
	return 0;
}

int Bag::removeAllOccurrences(TElem elem) {
	int currentNode = this->head;
	while (currentNode != -1) {
		if (this->nodes[currentNode].info.first == elem) {
			int occ = this->nodes[currentNode].info.second;
				if (this->head == currentNode && this->tail == currentNode) {
					this->head = -1;
					this->tail = -1;
				}
				else if (this->head == currentNode) {
					this->head = this->nodes[this->head].next;
					this->nodes[this->head].prev = -1;
				}
				else if (this->tail == currentNode) {
					this->tail = this->nodes[this->tail].prev;
					this->nodes[this->tail].next = -1;
				}
				else {
					this->nodes[this->nodes[currentNode].prev].next = this->nodes[currentNode].next;
					this->nodes[this->nodes[currentNode].next].prev = this->nodes[currentNode].prev;
				}
				this->free(currentNode);
				this->length -= occ;
				this->uniqueSize--;
				return occ;
		}
		currentNode = this->nodes[currentNode].next;
	}
	return 0;
} // O(number of unique elements)


int Bag::size() const {
	return this->length;
}


bool Bag::isEmpty() const {
	if (this->length == 0)return true;
	return false;
}

BagIterator Bag::iterator() const {
	return BagIterator(*this);
}


Bag::~Bag() {
	delete[] this->nodes;
}

