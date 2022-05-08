#include "adminService.h"

AdminService::AdminService(TutorialDatabase* td) {
	this->td = td;
}

void AdminService::add10Tutorials() {
	this->addTutorial("https://www.youtube.com/watch?v=zOjov-2OZ0E", "Object Oriented Programming", "GeeksCode", Duration(10, 18), 2321);
	this->addTutorial("https://www.youtube.com/watch?v=_uQrJ0TkZlc", "C++ Classes", "LearnCodeFast", Duration(7, 46), 421);
	this->addTutorial("https://www.youtube.com/watch?v=3NndCfFQNHA", "Fundamentals of Programming", "GeeksCode", Duration(24, 45), 62341);
	this->addTutorial("https://www.youtube.com/watch?v=bJzb-RuUcMU", "Data Structures and Algorithms", "LitCode", Duration(9, 13), 2431);
	this->addTutorial("https://www.youtube.com/watch?v=Z1Yd7upQsXY", "HTML5", "LearnCodeFast", Duration(4, 43), 7234);
	this->addTutorial("https://www.youtube.com/watch?v=rfscVS0vtbw", "Javascript", "LitCode", Duration(11, 32), 1340);
	this->addTutorial("https://www.youtube.com/watch?v=KJgsSFOSQv0", "IA 32 8086", "LowLevel", Duration(31, 54), 5213);
	this->addTutorial("https://www.youtube.com/watch?v=MAlSjtxy5ak", "Graphs", "LitCode", Duration(13, 42), 1432);
	this->addTutorial("https://www.youtube.com/watch?v=eIrMbAQSU34", "Operating Systems", "LearnCodeFast", Duration(4, 18), 412);
	this->addTutorial("https://www.youtube.com/watch?v=yufRLksxdLo", "UNIX Shell Programming", "GeeksCode", Duration(17, 32), 3124);
}


void AdminService::addTutorial(std::string link, std::string title, std::string presenter, Duration duration, int likes) {
	Tutorial tut{link, title, presenter, duration, likes};
	this->tv.validateTutorial(tut);
	this->td->addTutorial(tut);
}

void AdminService::removeTutorial(std::string link) {
	this->td->removeTutorial(link);
}

void AdminService::updateTutorial(std::string link, std::string title, std::string presenter, Duration duration, int likes) {
	Tutorial tut{ link, title, presenter, duration, likes };
	this->tv.validateTutorial(tut);
	this->td->updateTutorial(tut);
}

int AdminService::getNrOfTutorials() {
	return this->td->getNrOfTutorials();
}

void AdminService::getTutorials(std::vector<Tutorial>* dv) {
	this->td->getTutorials(dv);
}

void AdminService::likeTutorial(std::string link) {
	std::vector<Tutorial> dv;
	this->td->getTutorials(&dv);
	for (auto tut : dv) {
		if (tut.getLink() == link) {
			tut.setLikes(tut.getLikes() + 1);
			this->td->likeTutorial(tut);
			break;
		}
	}
}

void AdminService::filterByPresenter(std::vector<Tutorial>* dv, std::string presenter) {
	int i = 0;
	if (presenter == "") return;
	while (i < dv->size()) {
		if (dv->at(i).getPresenter() != presenter) {
			dv->erase(dv->begin() + i);
			i--;
		}
		i++;
	}
}