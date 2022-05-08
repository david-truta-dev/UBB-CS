#pragma once
#include "Measurments.h"

class BMI : public Measurement {
private:
	double value;
public:
	BMI(std::string date, double value);
	bool isNormalValue();
	std::string toString() override;
};