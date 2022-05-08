#include "service.h"
#include "ConsoleUi.h"


int main() {

	Service s;
	ConsoleUi u{ &s };
	u.run();
}