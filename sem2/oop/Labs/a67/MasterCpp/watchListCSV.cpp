#include "watchListCSV.h"
#include <fstream>

WatchListCSV::WatchListCSV(){
	this->save();
}

void WatchListCSV::save() {
	std::ofstream fileTXT(this->file);
	std::ofstream fileCSV(this->CSVfile);
	for (auto t : this->data) {
		fileTXT << t << "\n";
		fileCSV << t.getTitle() << "," << t.getPresenter() << "," << t.getDuration().first << ":"
			<< t.getDuration().second << "," << t.getLikes() << "," << t.getLink() << "\n";
	}
	fileTXT.close();
	fileCSV.close();
}