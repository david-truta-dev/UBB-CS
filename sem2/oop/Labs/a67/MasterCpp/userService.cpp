#include "userService.h"
#include "watchListCSV.h"

UserService::UserService(WatchList* wl){
	this->wl = wl;
}

void UserService::getTutorials(std::vector<Tutorial>* dv) {
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

void UserService::filterByPresenter(std::vector<Tutorial>* dv, std::string presenter) {
	int i = 0; 
	if (presenter == "") return;
	while(i < dv->size()){
		if (dv->at(i).getPresenter() != presenter) {
			dv->erase(dv->begin() + i);
			i--;
		}
		i++;
	}
}

std::string UserService::getWlUpCast() {
	WatchListCSV* verif = dynamic_cast<WatchListCSV*> (this->wl);
	if (verif != NULL) {
		return "csv";
	}
	return "html";
}
