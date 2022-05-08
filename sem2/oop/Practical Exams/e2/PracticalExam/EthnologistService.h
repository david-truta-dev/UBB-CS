#pragma once
#include "EthnologistRepo.h"


class EthnologistService {
private:
	EthnologistRepo& repo;
public:
	EthnologistService(EthnologistRepo& r) : repo{ r } { }

	std::vector<Ethnologist> getEth();

	virtual ~EthnologistService() {};
};