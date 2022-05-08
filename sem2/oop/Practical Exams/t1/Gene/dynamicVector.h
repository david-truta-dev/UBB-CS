#pragma once

template<typename T>
class DynamicVector {

private:
	T* elements;
	int capacity;
	int nrOfElements;

	void reSize(double);

public:

	DynamicVector(int capacity);

	DynamicVector();

	~DynamicVector();

	T getTElem(int poz);

	void addTElem(T e);

	void removeTElem(T e);

	void updateTElem(T newE);

	void changeTElem(int pos, T newE);

	int searchTElem(T e);

	void resetDynamicVector();

	int size();
};

template<typename T>
DynamicVector<T>::DynamicVector(int capacity) {
	this->capacity = capacity;
	this->nrOfElements = 0;
	this->elements = new T[capacity];
}

template<typename T>
DynamicVector<T>::DynamicVector() {
	this->capacity = 10;
	this->nrOfElements = 0;
	this->elements = new T[10];
}

template<typename T>
DynamicVector<T>::~DynamicVector() {
	delete[] this->elements;
}

template<typename T>
void DynamicVector<T>::reSize(double capScalar) {
	this->capacity = this->capacity * capScalar;
	T* newElements = new T[this->capacity];
	for (int i = 0; i < this->nrOfElements; i++)
		newElements[i] = this->elements[i];
	delete[] this->elements;
	this->elements = newElements;
}


template<typename T>
T DynamicVector<T>::getTElem(int poz) {
	if (poz < 0 || poz >= this->size())
		throw "\nThis position is not valid.\n";
	return this->elements[poz];
}

template<typename T>
void DynamicVector<T>::addTElem(T e) {
	if (this->searchTElem(e) > -1)
		throw "\nThis element already exists.\n";
	if (this->capacity == this->nrOfElements)
		this->reSize(2.f);
	this->elements[this->nrOfElements] = e;
	this->nrOfElements++;
}

template<typename T>
void DynamicVector<T>::removeTElem(T e) {
	int poz = this->searchTElem(e);
	if (poz < 0)
		throw "\nThis element doesn't exists.\n";
	if (this->capacity / 2 == this->nrOfElements)
		this->reSize(0.5);
	this->elements[poz] = this->elements[this->nrOfElements - 1];
	this->nrOfElements--;
}

template<typename T>
void DynamicVector<T>::updateTElem(T newE) {
	int poz = this->searchTElem(newE);
	if (poz < 0)
		throw "\nThis element doesn't exists.\n";
	this->elements[poz] = newE;
}

template<typename T>
void DynamicVector<T>::changeTElem(int poz, T newE) {
	if (poz < 0 || poz >= this->size())
		throw "\nThis element doesn't exists.\n";
	this->elements[poz] = newE;
}

template<typename T>
int DynamicVector<T>::searchTElem(T e) {
	for (int i = 0; i < this->size(); i++) {
		if (e.getId() == this->elements[i].getId()) return i;
	}
	return -1;
}

template<typename T>
void DynamicVector<T>::resetDynamicVector() {
	this->nrOfElements = 0;
	this->capacity = 10;
}

template<typename T>
int DynamicVector<T>::size() {
	return this->nrOfElements;
}