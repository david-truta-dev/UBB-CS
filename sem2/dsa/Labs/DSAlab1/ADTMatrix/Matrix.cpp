#include "Matrix.h"
#include "MatrixIterator.h"
#include <exception>
#include <iostream>
using namespace std;


Matrix::Matrix(int nrLines, int nrCols) {
	this->nrOfColumns = nrCols;
	this->nrOfLines = nrLines;
	for (int i = 0; i < nrCols + 1; i++) {
		this->columns.insertTElem(i, 0);
	}
}

int Matrix::nrLines() const {
	return this->nrOfLines;
}

int Matrix::nrColumns() const {
	return this->nrOfColumns;
}

TElem Matrix::element(int i, int j) const {
	if (i < 0 || i > this->nrOfLines-1 || j < 0 || j > this->nrOfColumns - 1)
		throw exception();
	for (int index = this->columns.getTElem(j); index < this->columns.getTElem(j+1); index++) {
		if (this->lines.getTElem(index) == i) return this->value.getTElem(index);
	}
	return NULL_TELEM;
}

TElem Matrix::modify(int i, int j, TElem e) {
	if (i < 0 || i > this->nrOfLines - 1 || j < 0 || j > this->nrOfColumns - 1)
		throw exception();
	
	if (e != 0) {
		//1. Modify from non-zero to non-zero:
		for (int index = this->columns.getTElem(j); index < this->columns.getTElem(j+1); index++) {
			if (this->lines.getTElem(index) == i) {
				TElem aux = this->value.getTElem(index);	
				this->value.updateTElem(index, e);
				return aux;
			}
		}

		//2. Modify from 0 to non-zero:
		int index = this->columns.getTElem(j);
		while (index < this->columns.getTElem(j+1) && this->lines.getTElem(index) < e)
			index++;

		this->lines.insertTElem(index, i);
		this->value.insertTElem(index, e);

		for (int c = j + 1; c < this->nrOfColumns + 1; c++) {
			this->columns.updateTElem(c, this->columns.getTElem(c)+1);
		}

		return NULL_TELEM;
	}
	else{
		//3. Modify from non-zero to 0:
		for (int index = this->columns.getTElem(j); index < this->columns.getTElem(j+1); index++) {
			if (this->lines.getTElem(index) == i) {
				TElem aux = this->value.getTElem(index);
				//Remove the el on poz index from lines and value, then update positions in columns
				this->lines.removeTElem(index);
				this->value.removeTElem(index);
				for (int c = j + 1; c < this->nrOfColumns + 1; c++) {
					this->columns.updateTElem(c, this->columns.getTElem(c) - 1);
				}
				return aux;
			}
		}

		//4. Modify from 0 to 0:
		return NULL_TELEM;
	}
	
}

MatrixIterator Matrix::iterator() const {
	return MatrixIterator(*this);
}


