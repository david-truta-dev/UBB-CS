#pragma once
#include "dynamicArray.h"

//DO NOT CHANGE THIS PART
typedef int TElem;
#define NULL_TELEM 0

class MatrixIterator;

class Matrix {

	friend class MatrixIterator;

private:
	int nrOfLines=0;
	int nrOfColumns=0;
	DynamicArray columns;
	DynamicArray lines;
	DynamicArray value;
	

	//TODO - Representation
public:
	//constructor
	Matrix(int nrLines, int nrCols);

	//returns the number of lines
	int nrLines() const;

	//returns the number of columns
	int nrColumns() const;

	//returns the element from line i and column j (indexing starts from 0)
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem element(int i, int j) const;

	//modifies the value from line i and column j
	//returns the previous value from the position
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem modify(int i, int j, TElem e);

	//Thete(nrLines*nrColumns)
	MatrixIterator iterator() const;

};
