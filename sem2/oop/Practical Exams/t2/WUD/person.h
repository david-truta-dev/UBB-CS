#pragma once
#include "Measurments.h"
#include <vector>


class Person {
private:
	std::string name;
	std::vector<Measurement*> data;

public:
	void addMeasurement(Measurement a);
	std::vector<Measurement*> getAllMeasurements();
	std::vector<Measurement*> getAllMeasurementsByMonth(int month);
	bool isHealthy(int month);
	std::vector<Measurement*> getMeasurementsNewerThan(std::string date);
	void writeToFile(std::string fileName, std::string date);
};