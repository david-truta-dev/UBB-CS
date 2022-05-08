#pragma once
#include "GenericRepo.h"
#include "Ethnologist.h"
#include <fstream>

class EthnologistRepo : public Repo<Ethnologist> {
private:
	std::string fileName;

public:

	EthnologistRepo(std::string s);

	virtual ~EthnologistRepo() { }

	void load();

	void save();

};