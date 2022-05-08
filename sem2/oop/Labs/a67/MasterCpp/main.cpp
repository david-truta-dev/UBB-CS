#include <iostream>
#define _CRTDBG_MAP_ALLOC
#include <stdlib.h>
#include <crtdbg.h>
#include "allTests.h"
#include "consoleUi.h"
#include "watchList.h"
#include "watchListCSV.h"
#include "watchListHTML.h"
#include "tutorialDatabaseCSV.h"
#include "tutorialDatabaseHTML.h"

void run() {
	testAll();

	TutorialDatabase* td = new TutorialDatabase;
	WatchList* wl = new WatchList;
	ConsoleUi u;
	std::string output = u.chooseOutput();
	if ("csv" == output) {
		delete td;
		delete wl;
		td = new TutorialDatabaseCSV;
		wl = new WatchListCSV;
	}
	else if ("html" == output) {
		delete td;
		delete wl;
		td = new TutorialDatabaseHTML;
		wl = new WatchListHTML;
	}
	else if ("exit" == output) {
		delete td;
		delete wl;
		return;
	}

	AdminService as{ td };
	UserService us{ wl };
	u.runUi(&as, &us);
	delete td;
	delete wl;
}

int main() {
	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);

	run();

	_CrtDumpMemoryLeaks();
	return 0;
}
