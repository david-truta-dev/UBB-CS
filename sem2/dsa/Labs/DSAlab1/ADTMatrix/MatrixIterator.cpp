#include "Matrix.h"
#include "MatrixIterator.h"
#include <exception>

MatrixIterator::MatrixIterator(const Matrix& ma) :m(ma) {//Theta(1)
	this->currentLine = 0;
	this->currentCol = 0;
}

void MatrixIterator::next()
{
	if (this->currentLine >= this->m.nrLines() || this->currentLine >= this->m.nrColumns())
		throw _exception();
	else {
		if (this->currentLine == this->m.nrLines() - 1) {
			this->currentLine = 0; this->currentCol++;
		}
		else this->currentLine++;
	}
	while (this->valid() == true && this->m.element(this->currentLine, this->currentCol) == NULL_TELEM)
		this->next();
}

TElem MatrixIterator::getCurrent()//Theta(1)
{
	if (this->currentLine >= this->m.nrLines() || this->currentLine >= this->m.nrColumns())
		throw _exception();

	return this->m.element(this->currentLine, this->currentCol);
}

bool MatrixIterator::valid() const // Theta(1)
{
	if (this->currentLine < this->m.nrLines() && this->currentCol < this->m.nrColumns())
		return true;
	return false;
}
