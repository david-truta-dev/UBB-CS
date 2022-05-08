#pragma once
#include "adminService.h"
#include "userService.h"

class ConsoleUi {

private:
	AdminService* as;
	UserService* us;

	void chooseMode(AdminService*, UserService*);
	void adminMenu();
	void userMenu();
	void userBrowseMenu();
	void uiAddTutorialDatabase();
	void uiRemoveTutorialDatabase();
	void uiUpdateTutorialDatabase();
	void uiListTutorialsDatabase();
	void uiListWatchList();
	void uiListEWatchList();
	void uiWatchTutorial();
	void uiWatchLTutorial();
	void likeTutorial(int index);
	void uiDeleteTutorialWL();
	void uiDeleteLTutorialWL();
	void uiSaveTutorialWL(std::vector<Tutorial>* dataBase, int index);
	void uiNextTutorial(std::vector<Tutorial>*, int& );
	void uiBrowseHelp(std::vector<Tutorial>* dataBase, int index);
	void runBrowseMode();
	void runUserMode();
	void runAdminMode();
	
	

public:

	std::string chooseOutput();
	void runUi(AdminService*, UserService*);

};