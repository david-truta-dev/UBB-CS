#include "tutorial.h"
#include "string.h"

Tutorial::Tutorial(std::string link, std::string title, std::string presenter, Duration duration, int likes){
	this->link = link;
	this->title = title;
	this->presenter = presenter;
	this->duration = duration;
	this->likes = likes;
}

std::string Tutorial::getId() {
	return this->id;
}

std::string Tutorial::getLink() {
	return this->link;
}

std::string Tutorial::getTitle() {
	return this->title;
}

void Tutorial::setTitle(std::string newTitle) {
	this->title = newTitle;
}

std::string Tutorial::getPresenter() {
	return this->presenter;
}

Duration Tutorial::getDuration() {
	return this->duration;
}

int Tutorial::getLikes() {
	return this->likes;
}

void Tutorial::setLikes(int likes) {
	this->likes = likes;
}

bool Tutorial::getWatched(){
	return this->watched;
}

void Tutorial::setWatched(bool isIt) {
	this->watched = isIt;
}

void Tutorial::toString(char str[]){sprintf_s(str, 250," Title: %s | Presentor: %s | Duration: %d:%d | Likes: %d | Link: %s", this->getTitle().c_str(), this->getPresenter().c_str(), this->getDuration().first, this->getDuration().second, this->getLikes(), this->getLink().c_str());}

Tutorial &Tutorial::operator=(const Tutorial& t) {
	this->id = t.id;
	this->link = t.link;
	this->title = t.title;
	this->presenter = t.presenter;
	this->duration = t.duration;
	this->likes = t.likes;
	this->watched = t.watched;

	return *this;
}

bool Tutorial::operator==(Tutorial t) {
	if (this->id != t.id || this->link != t.link || this->title != t.title ||
		this->presenter != t.presenter || this->duration != t.duration ||
		this->likes != t.likes)
		return false;
	return true;
}