#include "Ethnologist.h"

std::istream& operator>>(std::istream& is, Ethnologist& e) {
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
			e.name = atribute;
		}
		else if (j == 2) {
			e.theme = atribute;
		}
		i++;
	}
	return is;
}

Ethnologist::Ethnologist(std::string name, std::string theme)
{
	this->name = name;
	this->theme = theme;
}

std::string Ethnologist::getName()
{
	return this->name;
}

bool Ethnologist::operator==(Ethnologist& e1)
{
	if (this->name == e1.name && this->theme == e1.theme)
		return true;
	return false;
}
