#include "tutorialDatabase.h"
#include <iostream>
#include <fstream>

TutorialDatabase::TutorialDatabase() {
	this->load();
}

TutorialDatabase::TutorialDatabase(std::string fileName) {
	this->file = fileName;
	this->load();
}

void TutorialDatabase::save() {
	std::ofstream file(this->file);
	for (auto tut : this->data) {
		file << tut << "\n";
	}
	file.close();
}

void TutorialDatabase::load() {
	std::ifstream file(this->file);
	Tutorial tut{"","","", Duration(0,0), 0};
	while (file >> tut) {
		this->addTutorial(tut);
	}
	file.close();
}

void TutorialDatabase::addTutorial(Tutorial t) {
	for (auto tut : this->data) {
		if (tut.getLink() == t.getLink())
			throw TutorialDatabaseException("This tutorial already exists!");
	}
	this->data.push_back(t);
	this->save();
}

void TutorialDatabase::removeTutorial(std::string link) {
	for (auto tut : this->data) {
		if (tut.getLink() == link) {
			this->data.erase(std::remove(this->data.begin(), this->data.end(), tut), this->data.end());
			this->save();
			return;
		}
	}
	throw TutorialDatabaseException("This tutorial doesn't exists!");
}

void TutorialDatabase::updateTutorial(Tutorial newT) {
	for (auto& tut : this->data) {
		if (tut.getLink() == newT.getLink()) {
			tut = newT;
			this->save();
			return;
		}
	}
	throw TutorialDatabaseException("This tutorial doesn't exists!");
}

int TutorialDatabase::getNrOfTutorials() {
	return this->data.size();
}

void TutorialDatabase::getTutorials(std::vector<Tutorial>* dv) {
	*dv = this->data;
}

void TutorialDatabase::likeTutorial(Tutorial t) {
	for (auto& tut : this->data) 
		if (tut.getLink() == t.getLink()) {
			tut.setLikes(tut.getLikes() + 1);
			this->save();
		}
}