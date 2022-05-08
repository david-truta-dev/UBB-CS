#pragma once
#include <QWidget>
#include <QVBoxLayout>
#include <QPushButton>
#include <QStackedWidget>
#include "userService.h"
#include <QListWidget>
#include <QLabel>
#include <qtimer.h>
#include <QFormLayout>
#include <QLineEdit>
#include "adminService.h"

class UserGUI : public QStackedWidget{

public:
	UserGUI(UserService*, AdminService*, QStackedWidget* parent = 0);

private:
	void initGUI();
	void browseMode();
	void resetList();
	void nextTutorial();
	void prevTutorial();
	void addTutorial();
	void exportTutorials();
	void disableExceptionLabel();
	void filterTutorials();
	void applyFilter();
	void watchTutorial();
	void deleteTutorial();
	void likeTutorial();
	void dontLikeTutorial();

	int index;
	std::vector<Tutorial> dataBase;
	
	UserService* us;
	AdminService* as;

	std::string presenter;
	std::string tempLink;
	QLineEdit* presenterTextBox;

	QLabel* userLabel;
	QWidget* menuWidget;
	QGridLayout* menuLayout;
	QListWidget* tutorials;
	QVBoxLayout* buttons;
	QPushButton* browseBtn;
	QPushButton* watchBtn;
	QPushButton* addBtn;
	QPushButton* deleteBtn;
	QPushButton* exportBtn;
	QPushButton* prevBtn;
	QPushButton* nextBtn;
	QPushButton* filterBtn;
	QPushButton* backBtn;
	QPushButton* FSBtn;

	QLabel* exception;
	QTimer* timer;
	QWidget* popUpFilter;

	QLabel* youLikeYES;
	QPushButton* yesBtn;
	QPushButton* noBtn;
	QVBoxLayout* delLayout;
	QWidget* popUpDelete;

	QLabel* tutorial;
	QLabel* curTutLabel;
	QWidget* browseWidget;
	QGridLayout* browseLayout;
	QGridLayout* browseButtons;

};