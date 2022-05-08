#pragma once
#include "tutorialDatabase.h"

class TutorialDatabaseHTML : public TutorialDatabase {

private:
	std::string HTMLfile = "tutorialDatabase.html";

public:

	TutorialDatabaseHTML();
	virtual ~TutorialDatabaseHTML() {};
	void save();

};
