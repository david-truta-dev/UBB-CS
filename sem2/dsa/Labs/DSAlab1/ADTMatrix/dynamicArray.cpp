#include "dynamicArray.h"

DynamicArray::DynamicArray(int capacity) {
	this->capacity = capacity;
	this->nrOfElements = 0;
	this->elements = new TElem[capacity];
}

DynamicArray::DynamicArray() {
	this->capacity = 1;
	this->nrOfElements = 0;
	this->elements = new TElem[10];
}

DynamicArray::~DynamicArray() {
	delete[] this->elements;
}

TElem DynamicArray::getTElem(int poz) const {
	if (poz < 0 || poz >= this->size())
		throw "\nThis position is not valid.\n";
	return this->elements[poz];
}

void DynamicArray::reSize(double capScalar) {
	this->capacity = this->capacity * capScalar;
	TElem* newElements = new TElem[this->capacity];
	for (int i = 0; i < this->nrOfElements; i++)
		newElements[i] = this->elements[i];
	delete[] this->elements;
	this->elements = newElements;
}

void DynamicArray::insertTElem(int poz, TElem e) {
	if (this->capacity == this->nrOfElements)
		this->reSize(2.f);
	for (int i = this->size(); i > poz; i--) {
		this->elements[i] = this->elements[i - 1];
	}
	this->nrOfElements++;
	this->elements[poz] = e;
}

void DynamicArray::removeTElem(int poz) {
	if (poz < 0 || poz >= this->size())
		throw "\nThis element doesn't exists.\n";
	if (this->capacity / 2 == this->nrOfElements)
		this->reSize(0.5);
	this->nrOfElements--;
	for (int i = poz; i < this->size(); i++) {
		this->elements[i] = this->elements[i + 1];
	}
}

void DynamicArray::updateTElem(int poz, TElem newE) {
	if (poz < 0 || poz >= this->size())
		throw "\nThis element doesn't exists.\n";
	this->elements[poz] = newE;
}

int DynamicArray::size() const {
	return this->nrOfElements;
}