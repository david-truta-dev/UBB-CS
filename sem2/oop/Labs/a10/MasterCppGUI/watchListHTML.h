#pragma once
#include "watchList.h"

class WatchListHTML : public WatchList {

private:
	std::string HTMLfile = "watchList.html";

public:

	WatchListHTML();
	virtual ~WatchListHTML() {};
	void save();
};
