#pragma once
#include <iostream>
#include <string>
#include <fstream>

class Building {
private:
	std::string id;
	std::string description;
	std::string theme;
	std::string location;

public:
	std::string getId() {
		return this->id;
	}
	void setId(std::string id) {
		this->id = id;
	}
	void setDescription(std::string val) {
		this->description = val;
	}
	void setTheme(std::string val) {
		this->theme = val;
	}
	void setLocation(std::string val) {
		this->location = val;
	}
	std::string getDescription() {
		return this->description;
	}
	std::string getTheme() {
		return this->theme;
	}
	std::string getLocation() {
		return this->location;
	}
	Building(std::string id, std::string description, std::string theme, std::string locatio);
	friend std::istream& operator>>(std::istream& is, Building& b);
	bool operator==(Building& b);
};

