#pragma once

typedef int TElem;

class DynamicArray {

private:
	TElem* elements;
	int capacity;
	int nrOfElements;

	void reSize(double);

public:

	DynamicArray(int cap);

	DynamicArray();

	~DynamicArray();

	TElem getTElem(int poz) const;

	void insertTElem(int poz, TElem e);

	void removeTElem(int poz);

	void updateTElem(int poz, TElem newE);

	int size() const;

};