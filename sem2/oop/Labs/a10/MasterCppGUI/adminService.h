#pragma once
#include "tutorialDatabase.h"
#include "validateTutorial.h"

class AdminService {

private:
	TutorialDatabase* td;
	TutorialValidator tv;

public:

	AdminService(TutorialDatabase*);

	/* Adds a Tutorial from database.
	* Input: atributes of a Tutorial obj.
	* Output: -
	* Throws exception if there is a tutorial with this link.
	*/
	void addTutorial(std::string link, std::string title, std::string presenter, Duration duration, int likes);

	/* Removes a Tutorial from database.
	* Input: link(string) of a Tutorial.
	* Output: -
	* Throws exception if there is no tutorial with this link.
	*/
	void removeTutorial(std::string link);

	/* Updates a Tutorial from database.
	* Input: atributes of a Tutorial obj.
	* Output: -
	* Throws exception if there is no tutorial with the given link.
	*/
	void updateTutorial(std::string link, std::string title, std::string presenter, Duration duration, int likes);


	/* Returns the number of tutorials.
	* Input: -
	* Output: returns the number of Tutorials.
	*/
	int getNrOfTutorials();

	/* Puts in a DynamicVector all the Tutorials from database.
	* Input: -
	* Output: Puts in a dyn. vect. the tut.
	*/
	void  getTutorials(std::vector<Tutorial>* dv);

	/* Adds 10 Tutorials to the database.
	* Input: -
	* Output: -
	*/
	void add10Tutorials();

	/* Increments the likes of Tutorial by 1.
	* Input: watchList(DynamicVector), position of tutorial in watchList(int)
	* Output: -
	*/
	void likeTutorial(std::string);

	void filterByPresenter(std::vector<Tutorial>* dv, std::string presenter);

};