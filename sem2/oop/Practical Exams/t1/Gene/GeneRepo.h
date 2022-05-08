#pragma once
#include "dynamicVector.h"
#include "Gene.h"

class GeneRepo {

private:
	DynamicVector<Gene> data;


public:

	void addGene(Gene);

	
	//void removeGene(std::string);

	//void updateTutorial(Tutorial);

	int getNrOfGenes();

	void getGenes(DynamicVector<Gene>*);

};