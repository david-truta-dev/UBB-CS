#include <iostream>
#define _CRTDBG_MAP_ALLOC
#include <stdlib.h>
#include <crtdbg.h>
#include "allTests.h"
#include "consoleUi.h"
#include "watchList.h"

void run() {
	testAll();

	TutorialDatabase td;
	WatchList wl;
	AdminService as{ &td };
	UserService us{ &wl };
	ConsoleUi u;
	// Comment next line before checking coverage.
	u.runUi(&as, &us);
}

int main() {
	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);

	run();

	_CrtDumpMemoryLeaks();
	return 0;
}
