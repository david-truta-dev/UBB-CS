#pragma once
#include "Matrix.h"

class MatrixIterator {

	friend class Matrix;

private:
	const Matrix& m;
	int currentCol;
	int currentLine;

public:

	MatrixIterator(const Matrix& m);
	void next();
	TElem getCurrent();
	bool valid() const;

};

//ADT Matrix
//
//
//
//creates an iterator over the elements of the Matrix that are not equal to NULL_TELEM. 
//The iterator will return the elements by line (first elements of the first line,
//then from second line, etc). 
//
//MatrixIterator iterator() const;
//
//
//
//Obs: You will have to implement the class MatrixIterator as well.