#include "tutorialDatabaseCSV.h"
#include <fstream>

TutorialDatabaseCSV::TutorialDatabaseCSV() {
	this->save();
}

void TutorialDatabaseCSV::save() {
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
