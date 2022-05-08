#include "EthnologistRepo.h"

EthnologistRepo::EthnologistRepo(std::string s)
{
	this->fileName = s;
	this->load();
}

void EthnologistRepo::load()
{
	std::ifstream f(this->fileName);
	Ethnologist e{ "", "" };
	while (f >> e) {
		this->add(e);
	}
	f.close();
}

void EthnologistRepo::save()
{

}