#pragma once
#include <string>
#include <sstream>

class Measurement {

protected:
	std::string date;

public:
	std::string getDate() { return this->date; };
	void setDate(std::string date) { this->date  = date; };
	virtual bool isNormalValue() { return false; };
	virtual std::string toString() { return ""; };
	int getMonth() {
		std::string m = ""; int month;
		for (int i = 0; i < date.size(); i++) {
			if (date[i] == '.') {
				m += date[i + 1] + date[i+2];
				std::stringstream M(m); M >> month;
				return month;
			}
		}
	};

};