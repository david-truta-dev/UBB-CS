#include "BP.h"

BP::BP(std::string date, int systolicValue, int diastolicValue)
{
	this->setDate(date);
	this->systolicValue = systolicValue;
	this->diastolicValue = diastolicValue;
}

bool BP::isNormalValue()
{
	if(this->diastolicValue < 60 || this->diastolicValue > 79 || this->systolicValue < 90 || this->systolicValue > 119)
		return false;
	return true;
}

std::string BP::toString()
{
	char str[150];
	sprintf_s(str, 250, " %-20s | %-20s | %20s", this->date.c_str(), this->diastolicValue, this->systolicValue);
	return str;
}
