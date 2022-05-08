#include "tutorialDatabase.h"

void TutorialDatabase::addTutorial(Tutorial t) {
	this->data.addTElem(t);
}

void TutorialDatabase::removeTutorial(std::string link) {
	Tutorial t{link, "", "", Duration(0, 0), 0};
	this->data.removeTElem(t);
}

void TutorialDatabase::updateTutorial(Tutorial newT) {
	this->data.updateTElem(newT);
}

int TutorialDatabase::getNrOfTutorials() {
	return this->data.size();
}

void TutorialDatabase::getTutorials(DynamicVector<Tutorial>* dv) {
	dv->resetDynamicVector();
	for (int i = 0; i < this->data.size(); i++) {
		dv->addTElem(this->data.getTElem(i));
	}
}

void TutorialDatabase::likeTutorial(Tutorial t) {
	int poz = this->data.searchTElem(t);
	Tutorial T = this->data.getTElem(poz);
	if (t.getLikes() != T.getLikes()) {
		T.setLikes(T.getLikes() + 1);
		if (t == T) this->data.updateTElem(t);
	}
}