#pragma once
#include "watchList.h"

class WatchListCSV : public WatchList {
	
private:
	std::string CSVfile = "watchList.csv";

public:

	WatchListCSV();
	virtual ~WatchListCSV() {};
	void save();
};
