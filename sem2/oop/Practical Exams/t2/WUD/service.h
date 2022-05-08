#pragma once
#include "person.h"

class Service{
private:
	Person person;

public:

	bool addBMI(std::string data, double value);
	bool addBP(std::string data, int s, int d);

	std::vector<Measurement*> getMeasurements();

};
