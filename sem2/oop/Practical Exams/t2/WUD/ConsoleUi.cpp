#include "ConsoleUi.h"
#include <iostream>
#include <string>

ConsoleUi::ConsoleUi(Service* s) {
	this->service = s;
}

void ConsoleUi::menu() {
	std::cout << "\n Available commands:\n'add' - add measurement.\n"\
		"'remove' - remove tutorial from database.\n"\
		"'update' - update tutorial from database.\n"\
		"'list' - list all tutorials in database, from a given presenter.\n"\
		"'exit' - exit the app.\n> ";
}

void ConsoleUi::uiAddMeasurement() {
	int trash, dValue, sValue; std::string type, date; double value;
	std::cout << "\n -------- Reading Measurement Data -------- ";
	std::cout << "Date:"; std::getline(std::cin, date);
	std::cout << "Type:"; std::getline(std::cin, type);
	if (type == "bmi") {
		std::cout << "Value:  "; std::cin >> value;
		bool ok = this->service->addBMI(date, value);
		std::cout << "The measurement is ok :" << ok;
	}
	else if (type == "bp") {
		std::cout << "systolic value:  "; std::cin >> sValue;
		std::cout << "diastolic value:  "; std::cin >> dValue;
		bool ok = this->service->addBP(date, sValue, dValue);
		std::cout << "The measurement is ok :" << ok;
	}
	else throw std::exception("This type does not exist");
}

void ConsoleUi::uiList() {
	std::vector<Measurement*> v = this->service->getMeasurements();
	for (auto m : v) {
		//std::cout << *m.toString();
	}
}

void ConsoleUi::run()
{
	std::string command = ""; int trash;
	while (command != "exit") {
		this->menu();
		std::cin >> command;
		trash = getchar();
		try {
			if (command == "add") this->uiAddMeasurement();
			else if (command == "remove");
			else if (command == "update");
			else if (command == "list")this->uiList();
			else if (command != "exit") std::cout << "\nEnter a relevant command !\n";
		}
		catch (std::exception& e) {
			std::cout << "\n" << e.what() << "\n";
		}
	}
}
