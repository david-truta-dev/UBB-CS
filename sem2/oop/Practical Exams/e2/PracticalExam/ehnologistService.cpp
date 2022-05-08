#include "EthnologistService.h"

std::vector<Ethnologist> EthnologistService::getEth() {
	return this->repo.getElems();
}