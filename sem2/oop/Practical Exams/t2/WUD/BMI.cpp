#include "BMI.h"

BMI::BMI(std::string date, double value)
{
	this->setDate(date);
	this->value = value;
}

bool BMI::isNormalValue()
{
	if(this->value < 18.5 || this->value > 25)
		return false;
	return true;
}

std::string BMI::toString()
{
	char str[150];
	sprintf_s(str, 250, " %-20s | %-20s ", this->date.c_str(), this->value);
	return str;
}
