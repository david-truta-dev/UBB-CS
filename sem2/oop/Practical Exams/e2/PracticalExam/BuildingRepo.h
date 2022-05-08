#pragma once
#include "GenericRepo.h"
#include "Building.h"
#include <fstream>

class BuildingRepo : public Repo<Building> {
private:
	std::string fileName;

public:

	BuildingRepo(std::string s);

	virtual ~BuildingRepo() { }

	void updateId(std::string id, Building b) {
		for (int i = 0; i < this->elems.size(); i++) {
			if (this->elems[i].getId() == id) {
				this->elems.erase(this->elems.begin() + i);
				this->elems.insert(this->elems.begin() + i, b);
			}
		}
	}

	void updateTable(int index, const Building& b) {
		if (index < 0 || index >= this->size())
			return;

		this->elems.erase(this->elems.begin() + index);
		this->elems.insert(this->elems.begin() + index, b);

	}

	void load();

	void save();

};