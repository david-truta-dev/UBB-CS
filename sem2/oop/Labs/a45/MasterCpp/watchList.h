#pragma once
#include "tutorial.h"
#include "dynamicVector.h"

class WatchList {

private:
	DynamicVector<Tutorial> data;


public:

	/*
	* Save a tutorial to the watchlist.
	* Input: an instance of Tutorial.
	* Output:-
	* Throws exception if Tutorial already exists.
	*/
	void addTutorial(Tutorial);

	/*
	* Rmove a tutorial from the watchlist.
	* Input: Link of a tutorial.
	* Output:-
	* Throws exception if Tutorial doesn't exists OR if tutorial is not watched.
	*/
	void removeTutorial(std::string);

	/*
	* Returns the tutorial from position pos.
	* Input: -
	* Output: position(int)
	* Throws eception if there is no tutorial on postionon pos.
	*/
	Tutorial getTutorial(int pos);

	/*
	* Puts in the given dynamic vector a copy of tutorials in watchlist.
	* Input: -
	* Output: Modifies dv
	*/
	void getTutorials(DynamicVector<Tutorial>*);

	/*
	* Sets a tutoriual to watched.
	* Input: An instance of Tutorial(Tutorial)
	* Output: Modifies tht tutorial in watchlist 
	* Throws exception if Tutorial doesn't exists.
	*/
	void watchTutorial(Tutorial t);

};