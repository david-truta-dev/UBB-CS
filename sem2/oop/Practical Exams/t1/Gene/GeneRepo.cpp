#include "GeneRepo.h"

void GeneRepo::addGene(Gene g)
{
	this->data.addTElem(g);
}

int GeneRepo::getNrOfGenes()
{
	return this->data.size();
}

void GeneRepo::getGenes(DynamicVector<Gene>* dv)
{
	dv->resetDynamicVector();
	for (int i = 0; i < this->data.size(); i++) {
		dv->addTElem(this->data.getTElem(i));
	}
}
