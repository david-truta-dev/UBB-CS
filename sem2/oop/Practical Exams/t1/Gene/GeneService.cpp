#include "GeneService.h"

GeneService::GeneService(GeneRepo* gr) {
	this->gr = gr;
}

void GeneService::addSomeGenes() {
	Gene g1{ "E_Coli_K12", "yqgE", "ATGACATCATCATTG" }; this->gr->addGene(g1);
	Gene g2{ "M_tuberculosis", "ppiA ", "TCTTCATCATCATCGG" }; this->gr->addGene(g2);
	Gene g3{ "Mouse", "Col2a1", "TTAAAGCATGGCTCTGTG" }; this->gr->addGene(g3);
	Gene g4{ "E_Coli_ETEC", "yqgE", "GTGACAGCGCCCTTCTTTCCACG" }; this->gr->addGene(g4);
	Gene g5{ "E_Coli_K12 ", "hokC ", "TTAATGAAGCATAAGCTTGATTTC" }; this->gr->addGene(g5);
}

void GeneService::addGene(std::string organism, std::string name, std::string sequence) {
	Gene g{ organism, name, sequence };
	this->gr->addGene(g);
}

void GeneService::getGenes(DynamicVector<Gene>* dv) {
	this->gr->getGenes(dv);
}

void GeneService::sort(DynamicVector<Gene>* dv) {
	for(int i=0;i<dv->size()-1; i++)
		for (int j = i + 1; j < dv->size(); j++) {
			if (dv->getTElem(i).getSequence().size() < dv->getTElem(j).getSequence().size()) {
				Gene aux;
				aux = dv->getTElem(i);
				dv->changeTElem(i, dv->getTElem(j));
				dv->changeTElem(j, aux);
			}
		}
}

//void GeneService::filterBySequence(DynamicVector<Gene>* dv, std::string seq) {
//	for (int i = 0; i < dv->size(); i++)
//		if (dv->getTElem(i).getSequence().find(seq) == std::string::npos)) {
//				dv.re
//		}
//}