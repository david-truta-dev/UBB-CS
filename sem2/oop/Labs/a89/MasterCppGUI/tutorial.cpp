#include "tutorial.h"
#include "string.h"
#include <sstream>
#include <string>

Tutorial::Tutorial(std::string link, std::string title, std::string presenter, Duration duration, int likes){
	this->link = link;
	this->title = title;
	this->presenter = presenter;
	this->duration = duration;
	this->likes = likes;
}

Tutorial::Tutorial(const Tutorial& t)
{
	this->id = t.id;
	this->link = t.link;
	this->title = t.title;
	this->presenter = t.presenter;
	this->duration = t.duration;
	this->likes = t.likes;
	this->watched = t.watched;
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

void Tutorial::setPresenter(std::string newPresenter) {
	this->title = newPresenter;
}

Duration Tutorial::getDuration() {
	return this->duration;
}

void Tutorial::setDuration(Duration d) {
	this->duration = d;
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

void Tutorial::toString(char str[]){
	sprintf_s(str, 250," %-60s | %-30s | %d:%d |  %-7d |  %-60s ", this->getTitle().c_str(), this->getPresenter().c_str(), this->getDuration().first, this->getDuration().second, this->getLikes(), this->getLink().c_str());
}

Tutorial& Tutorial::operator=(const Tutorial& t) {
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

std::ostream& operator<<(std::ostream& os, const Tutorial& t){
	os << t.link << ";" << t.title << ";" << t.presenter << ";" << t.duration.first
		<< ";" << t.duration.second << ";" << t.likes << ";" << t.watched;
	return os;
}

std::istream& operator>>(std::istream& is, Tutorial& t){
	std::string line, atribute; int i = 0, j = 0;
	std::stringstream conversion;
	std::getline(is, line);
	while (i < line.size()) {
		atribute = "";
		while (line[i]!=';' && i < line.size()){
			atribute += line[i];
			i++;
		}
		j++;
		if (j == 1) {
			t.link = atribute;
		}
		else if (j == 2) {
			t.title = atribute;
		}
		else if (j == 3) {
			t.presenter = atribute;
		}
		else if (j == 4) {
			conversion.clear();
			conversion << atribute;
			conversion >> t.duration.first;
		}
		else if (j == 5) {
			conversion.clear();
			conversion << atribute;
			conversion >> t.duration.second;
		}
		else if (j == 6) {
			conversion.clear();
			conversion << atribute;
			conversion >> t.likes;
		}
		else if (j == 7) {
			if (atribute == "1") {
				t.watched = true;
			}else t.watched = false;
		}
		i++;
	}
	return is;
}
