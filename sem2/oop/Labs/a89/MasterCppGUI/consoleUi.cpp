#include "consoleUi.h"
#include <iostream>
#include <Windows.h>
#include <shellapi.h>
#include <sstream>
#include <algorithm>

void ConsoleUi::chooseMode(AdminService* as, UserService* us) {
	std::string mode = ""; int trash;
	while (mode != "user" && mode != "admin") {
		std::cout << "\n Choose mode: \n'user' - user mode\n'admin' - administrator mode\n'exit'- exit\n> ";
		std::cin >> mode;
		trash = getchar();
		if (mode == "user") {
			this->us = us;
			this->as = as;
		}
		else if (mode == "admin") {
			this->as = as;
			this->us = NULL;
		}
		else if (mode == "exit") {
			this->us = NULL;
			this->as = NULL;
			break;
		}
		else std::cout << "\nEnter a relevant command!\n";
	}
}

std::string ConsoleUi::chooseOutput() {
	std::string op = ""; int trash;
	while (op != "csv" && op != "html") {
		std::cout << "\n Choose an output mode: \n'html' - stores in tutorials in a html file.\n'csv' - stores in tutorials in a csv file \n'exit'- exit\n> ";
		std::cin >> op;
		trash = getchar();
		if (op == "csv" || op == "html" || op == "exit") {
			return op;
		}
		else std::cout << "\nEnter a relevant command!\n";
	}
}

void ConsoleUi::adminMenu() {
	std::cout << "\n Available commands for admin:\n'add' - add tutorial to database.\n"\
		"'remove' - remove tutorial from database.\n"\
		"'update' - update tutorial from database.\n"\
		"'list' - list all tutorials in database, from a given presenter.\n"\
		"'exit' - exit the app.\n> ";
}

void ConsoleUi::userMenu() {
	std::cout << "\n--------------- Available commands for user ---------------\n'browse' - see the tutorials in the database one by one.\n"\
		"'list' - list all tutorials in watch list, from a given presenter.\n"\
		"'listE' - list all tutorials in watch list in Excel/Browser.\n"\
		"'watch' - watch a tutorial from watch  list.\n"\
		"'watchL' - watch a tutorial from watchlist using the link.(this also opens the tutorial in the browser)\n"\
		"'delete' - delete a tutorial from watch list.\n"\
		"'deleteL' - delete a tutorial from watch list using the link.\n"\
		"'exit' - exit the app.\n> ";
}

void ConsoleUi::userBrowseMenu() {
	std::cout << "\n------------ Available commands for browse mode ------------\n'save' - saves current tutorial to the watchlist.\n"\
		"'next' - see the next tutorial in the database.\n"\
		"'list' - list all tutorials from watch list.\n"\
		"'help' - bring up the menu again.\n"\
		"'exit' - exit the browse mode.\n";
}

//bool isDigits(const std::string& str){
//	return str.find_first_not_of("0123456789") == std::string::npos;
//}
//
//Duration splitDuration(std::string d) {
//	std::string minutes, seconds; int m, s;
//	int i = 0;
//	while( i < d.size() && d[i] != ':'){
//		minutes += d[i];
//		i++;
//	}
//	if (d.size() == i) { seconds = minutes; minutes = "0"; }
//	else {
//		i++;
//		while (i < d.size()) { seconds += d[i]; i++; }
//	}
//	if (isDigits(minutes) == false || isDigits(seconds) == false) throw "\nDuration should be a positive number!\n";
//	std::stringstream M(minutes), S(seconds);
//	M >> m; S >> s;
//	return Duration(m, s);
//}

//void readTutorialData(std::string &link, std::string &title, std::string &presenter, Duration &duration, int &likes) {
//	int trash;
//	std::cout << "\n -------- Reading Tutorial Data -------- \nLink:"; getline(std::cin, link);
//	std::cout << "Title:"; std::getline(std::cin, title);
//	std::cout << "Presenter:"; std::getline(std::cin, presenter);
//	std::string d, l;
//	std::cout << "Duration(min:sec OR sec):  "; std::cin >> d; duration = splitDuration(d); trash = getchar();
//	std::cout << "Likes:"; std::cin >> l; trash = getchar();
//	if (isDigits(l) == false) throw "\nLikes should be a positive number!\n";
//	std::stringstream L(l); L >> likes;
//}

void ConsoleUi::uiAddTutorialDatabase() {
	std::string link, title, presenter;
	Duration duration;
	int likes=0;
	//readTutorialData(link, title, presenter, duration, likes);
	this->as->addTutorial(link, title, presenter, duration, likes);
	std::cout << "\nAdd was successful !\n";
}

void ConsoleUi::uiRemoveTutorialDatabase() {
	std::string link; int trash;
	std::cout << "Give link:"; std::getline(std::cin, link);
	this->as->removeTutorial(link);
	std::cout << "\nRemove was successful !\n";
}

void ConsoleUi::uiUpdateTutorialDatabase() {
	std::string link, title, presenter;
	Duration duration;
	int likes = 0;
	//readTutorialData(link, title, presenter, duration, likes);
	this->as->updateTutorial(link, title, presenter, duration, likes);
	std::cout << "\nUpdate was successful !\n";
}

void printTutorials(std::vector<Tutorial>* dv) {
	if (dv->size() == 0) std::cout << "\nThere are no Tutorials in the database.\n";
	for (int i = 0; i < dv->size(); i++) {
		char string[250]; dv->at(i).toString(string);
		printf("\n%d.%s", i + 1, string);
	}
	std::cout << "\n";
}

void ConsoleUi::uiListTutorialsDatabase() {
	std::vector<Tutorial> dv;
	this->as->getTutorials(&dv);
	printTutorials(&dv);
}

void ConsoleUi::uiListWatchList() {
	// Read presenter: 
	std::string presenter;
	std::cout << "Give presenter:"; std::getline(std::cin, presenter);
	std::vector<Tutorial> dv, res;
	this->us->getTutorials(&dv);
	if (presenter != "") {
		std::copy_if(dv.begin(), dv.end(), std::back_inserter(res), [presenter](Tutorial tut) {
			return (tut.getPresenter() == presenter);
			});
		printTutorials(&res);
	}
	else printTutorials(&dv);
}

void ConsoleUi::uiListEWatchList() {
	if (this->us->getWlUpCast() == "csv")
		ShellExecuteA(NULL, NULL, "watchList.csv", NULL , NULL, SW_SHOWMAXIMIZED);
	else
		ShellExecuteA(NULL, NULL, "watchList.html", NULL, NULL, SW_SHOWMAXIMIZED);
}

void ConsoleUi::uiSaveTutorialWL(std::vector<Tutorial>* dataBase, int index) {
	this->us->addTutorial(dataBase->at(index));
	printf("\nSaved current tutorial to watch list.");
}

int readIndex() {
	//std::string nr; int Nr;
	//std::cout << "Give index of tutorial you want: "; std::cin >> nr;
	//if (isDigits(nr) == false) throw "\nGive a positive numer !!!\n";
	//std::stringstream NR(nr); NR >> Nr;
	//return Nr;
	return 0;
}

void ConsoleUi::uiWatchTutorial() {
	this->us->watchTutorial(readIndex() - 1);
	printf("\nYou watched the tutorial !\n");
}

void ConsoleUi::uiWatchLTutorial() {
	std::string link; bool watched = false;
	std::cout << "Give link:"; std::getline(std::cin, link);
	std::vector<Tutorial> dv; this->us->getTutorials(&dv);
	for (int i = 0; i < dv.size(); i++)
		if (link == dv[i].getLink())
		{
			printf("\nYou watched the tutorial !\n");
			ShellExecuteA(NULL, NULL, "chrome.exe", link.c_str(), NULL, SW_SHOWMAXIMIZED);
			this->us->watchTutorial(i);
			watched = true;
		}
	if (!watched)printf("\nTutorial not found!\n");
}

void ConsoleUi::uiDeleteTutorialWL() {
	int index = readIndex(), trash; char answer;
	std::vector<Tutorial> dv; this->us->getTutorials(&dv);
	this->us->removeTutorial(index - 1);
	printf("\nThe tutorial was removed.\n");
	printf("Do you want to give the tutorial a like ? ('y'/'n')\n>");
	std::cin >> answer; trash = getchar(); if (answer == 'Y') answer += 'a' - 'A';
	if (answer == 'y') {
		//this->as->likeTutorial(&dv, index - 1);
	}
}

void ConsoleUi::uiDeleteLTutorialWL() {
	int trash, index; char answer; bool removed = false;
	std::string link;
	std::cout << "Give link:"; std::getline(std::cin, link);
	std::vector<Tutorial> dv; this->us->getTutorials(&dv);
	for (int i = 0; i < dv.size(); i++)
		if (link == dv[i].getLink())
		{
			this->us->removeTutorial(i);
			index = i;
			removed = true;
		}
	if (removed) {
		printf("\nThe tutorial was removed.\n");
		printf("Do you want to give the tutorial a like ? ('y'/'n')\n>");
		std::cin >> answer; trash = getchar(); if (answer == 'Y') answer += 'a' - 'A';
		if (answer == 'y') {
			//this->as->likeTutorial(&dv, index - 1);
		}
	}
	else std::cout << "Tutorial was not found";
}

void ConsoleUi::uiNextTutorial(std::vector<Tutorial>* dataBase,int& index){
	index += 1;
	if (index == dataBase->size()) index = 0;
	char string[250]; dataBase->at(index).toString(string);
	printf("\n%d.%s", index + 1, string);
}

void ConsoleUi::uiBrowseHelp(std::vector<Tutorial>* dataBase, int index){
	this->userBrowseMenu();
	char string[250]; dataBase->at(index).toString(string);
	printf("\n%d.%s", index + 1, string);
}

void ConsoleUi::runBrowseMode() {
	std::string command = ""; int trash, index = 0;
	std::vector<Tutorial> dataBase;
	this->as->getTutorials(&dataBase);
	this->userBrowseMenu();
	char string[250]; dataBase.at(index).toString(string);
	printf("\n%d.%s", index + 1, string);
	while (command != "exit") {
		std::cout << "\n\n>"; std::cin >> command;
		trash = getchar();
		try {
			if (command == "save") this->uiSaveTutorialWL(&dataBase, index);
			else if (command == "next") this->uiNextTutorial(&dataBase, index);
			else if (command == "list") this->uiListWatchList();
			else if (command == "help") this->uiBrowseHelp(&dataBase, index);
			else if (command != "exit") std::cout << "\nEnter a relevant command !\n";
		}
		catch (WatchListException& e) {
			std::cout << "\n" << e.what() << "\n";
		}
	}
}

void ConsoleUi::runUserMode() {
	std::string command = ""; int trash;
	while (command != "exit") {
		this->userMenu();
		std::cin >> command;
		trash = getchar();
		try {
			if (command == "browse") this->runBrowseMode();
			else if (command == "list") this->uiListWatchList();
			else if (command == "listE") this->uiListEWatchList();
			else if (command == "watch") this->uiWatchTutorial();
			else if (command == "watchL") this->uiWatchLTutorial();
			else if (command == "delete") this->uiDeleteTutorialWL();
			else if (command == "deleteL") this->uiDeleteLTutorialWL();
			else if (command != "exit") std::cout << "\nEnter a relevant command !\n";
		}
		catch (WatchListException& e) {
			std::cout << "\n" << e.what() << "\n";
		}
	}
}

void ConsoleUi::runAdminMode() {
	std::string command = ""; int trash;
	while (command != "exit") {
		this->adminMenu();
		std::cin >> command;
		trash = getchar();
		try {
			if (command == "add") this->uiAddTutorialDatabase();
			else if (command == "remove") this->uiRemoveTutorialDatabase();
			else if (command == "update") this->uiUpdateTutorialDatabase();
			else if (command == "list") this->uiListTutorialsDatabase();
			else if (command != "exit") std::cout << "\nEnter a relevant command !\n";
		}
		catch (TutorialValidatorException& e) {
			std::cout<<"\n" << e.what()<<"\n";
		}
		catch (TutorialDatabaseException& e) {
			std::cout << "\n" << e.what() << "\n";
		}
	}
}

void ConsoleUi::runUi(AdminService* as, UserService* us) {
	this->chooseMode(as, us);
	if (this->as == NULL && this->us == NULL) return ;
	//this->as->add10Tutorials();
	if (this->as != NULL && this->us == NULL) runAdminMode();
	else runUserMode();
}