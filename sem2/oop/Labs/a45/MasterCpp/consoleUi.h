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
	void uiWatchTutorial();
	void uiWatchLTutorial();
	void likeTutorial(int index);
	void uiDeleteTutorialWL();
	void uiDeleteLTutorialWL();
	void uiSaveTutorialWL(DynamicVector<Tutorial>* dataBase, int index);
	void uiNextTutorial(DynamicVector<Tutorial>*, int& );
	void uiBrowseHelp(DynamicVector<Tutorial>* dataBase, int index);
	void runBrowseMode();
	void runUserMode();
	void runAdminMode();
	
	

public:

	void runUi(AdminService*, UserService*);

};