#include <cassert>
#include <iostream>
#include "adminService.h"
#include "watchList.h"
#include "userService.h"

void tutorialTest() {
	Tutorial t{ "linkkk", "titlu", "prezentator", Duration(1, 23), 3 };
	Tutorial t2{ "link2", "titlu2", "prezentator2", Duration(2, 34), 5 };
	assert(t.getLink() == "linkkk");
	assert(t.getTitle() == "titlu");
	assert(t.getPresenter() == "prezentator");
	assert(t.getDuration() == Duration(1, 23));
	t.setLikes(4);
	assert(t.getLikes() == 4);

	t.setTitle("aualeou");
	assert(t.getTitle() == "aualeou");
	assert(!(t == t2));
	char str[250], shouldBe[250];

	t.toString(str);
	strcpy_s(shouldBe, 250, " Title: aualeou | Presentor: prezentator | Duration: 1:23 | Likes: 4 | Link: linkkk");
	//assert(strcmp(str, shouldBe) == 0);
}

void tutorialDatabaseTest() {
	TutorialDatabase td{"testing.txt"};
	Tutorial t1{ "link1", "titlu1", "prezentator1", Duration(1, 23), 3 };
	Tutorial t2{ "link2", "titlu2", "prezentator2", Duration(2, 34), 5 };
	Tutorial t3{ "link3", "titlu3", "prezentator3", Duration(3, 45), 4 };
	Tutorial t4{ "link4", "titlu4", "prezentator4", Duration(4, 56), 2 };

	td.addTutorial(t4);
	td.addTutorial(t2);
	td.addTutorial(t1);
	try {
		td.addTutorial(t4);
		assert(false);
	}catch (TutorialDatabaseException e) {
		assert(true);
	}
	assert(td.getNrOfTutorials() == 3);
	std::vector<Tutorial> dv;
	td.getTutorials(&dv);
	assert(dv[0] == t4);
	assert(dv[1] == t2);
	assert(dv[2] == t1);

	td.removeTutorial(t4.getId());
	assert(td.getNrOfTutorials() == 2);

	t2.setTitle("aolo");
	td.updateTutorial(t2);

	t2.setLikes(t2.getLikes() + 1);
	//td.likeTutorial(t2);
	td.getTutorials(&dv);
	//assert(dv[0].getLikes() == 6);

	remove("testing.txt");
}

void watchListTest() {
	Tutorial t1{ "link1", "titlu1", "prezentator1", Duration(1, 23), 3 };
	Tutorial t2{ "link2", "titlu2", "prezentator2", Duration(2, 34), 5 };
	Tutorial t3{ "link3", "titlu3", "prezentator3", Duration(3, 45), 4 };
	Tutorial t4{ "link4", "titlu4", "prezentator4", Duration(4, 56), 2 };

	WatchList wl{ "testing.txt" };
	t1.setWatched(true);
	wl.addTutorial(t1);

	wl.addTutorial(t2);
	wl.addTutorial(t4);
	wl.removeTutorial(t1.getLink());
	try {
		wl.removeTutorial(t2.getLink());
		assert(false);
	} catch (WatchListException e) {
		assert(true);
	}
	try {
		wl.removeTutorial(t3.getLink());
		assert(false);
	} catch (WatchListException e) {
		assert(true);
	}
	try {
		wl.addTutorial(t4);
		assert(false);
	} catch (WatchListException e) {
		assert(true);
	}
	std::vector<Tutorial> dv;
	wl.getTutorials(&dv);
	assert(dv[1] == t4);
	assert(dv[0] == t2);
	assert(dv.size() == 2);
	t4.setWatched(true);
	wl.watchTutorial(t4);
	wl.getTutorials(&dv);
	assert(dv[1].getWatched() == true);
	assert(t4 == wl.getTutorial(1));

	remove("testing.txt");
}

void adminServiceTest() {
	Tutorial t1{ "link1", "titlu1", "prezentator1", Duration(1, 23), 3 };
	Tutorial t2{ "link2", "titlu2", "prezentator2", Duration(2, 34), 5 };
	Tutorial t3{ "link3", "titlu3", "prezentator3", Duration(3, 45), 4 };
	Tutorial t4{ "link4", "titlu4", "prezentator4", Duration(4, 56), 2 };

	TutorialDatabase td{ "testing.txt" };
	AdminService as{ &td };
	
	// ======== Add

	as.addTutorial("link1", "titlu1", "prezentator1", Duration(1, 23), 3);
	as.addTutorial("link2", "titlu2", "prezentator2", Duration(2, 34), 5);
	as.addTutorial("link3", "titlu3", "prezentator3", Duration(3, 45), 4);
	std::vector<Tutorial> dv;
	as.getTutorials(&dv);

	assert(dv[0] == t1);
	assert(dv[1] == t2);
	assert(dv[2] == t3);

	try {
		as.addTutorial("link2", "titlu2", "prezentator2", Duration(2, 34), 5);
		assert(false);
	}catch (TutorialDatabaseException e) {
		assert(true);
	}

	try {
		as.addTutorial("link2", "titlu2", "prezentator2", Duration(-1, 60), -5);
		assert(false);
	}
	catch (TutorialValidatorException e) {
		assert(true);
	}

	// ========= Update

	as.updateTutorial("link1", "Titlu", "PreZ", Duration(1, 59), 113);

	as.getTutorials(&dv);

	assert(dv[0].getTitle() == "Titlu");
	assert(dv[0].getPresenter() == "PreZ");
	assert(dv[0].getLikes() == 113);
	assert(dv[0].getDuration() == Duration(1,59));

	try {
		as.updateTutorial("link1", "titlu", "prezentat", Duration(2, 100), 5);
		assert(false);
	}
	catch (TutorialValidatorException e) {
		assert(true);
	}

	try {
		as.updateTutorial("link18", "titlu", "prezentat", Duration(2, 100), 5);
		assert(false);
	}
	catch (TutorialValidatorException e) {
		assert(true);
	}

	// ========= Remove

	as.removeTutorial("link1");
	assert(as.getNrOfTutorials() == 2);

	as.removeTutorial("link2");
	assert(as.getNrOfTutorials() == 1);

	as.getTutorials(&dv);
	assert(dv[0].getId() == "link3");

	try {
		as.removeTutorial("link1");
		assert(false);
	}
	catch (TutorialDatabaseException e) {
		assert(true);
	}
	as.add10Tutorials();
	assert(as.getNrOfTutorials() == 11);

	remove("testing.txt");

	// ========= Like
	WatchList wl{"testing.txt"};
	AdminService as2{ &td };
	wl.addTutorial(t1);
	as2.addTutorial("link1", "titlu1", "prezentator1", Duration(1, 23), 3);
	wl.getTutorials(&dv);
	//as2.likeTutorial(&dv, 0);
	as2.getTutorials(&dv);
	//assert(dv[0].getLikes() == 4);

	remove("testing.txt");
}

void userServiceTest() {
	Tutorial t1{ "link1", "titlu1", "prezentator1", Duration(1, 23), 3 };
	Tutorial t2{ "link2", "titlu2", "prezentator2", Duration(2, 34), 5 };
	Tutorial t3{ "link3", "titlu3", "prezentator3", Duration(3, 45), 4 };
	Tutorial t4{ "link4", "titlu4", "prezentator4", Duration(4, 56), 2 };

	WatchList wl{"testing.txt"};
	UserService us{&wl};

	us.addTutorial(t1);
	us.watchTutorial(0);
	us.addTutorial(t2);
	us.watchTutorial(1);
	us.removeTutorial(1);
	std::vector<Tutorial> dv;
	us.getTutorials(&dv);
	assert(dv[0] == t1);
	assert(dv[0].getWatched() == true);
	assert(dv.size() == 1);

	us.getTutorials(&dv);
	us.filterByPresenter(&dv, "");
	assert(dv.size() == 1);

	us.filterByPresenter(&dv, "nu exista");
	assert(dv.size() == 0);

	us.getTutorials(&dv);
	us.filterByPresenter(&dv, "prezentator1");
	assert(dv.size() == 1);

	remove("testing.txt");
}

void testAll() {
	tutorialTest();
	tutorialDatabaseTest();
	watchListTest();
	adminServiceTest();
	userServiceTest();
}