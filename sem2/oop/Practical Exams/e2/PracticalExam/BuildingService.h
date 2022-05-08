#pragma once
#include "BuildingRepo.h"
#include "Observer.h"

class BuildingService : public Observable {
private:
	BuildingRepo& repo;

public:
	BuildingService(BuildingRepo& r) : repo{ r } { }

	std::vector<Building> getBuildings();

	int size() {
		return this->repo.size();
	}

	void addBuilding(Building b) {
		this->repo.add(b);
		this->repo.save();
		this->notify();
	};

	/*void removeIssueId(std::string id) {
		this->repo.removeId(id);
		this->notify();
	};*/

	void updateBuldingId(std::string id, Building b) {
		this->repo.updateId(id, b);
		this->repo.save();
		this->notify();
	};

	void updateBuilding(int index, const Building& b) {
		this->repo.updateTable(index, b);
		this->repo.save();
		this->notify();
	}

	bool buildingExists(std::string id) {
		std::vector<Building> v = this->getBuildings();
		for (int i = 0; i < this->size(); i++)
			if (v[i].getId() == id)
				return true;
		return false;
	}

	bool sameLocation(std::string loc) {
		std::vector<Building> v = this->getBuildings();
		for (int i = 0; i < this->size(); i++)
			if (v[i].getLocation() == loc)
				return true;
		return false;
	}

	virtual ~BuildingService() {};
};