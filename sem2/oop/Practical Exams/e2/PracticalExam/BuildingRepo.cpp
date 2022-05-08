#include "BuildingRepo.h"

BuildingRepo::BuildingRepo(std::string s)
{
	this->fileName = s;
	this->load();
}

void BuildingRepo::load(){
	std::ifstream f(this->fileName);
	Building b{ "", "", "", ""};
	while (f >> b) {
		this->add(b);
	}
	f.close();
}

void BuildingRepo::save()
{
}
