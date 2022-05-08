#include "watchList.h"

void WatchList::addTutorial(Tutorial t){
	this->data.addTElem(t);
}

void WatchList::removeTutorial(std::string l){
	Tutorial t0{ l,"","", Duration(0,0),0 };
	int poz = this->data.searchTElem(t0);
	Tutorial t = this->data.getTElem(poz);
	if (t.getWatched() == false)
		throw "\nThe tutorial was not watched ! Please watch it :)\n";
	this->data.removeTElem(t);
}

Tutorial WatchList :: getTutorial(int pos) {
	return this->data.getTElem(pos);
}

void WatchList::getTutorials(DynamicVector<Tutorial>* dv){
	dv->resetDynamicVector();
	for (int i = 0; i < this->data.size(); i++) {
		dv->addTElem(this->data.getTElem(i));
	}
}

void WatchList::watchTutorial(Tutorial t) {
	int poz = this->data.searchTElem(t);
	Tutorial T = this->data.getTElem(poz);
	if (t.getWatched() != T.getWatched()) {
		T.setWatched(true);
		if (t == T) this->data.updateTElem(t);
	}
}
