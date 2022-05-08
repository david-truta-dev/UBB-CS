#pragma once
#include "Measurments.h"

class BP : public Measurement {

private:
	int systolicValue;
	int diastolicValue;

public:
	BP(std::string date, int systolicValue, int diastolicValue);
	bool isNormalValue();
	std::string toString() override;

};