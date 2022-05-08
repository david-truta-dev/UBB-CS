#include "watchList.h"
#include <iostream>
#include <fstream>

WatchList::WatchList(){
	this->load();
}

WatchList::WatchList(std::string fileName){
	this->file = fileName;
	this->load();
}

void WatchList::save(){
	std::ofstream file(this->file);
	for (auto tut : this->data) {
		file << tut << "\n";
	}
	file.close();
}

void WatchList::load(){
	std::ifstream file(this->file);
	Tutorial tut{ "","","", Duration(0,0), 0 };
	while (file >> tut) {
		this->addTutorial(tut);
	}
	file.close();
}

void WatchList::addTutorial(Tutorial t){
	for (auto tut : this->data) {
		if (tut.getLink() == t.getLink())
			throw WatchListException("This tutorial already exists!");
	}
	this->data.push_back(t);
	this->save();
}

void WatchList::removeTutorial(std::string l){
	for (auto tut : this->data) {
		if (tut.getLink() == l) {
			if (tut.getWatched() == false)
				throw WatchListException("This tutorial was not watched :(");
			this->data.erase(std::remove(this->data.begin(), this->data.end(), tut), this->data.end());
			this->save();
			return;
		}
	}
	throw WatchListException("This tutorial doesn't exists!");
}

Tutorial WatchList :: getTutorial(int pos) {
	return this->data[pos];
}

void WatchList::getTutorials(std::vector<Tutorial>* dv){
	*dv = this->data;
}

void WatchList::watchTutorial(Tutorial t) {
	for (auto& tut : this->data)
		if (tut.getLink() == t.getLink()){
			tut.setWatched(true);
			this->save();
		}
}
