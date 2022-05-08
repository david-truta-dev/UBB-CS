#include "userService.h"

UserService::UserService(WatchList* wl){
	this->wl = wl;
}

void UserService::getTutorials(DynamicVector<Tutorial>* dv) {
	this->wl->getTutorials(dv);
}

void UserService::removeTutorial(int pos) {
	this->wl->removeTutorial(this->wl->getTutorial(pos).getLink());
}

void UserService::addTutorial(Tutorial t) {
	this->wl->addTutorial(t);
}

void UserService::watchTutorial(int pos, bool isIt) {
	Tutorial t = this->wl->getTutorial(pos);
	t.setWatched(isIt);
	this->wl->watchTutorial(t);
}

void UserService::filterByPresenter(DynamicVector<Tutorial>* dv, std::string presenter) {
	int i = 0; 
	if (presenter == "") return;
	while(i < dv->size()){
		if (dv->getTElem(i).getPresenter() != presenter) {
			dv->removeTElem(dv->getTElem(i));
			i--;
		}
		i++;
	}
}
