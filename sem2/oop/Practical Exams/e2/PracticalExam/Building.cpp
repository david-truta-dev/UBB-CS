#include "Building.h"

std::istream& operator>>(std::istream& is, Building& b) {
	std::string line, atribute; int i = 0, j = 0;
	std::getline(is, line);
	while (i < line.size()) {
		atribute = "";
		while (line[i] != ';' && i < line.size()) {
			atribute += line[i];
			i++;
		}
		j++;
		if (j == 1) {
			b.id = atribute;
		}
		else if (j == 2) {
			b.description = atribute;
		}
		else if (j == 3) {
			b.theme = atribute;
		}
		else if (j == 4) {
			b.location = atribute;
		}
		i++;
	}
	return is;
}

Building::Building(std::string id, std::string description, std::string theme, std::string locatio)
{
	this->id = id;
	this->description = description;
	this->theme = theme;
	this->location = location;
}

bool Building::operator==(Building& b)
{
	if (this->id == b.id)
		return true;
	return false;
}
