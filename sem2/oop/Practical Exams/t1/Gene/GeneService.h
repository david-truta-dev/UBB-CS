#pragma once
#include "GeneRepo.h"

class GeneService {

private:
	GeneRepo* gr;

public:

	GeneService(GeneRepo* gr);
	void addSomeGenes();
	void addGene(std::string organism, std::string name, std::string sequence);
	void getGenes(DynamicVector<Gene>* dv);
	void sort(DynamicVector<Gene>* dv);
	/*void filterBySequence(DynamicVector<Gene>* dv, std::string seq);*/

};