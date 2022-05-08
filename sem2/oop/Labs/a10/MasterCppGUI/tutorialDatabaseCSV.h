#pragma once
#include "tutorialDatabase.h"

class TutorialDatabaseCSV : public TutorialDatabase {

private:
	std::string CSVfile = "tutorialDatabase.csv";

public:

	TutorialDatabaseCSV();
	void save();
	virtual ~TutorialDatabaseCSV() {};
};