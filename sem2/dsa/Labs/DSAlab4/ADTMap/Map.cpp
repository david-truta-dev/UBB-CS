#include "Map.h"
#include "MapIterator.h"

Map::Map() {
	this->nrOfElem = 0;
	this->firstEmpty = 0;
	this->cap = 13;
	this->next = new int[this->cap];
	this->T = new TElem[this->cap];
	for (int i = 0; i < this->cap; i++) {
		this->next[i] = -1;
		this->T[i] = NULL_TELEM;
	}
}

Map::~Map() {
	delete[] this->next;
	delete[] this->T;
}

int Map::h(TKey c){
	if (c < 0) c = -c;
	return c % this->cap;
}

void Map::changeFirstEmpty(){
	this->firstEmpty++;
	while (this->firstEmpty < this->cap && this->T[this->firstEmpty] != NULL_TELEM)
		this->firstEmpty++;
}

void Map::reSize() {
	// Copying the elems:
	TElem* elems = new TElem[this->cap];
	for (int i = 0; i < this->cap; i++) {
		if(this->T[i] != NULL_TELEM)
			elems[i] = this->T[i];
	}
	// Doubling and reseting the main arrays;
	this->cap = this->cap * 2;
	int* newNext = new int[this->cap];
	TElem* newT = new TElem[this->cap];
	for (int i = 0; i < this->cap; i++) {
		newNext[i] = -1;
		newT[i] = NULL_TELEM;
	}
	delete[] this->next;
	delete[] this->T;
	this->next = newNext;
	this->T = newT;
	this->firstEmpty = 0;
	this->nrOfElem = 0;
	// Adding the elements to the main array
	for (int i = 0; i < this->cap/2; i++) {
		this->add(elems[i].first, elems[i].second);
	}
	delete[] elems;
}

TValue Map::add(TKey c, TValue v){
	int pos = this->h(c);
	if (this->T[pos] == NULL_TELEM) {
		this->T[pos] = std::pair<TKey, TValue>(c, v);
		this->next[pos] = -1;
		this->nrOfElem++;
		return NULL_TVALUE;
	}
	else {
		if (this->nrOfElem == this->cap){
			this->reSize();
		}
		int current = pos;
		if (this->T[current].first == c) {
			TValue oldVal = this->T[current].second;
			this->T[current].second = v;
			return oldVal;
		}
		while (this->next[current] != -1) {
			if (this->T[this->next[current]].first == c) {
				TValue oldVal = this->T[this->next[current]].second;
				this->T[this->next[current]].second = v;
				return oldVal;
			}
			current = this->next[current];
		}
		if (this->T[this->firstEmpty] != NULL_TELEM)
			this->changeFirstEmpty();
		this->T[this->firstEmpty] = std::pair<TKey, TValue>(c, v);
		this->next[this->firstEmpty] = -1;
		this->next[current] = this->firstEmpty;
		this->changeFirstEmpty();
		this->nrOfElem++;
		return NULL_TVALUE;
	}
}

TValue Map::search(TKey c) const{
	int pos = c % this->cap;
	if (c < 0) pos = (-c) % this->cap;
	while (pos != -1 && this->T[pos].first != c)
		pos = this->next[pos];
	if( pos == -1 )
		return NULL_TVALUE;
	return this->T[pos].second;
}

TValue Map::remove(TKey c){
	int i = this->h(c), j = -1, idx = 0;
	while (idx < this->cap && j == -1)
		if (this->next[idx] == i)
			j = idx;
		else idx++;
	while (i != -1 && this->T[i].first != c) {
		j = i;
		i = this->next[i];
	}
	if ( i == -1 )
		return NULL_TVALUE;
	else {
		TValue oldVal = this->T[i].second;
		bool over = false;
		do {
			int p = this->next[i];
			int pp = i;
			while (p != -1 && this->h(this->T[p].first) != i) {
				pp = p;
				p = this->next[p];
			}
			if (p == -1)
				over = true;
			else {
				this->T[i] = this->T[p];
				j = pp;
				i = p;
			}
		} while (!over);
		if (j != -1)
			this->next[j] = this->next[i];
		this->T[i] = NULL_TELEM;
		this->next[i] = -1;
		if (this->firstEmpty > i)
			this->firstEmpty = i;
		this->nrOfElem--;
		return oldVal;
	}
}

int Map::size() const {
	return this->nrOfElem;
}

bool Map::isEmpty() const{
	if (this->nrOfElem == 0)
		return true;
	return false;
}

MapIterator Map::iterator() const {
	return MapIterator(*this);
}



