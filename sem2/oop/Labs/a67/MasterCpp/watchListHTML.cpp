#include "watchListHTML.h"
#include <fstream>

WatchListHTML::WatchListHTML(){
	this->save();
}

void WatchListHTML::save() {
	std::ofstream fileTXT(this->file);
	std::ofstream fileHTML(this->HTMLfile);
	fileHTML << "<!DOCTYPE html>\n\
		<html>\n\
		<head>\n\
		<title>Tutorial Watch List</title> \n\
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
	fileHTML << "</table>\n</body>\n</html>";
	fileTXT.close();
	fileHTML.close();
}
