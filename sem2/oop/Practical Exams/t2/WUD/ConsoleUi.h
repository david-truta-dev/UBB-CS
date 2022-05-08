#pragma once
#include "service.h"

class ConsoleUi {
private:
	Service* service;

public:
	ConsoleUi(Service* s);
	void menu();
	void uiAddMeasurement();
	void uiList();
	void run();

};