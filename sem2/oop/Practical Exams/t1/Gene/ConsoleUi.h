#pragma once
#include "GeneService.h"

class ConsoleUi {

private:
	GeneService* service;

	void menu();
	void uiAddGene();
	void find();
	void list();


public:
	ConsoleUi(GeneService* gs);
	void runUi();

};