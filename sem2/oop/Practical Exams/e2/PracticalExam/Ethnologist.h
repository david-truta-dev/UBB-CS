#pragma once
#include <iostream>
#include <string>
#include <fstream>

class Ethnologist {

private:
	std::string name;
	std::string theme;

public:
	Ethnologist(std::string name, std::string theme);
	std::string getName();
	std::string getTheme() { return this->theme; }
	friend std::istream& operator>>(std::istream& is, Ethnologist& e);
	bool operator==(Ethnologist& e1);
};

