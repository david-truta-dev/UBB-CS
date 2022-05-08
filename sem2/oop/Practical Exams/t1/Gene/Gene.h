#pragma once
#include <iostream>

typedef std::pair<int, int> Duration;

class Gene {

private:
	std::string organism;
	std::string name;
	std::string sequence;
	std::string id;

public:
	Gene(std::string organism, std::string name, std::string sequence);
	Gene() = default;
	std::string getId();
	std::string getOrganism();
	std::string getName();
	std::string getSequence();
	void toString(char str[]);

	Gene& operator = (const Gene& g);
	bool operator== (Gene g);
};