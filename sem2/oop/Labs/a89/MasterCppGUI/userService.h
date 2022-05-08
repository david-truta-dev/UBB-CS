#pragma once
#include "watchList.h"

class UserService {

private:
	WatchList* wl;


public:

	/* Adds tutorial to the watchlist.
	* Input: an instance of Tutorial
	* Output: -
	* Throws exception if tutorial already exists in the watchlist.
	*/
	void addTutorial(Tutorial);

	/* Removes tutorial from the watchlist.
	* Input: position of tutorial
	* Output: -
	* Throws exception if tutorial doesn't exists in the watchlist.
	*/
	void removeTutorial(int);

	/*
	* Puts in the given dynamic vector a copy of tutorials in watchlist.
	* Input: -
	* Output: Modifies dv
	*/
	void getTutorials(std::vector<Tutorial>* dv);

	/* Set the watch atribute of Tutorial to true by default, or false if given.
	* Input: position of tutorial(int), a boolean value (optional).
	* Output: -
	*/
	void watchTutorial(int pos, bool isIt=true);

	/*
	* Removes from dv the tutorials that don't have the given presenter. 
	* If presenter is empty, nothing is removed.
	* Input: dv(dynamic vector), presenter(string)
	* Output: Modifies dv
	*/
	void filterByPresenter(std::vector<Tutorial>* dv, std::string presenter);

	/* Constructor
	* Input: pointer to an instance WatchList.
	* Output: -
	*/
	UserService(WatchList* wl);

	std::string getWlUpCast();

};