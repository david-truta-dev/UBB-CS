#include "Gene.h"

Gene::Gene(std::string organism, std::string name, std::string sequence) {
	this->organism = organism;
	this->name = name;
	this->sequence = sequence;
	this->id = organism + name;
}

std::string Gene::getId()
{
	return this->id;
}

std::string Gene::getOrganism()
{
	return this->organism;
}

std::string Gene::getName()
{
	return this->name;
}

std::string Gene::getSequence()
{
	return this->sequence;
}

void Gene::toString(char str[])
{
	sprintf_s(str, 250, " %-20s | %-20s | %40s", this->organism.c_str(), this->name.c_str(), this->sequence.c_str());
}

Gene& Gene::operator=(const Gene& g)
{
	this->id = g.id;
	this->organism = g.organism;
	this->name = g.name;
	this->sequence = g.sequence;

	return *this;
}

bool Gene::operator==(Gene g)
{
	if (this->id != g.id || this->sequence != g.sequence)
		return false;
	return true;
}
