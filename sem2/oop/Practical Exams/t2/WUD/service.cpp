#include "service.h"
#include "BMI.h"
#include "BP.h"

bool Service::addBMI(std::string date, double value) {
	BMI bmi{ date, value };
	this->person.addMeasurement(bmi);
	return bmi.isNormalValue();
}

bool Service::addBP(std::string date, int s, int d) {
	BP bp{date, s, d};
	this->person.addMeasurement(bp);
	return bp.isNormalValue();
}

std::vector<Measurement*> Service::getMeasurements() {
	return this->person.getAllMeasurements();
}