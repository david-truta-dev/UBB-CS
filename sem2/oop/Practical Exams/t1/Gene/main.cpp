#include <iostream>
#include <stdlib.h>
#include <crtdbg.h>
#include "GeneRepo.h"
#include "GeneService.h"
#include "ConsoleUi.h"


void run() {

	GeneRepo gr;
	GeneService gs{ &gr };
	ConsoleUi u{ &gs };

	u.runUi();
}

int main() {

	run();

	return 0;
}
