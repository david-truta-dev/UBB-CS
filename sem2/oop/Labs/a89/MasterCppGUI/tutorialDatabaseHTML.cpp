#include "tutorialDatabaseHTML.h"
#include <fstream>

TutorialDatabaseHTML::TutorialDatabaseHTML() {
	this->save();
}

void TutorialDatabaseHTML::save() {
	std::ofstream fileTXT(this->file);
	std::ofstream fileHTML(this->HTMLfile);
	fileHTML << "<!DOCTYPE html>\n\
		<html>\n\
		<head>\n\
		<title>Tutorial Database</title> \n\
		</head>\n\
		<body>\n\
		<table border = \"1\">\n\
		<tr>\n\
		<td>Title</td>\n\
		<td>Presenter</td>\n\
		<td>Duration</td>\n\
		<td>Likes</td>\n\
		<td>Youtube link</td>\n\
		</tr>\n";
	for (auto t : this->data) {
		fileTXT << t << "\n";
		fileHTML << "<tr>\n" << "<td>" << t.getTitle() << "</td>\n<td>" << t.getPresenter() << "</td>\n<td>" << t.getDuration().first << ":"
			<< t.getDuration().second << "</td>\n<td>" << t.getLikes() << "</td>\n<td>" << t.getLink() << "</td>\n</tr>\n";
	}
	fileHTML << "</table>\n</body >\n</html>";
	fileTXT.close();
	fileHTML.close();
}
