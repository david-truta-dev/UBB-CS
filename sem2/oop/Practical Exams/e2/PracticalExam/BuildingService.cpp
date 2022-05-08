#include "BuildingService.h"

std::vector<Building> BuildingService::getBuildings()
{
	return this->repo.getElems();
}
