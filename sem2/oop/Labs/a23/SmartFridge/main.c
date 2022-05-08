#include "consoleUi.h"
#include "allTests.h"
#define _CRTDBG_MAP_ALLOC
#include <crtdbg.h>

int main() {
	//_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
	runAllTests();

	ProductRepo repo = createProductRepo();
	UndoRedo* ur = createUndoRedo();
	ProductService service = createProductService(&repo, ur);
	ConsoleUi ui = createConsoleUi(&service);

	run(&ui);
	
	destroyProductRepo(&repo);
	destroyUndoRedo(ur);
	_CrtDumpMemoryLeaks();
}

//-fkin' undo/redo
//-Source code must be specified and include tests for all non-UI functions
