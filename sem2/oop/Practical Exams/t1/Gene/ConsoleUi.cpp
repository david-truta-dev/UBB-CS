#include "ConsoleUi.h"
#include <iostream>
#include <sstream>

ConsoleUi::ConsoleUi(GeneService* gs) {
	this->service = gs;
}

void ConsoleUi::menu() {
	std::cout << "\n Available commands:\n'add' - add gene.\n"\
		"'lcs' - display their longest common subsequence .\n"\
		"'find' - list all genes, with the same seq. entered by user(partial aswell/print same format as list).\n"\
		"'list' - list all genes, sorted decr. by squence length.\n"\
		"'exit' - exit the app.\n> ";
}

bool isDigits(const std::string& str) {
	return str.find_first_not_of("0123456789") == std::string::npos;
}

void readGeneData(std::string& organism, std::string& name, std::string& sequence) {
	int trash;
	std::cout << "\n -------- Reading Gene Data -------- \nOrganism:"; getline(std::cin, organism);
	std::cout << "Name:"; std::getline(std::cin, name);
	std::cout << "Sequence:"; std::getline(std::cin, sequence);
}

void ConsoleUi::uiAddGene() {
	std::string organism, name, sequence;
	readGeneData(organism, name, sequence);
	this->service->addGene(organism, name, sequence);
	std::cout << "\nAdd was successful !\n";
}

void printGenes(DynamicVector<Gene>* dv) {
	if (dv->size() == 0) std::cout << "\nThere are no Tutorials in the database.\n";
	for (int i = 0; i < dv->size(); i++) {
		char string[250]; dv->getTElem(i).toString(string);
		printf("\n%d.%s", i + 1, string);
	}
	std::cout << "\n";
}

void ConsoleUi::list() {
	DynamicVector<Gene> dv;
	this->service->getGenes(&dv);
	this->service->sort(&dv);
	printGenes(&dv);
}

void ConsoleUi::find() {
	DynamicVector<Gene> dv;
	this->service->getGenes(&dv);

	std::string seq;
	std::cout << "Give sequence:"; std::getline(std::cin, seq);
	//this->service->filterBySequence(&dv, seq);

	this->service->sort(&dv);
	printGenes(&dv);
}

void ConsoleUi::runUi() {
	std::string command = ""; int trash;
	this->service->addSomeGenes();
	while (command != "exit") {
		this->menu();
		std::cin >> command;
		trash = getchar();
		try {
			if (command == "add") this->uiAddGene();
			else if (command == "lcs") ;
			else if (command == "find") this->find();
			else if (command == "list") this->list();
			else if (command != "exit") std::cout << "\nEnter a relevant command !\n";
		}
		catch (const char* msg) {
			std::cout << msg;
		}
	}
}