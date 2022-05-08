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
	assert(strcmp(str, shouldBe) == 0);
}

void dynamicArrayTest() {
	DynamicVector<Tutorial> dv{3};
	Tutorial t1{ "link1", "titlu1", "prezentator1", Duration(1, 23), 3 };
	Tutorial t2{ "link2", "titlu2", "prezentator2", Duration(2, 34), 5 };
	Tutorial t3{ "link3", "titlu3", "prezentator3", Duration(3, 45), 4 };
	Tutorial t4{ "link4", "titlu4", "prezentator4", Duration(4, 56), 2 };
	
	dv.addTElem(t1);
	assert(dv.getTElem(0) == t1);

	dv.addTElem(t2);
	dv.addTElem(t3);

	try {
		dv.addTElem(t2);
		assert(false);
	}catch (const char* msg) {
		assert(true);
	}

	dv.addTElem(t4);
	assert(dv.size() == 4);

	assert(dv.searchTElem(t3) == 2);

	dv.removeTElem(t2);
	assert(dv.size() == 3);
	assert(dv.searchTElem(t2) == -1);

	try {
		dv.removeTElem(t2);
		assert(false);
	}catch (const char* msg) {
		assert(true);
	}

	dv.removeTElem(t1);
	assert(dv.size() == 2);

	t4.setTitle("TITLU");
	dv.updateTElem(t4);
	assert(dv.getTElem(dv.searchTElem(t4)).getTitle() == "TITLU");
	try {
		dv.updateTElem(t1);
		assert(false);
	}catch (const char* msg) {
		assert(true);
	}
}

void tutorialDatabaseTest() {
	TutorialDatabase td;
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
	}catch (const char* msg) {
		assert(true);
	}
	assert(td.getNrOfTutorials() == 3);
	DynamicVector<Tutorial> dv{td.getNrOfTutorials()};
	td.getTutorials(&dv);
	assert(dv.searchTElem(t4) == 0);
	assert(dv.searchTElem(t2) == 1);
	assert(dv.searchTElem(t1) == 2);
	assert(dv.searchTElem(t3) == -1);

	td.removeTutorial(t4.getId());
	assert(td.getNrOfTutorials() == 2);

	t2.setTitle("aolo");
	td.updateTutorial(t2);

	t2.setLikes(t2.getLikes() + 1);
	td.likeTutorial(t2);
	td.getTutorials(&dv);
	assert(dv.getTElem(1).getLikes() == 6);
}

void watchListTest() {
	Tutorial t1{ "link1", "titlu1", "prezentator1", Duration(1, 23), 3 };
	Tutorial t2{ "link2", "titlu2", "prezentator2", Duration(2, 34), 5 };
	Tutorial t3{ "link3", "titlu3", "prezentator3", Duration(3, 45), 4 };
	Tutorial t4{ "link4", "titlu4", "prezentator4", Duration(4, 56), 2 };

	WatchList wl;
	t1.setWatched(true);
	wl.addTutorial(t1);

	wl.addTutorial(t2);
	wl.addTutorial(t4);
	wl.removeTutorial(t1.getLink());
	try {
		wl.removeTutorial(t2.getLink());
		assert(false);
	} catch (const char*) {
		assert(true);
	}
	try {
		wl.removeTutorial(t3.getLink());
		assert(false);
	} catch (const char*) {
		assert(true);
	}
	try {
		wl.addTutorial(t4);
		assert(false);
	} catch (const char*) {
		assert(true);
	}
	DynamicVector<Tutorial> dv;
	wl.getTutorials(&dv);
	assert(dv.getTElem(0) == t4);
	assert(dv.getTElem(1) == t2);
	assert(dv.size() == 2);
	t4.setWatched(true);
	wl.watchTutorial(t4);
	wl.getTutorials(&dv);
	assert(dv.getTElem(0).getWatched() == true);
	assert(t4 == wl.getTutorial(0));
}

void adminServiceTest() {
	Tutorial t1{ "link1", "titlu1", "prezentator1", Duration(1, 23), 3 };
	Tutorial t2{ "link2", "titlu2", "prezentator2", Duration(2, 34), 5 };
	Tutorial t3{ "link3", "titlu3", "prezentator3", Duration(3, 45), 4 };
	Tutorial t4{ "link4", "titlu4", "prezentator4", Duration(4, 56), 2 };

	TutorialDatabase td;
	AdminService as{ &td };
	
	// ======== Add

	as.addTutorial("link1", "titlu1", "prezentator1", Duration(1, 23), 3);
	as.addTutorial("link2", "titlu2", "prezentator2", Duration(2, 34), 5);
	as.addTutorial("link3", "titlu3", "prezentator3", Duration(3, 45), 4);
	DynamicVector<Tutorial> dv;
	as.getTutorials(&dv);

	assert(dv.getTElem(0) == t1);
	assert(dv.getTElem(1) == t2);
	assert(dv.getTElem(2) == t3);

	try {
		as.addTutorial("link2", "titlu2", "prezentator2", Duration(2, 34), 5);
		assert(false);
	}catch (const char* msg) {
		assert(true);
	}

	try {
		as.addTutorial("link2", "titlu2", "prezentator2", Duration(-1, 60), -5);
		assert(false);
	}
	catch (const char* msg) {
		assert(true);
	}

	// ========= Update

	as.updateTutorial("link1", "Titlu", "PreZ", Duration(1, 59), 113);

	as.getTutorials(&dv);

	assert(dv.getTElem(0).getTitle() == "Titlu");
	assert(dv.getTElem(0).getPresenter() == "PreZ");
	assert(dv.getTElem(0).getLikes() == 113);
	assert(dv.getTElem(0).getDuration() == Duration(1,59));

	try {
		as.updateTutorial("link1", "titlu", "prezentat", Duration(2, 100), 5);
		assert(false);
	}
	catch (const char* msg) {
		assert(true);
	}

	try {
		as.updateTutorial("link18", "titlu", "prezentat", Duration(2, 100), 5);
		assert(false);
	}
	catch (const char* msg) {
		assert(true);
	}

	// ========= Remove

	as.removeTutorial("link1");
	assert(as.getNrOfTutorials() == 2);

	as.removeTutorial("link2");
	assert(as.getNrOfTutorials() == 1);

	as.getTutorials(&dv);
	assert(dv.getTElem(0).getId() == "link3");

	try {
		as.removeTutorial("link1");
		assert(false);
	}
	catch (const char* msg) {
		assert(true);
	}
	as.add10Tutorials();
	assert(as.getNrOfTutorials() == 11);

	// ========= Like
	WatchList wl; 
	AdminService as2{ &td };
	wl.addTutorial(t1);
	as2.addTutorial("link1", "titlu1", "prezentator1", Duration(1, 23), 3);
	wl.getTutorials(&dv);
	as2.likeTutorial(&dv, 0);
	as2.getTutorials(&dv);
	assert(dv.getTElem(0).getLikes() == 4);
}

void userServiceTest() {
	Tutorial t1{ "link1", "titlu1", "prezentator1", Duration(1, 23), 3 };
	Tutorial t2{ "link2", "titlu2", "prezentator2", Duration(2, 34), 5 };
	Tutorial t3{ "link3", "titlu3", "prezentator3", Duration(3, 45), 4 };
	Tutorial t4{ "link4", "titlu4", "prezentator4", Duration(4, 56), 2 };

	WatchList wl;
	UserService us{&wl};

	us.addTutorial(t1);
	us.watchTutorial(0);
	us.addTutorial(t2);
	us.watchTutorial(1);
	us.removeTutorial(1);
	DynamicVector<Tutorial> dv;
	us.getTutorials(&dv);
	assert(dv.getTElem(0) == t1);
	assert(dv.getTElem(0).getWatched() == true);
	assert(dv.size() == 1);

	us.getTutorials(&dv);
	us.filterByPresenter(&dv, "");
	assert(dv.size() == 1);

	us.filterByPresenter(&dv, "nu exista");
	assert(dv.size() == 0);

	us.getTutorials(&dv);
	us.filterByPresenter(&dv, "prezentator1");
	assert(dv.size() == 1);
}

void testAll() {
	tutorialTest();
	dynamicArrayTest();
	tutorialDatabaseTest();
	watchListTest();
	adminServiceTest();
	userServiceTest();
}