#include "person.h"

void Person::addMeasurement(Measurement a)
{
	this->data.push_back(&a);
}

std::vector<Measurement*> Person::getAllMeasurements()
{
	return this->data;
}

std::vector<Measurement*> Person::getAllMeasurementsByMonth(int month)
{
	/*std::vector<Measurement*> res;
	for (auto m : this->data) {
		if (m.getMonth() == month)
			res.push_back(m);
	}
	return res;*/
}

bool Person::isHealthy(int month)
{
	return false;
}

std::vector<Measurement*> Person::getMeasurementsNewerThan(std::string date)
{
	std::vector<Measurement*> res;
	return res;
}

void Person::writeToFile(std::string fileName, std::string date)
{
}
