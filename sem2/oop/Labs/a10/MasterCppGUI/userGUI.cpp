#include "userGUI.h"
#include <string>
#include <iostream>
#include <Windows.h>
#include <shellapi.h>
#include <sstream>
#include <algorithm>

UserGUI::UserGUI(UserService* us, AdminService* as, QStackedWidget* parent) : QStackedWidget(parent) {
	this->us = us;
	this->as = as;
	this->index = 0;
	this->as->getTutorials(&dataBase);
	this->initGUI();
}

void UserGUI::initGUI(){

	this->menuLayout = new QGridLayout{};
	this->menuWidget = new QWidget{};
	this->menuWidget->setLayout(this->menuLayout);

	this->addWidget(this->menuWidget);
	this->setCurrentIndex(this->indexOf(this->menuWidget));
	
	this->tutorials = new QListWidget{};
	this->tutorials->setMinimumWidth(400);
	this->buttons = new QVBoxLayout{};
	this->menuLayout->addWidget(this->tutorials, 0, 0, Qt::AlignLeft);
	this->menuLayout->addLayout(this->buttons, 0, 1, Qt::AlignCenter);

	//User mode label:
	this->userLabel = new QLabel{ "User Mode" };
	QFont font = this->userLabel->font();
	font.setPointSize(25);
	font.setBold(true);
	this->userLabel->setFont(font);

	//Buttons:
	this->browseBtn = new QPushButton{ "Browse" };
	this->watchBtn = new QPushButton{ "Watch" };
	this->deleteBtn = new QPushButton{ "Delete" };
	this->exportBtn = new QPushButton{ "Export" };

	//Connect Buttons:
	QObject::connect(this->browseBtn, &QPushButton::clicked, this, &UserGUI::browseMode);
	QObject::connect(this->exportBtn, &QPushButton::clicked, this, &UserGUI::exportTutorials);
	QObject::connect(this->watchBtn, &QPushButton::clicked, this, &UserGUI::watchTutorial);
	QObject::connect(this->deleteBtn, &QPushButton::clicked, this, &UserGUI::deleteTutorial);

	this->buttons->addWidget(this->userLabel, Qt::AlignCenter);
	this->buttons->addWidget(this->browseBtn, Qt::AlignCenter);
	this->buttons->addWidget(this->watchBtn, Qt::AlignCenter);
	this->buttons->addWidget(this->deleteBtn, Qt::AlignCenter);
	this->buttons->addWidget(this->exportBtn, Qt::AlignCenter);

	this->resetList();
}

std::string convertPaMasaInDracu(std::string s) {
	//Izoleaza linkul tutorialului (s contine toate dataele tutorialului)
	std::string res;
	int index = s.size() - 1;
	while (s[index] == ' ') index--;
	while (s[index] != ' ') {
		res += s[index];
		index--;
	}
	for (int i = 0; i < res.size() / 2; i++) {
		char aux = res[i];
		res[i] = res[res.size() - i - 1];
		res[res.size() - i - 1] = aux;
	}
	return res;
}

void UserGUI::deleteTutorial() {
	QListWidgetItem* tutorial = NULL;
	tutorial = this->tutorials->currentItem();
	if (tutorial == NULL) return;
	bool removed = false;
	std::string link = convertPaMasaInDracu(tutorial->text().toStdString());
	std::vector<Tutorial> dv; this->us->getTutorials(&dv);
	for (int i = 0; i < dv.size(); i++)
		if (link == dv[i].getLink()) {
			try {
				this->us->removeTutorial(i);
				this->popUpDelete = new QWidget{};
				this->delLayout = new QVBoxLayout{};
				this->popUpDelete->setLayout(this->delLayout);
				
				this->youLikeYES = new QLabel{"Leave the tutorial a like ?"};
				this->yesBtn = new QPushButton{"YES"};
				this->noBtn = new QPushButton{"Hell naah"};

				this->tempLink = dv[i].getLink();
				QObject::connect(this->yesBtn, &QPushButton::clicked, this, &UserGUI::likeTutorial);
				QObject::connect(this->noBtn, &QPushButton::clicked, this, &UserGUI::dontLikeTutorial);

				this->delLayout->addWidget(this->youLikeYES);
				this->delLayout->addWidget(this->yesBtn);
				this->delLayout->addWidget(this->noBtn);

				this->popUpDelete->show();
				
			} catch ( std::exception ) {
				this->exception = new QLabel{ "NO! you didn't even watch it..." };
				this->menuLayout->addWidget(this->exception, 5, 0, Qt::AlignRight);
				QFont font = this->exception->font();
				font.setBold(true);
				font.setPointSize(11);
				this->exception->setFont(font);
				this->timer = new QTimer(this);
				QTimer::singleShot(2000, this, &UserGUI::disableExceptionLabel);
				QColor color = Qt::red;
				QPalette palette = this->exception->palette();
				palette.setColor(QPalette::WindowText, color);
				this->exception->setPalette(palette);
			}
			this->resetList();
			break;
		}
}

void UserGUI::likeTutorial() {
	this->as->likeTutorial(this->tempLink);
	this->as->getTutorials(&this->dataBase);
	delete this->popUpDelete;
}

void UserGUI::dontLikeTutorial() {
	delete this->popUpDelete;
}

void UserGUI::watchTutorial() {
	QListWidgetItem* tutorial = NULL;
	tutorial = this->tutorials->currentItem();
	if (this->tutorial == NULL) return;
	std::string link = convertPaMasaInDracu(tutorial->text().toStdString());
	std::vector<Tutorial> dv; this->us->getTutorials(&dv);
	for (int i = 0; i < dv.size(); i++)
		if (link == dv[i].getLink()){
			ShellExecuteA(NULL, NULL, "chrome.exe", link.c_str(), NULL, SW_SHOWMAXIMIZED);
			this->us->watchTutorial(i);
		}
}

void putEndline(char toStr[250]) {
	for (int i = 0; i < strlen(toStr); i++)
		if (toStr[i] == '|')
			toStr[i] = '\n';
}

void UserGUI::browseMode(){
	this->browseLayout = new QGridLayout{};
	this->browseWidget = new QWidget{};
	this->browseWidget->setLayout(this->browseLayout);

	this->addWidget(this->browseWidget);
	this->setCurrentIndex(this->indexOf(this->browseWidget));

	this->tutorials = new QListWidget{};
	this->tutorials->setMinimumWidth(250);
	this->browseButtons = new QGridLayout{};
	this->browseLayout->addWidget(this->tutorials, 0, 0, Qt::AlignLeft);
	this->browseLayout->addLayout(this->browseButtons, 0, 1, Qt::AlignLeft);

	this->curTutLabel = new QLabel{ "Current Tutorial" };
	QFont font = this->curTutLabel->font();
	font.setPointSize(35);
	font.setBold(true);
	this->curTutLabel->setFont(font);

	this->prevBtn = new QPushButton{ "Prev" };
	this->nextBtn = new QPushButton{ "Next" };
	this->addBtn = new QPushButton{ "Add to Watchlist" };
	this->filterBtn = new QPushButton{ "Filter WL" };
	this->backBtn = new QPushButton{ "Back" };

	//Connext Buttons:
	QObject::connect(this->backBtn, &QPushButton::clicked, this, &UserGUI::initGUI);
	QObject::connect(this->nextBtn, &QPushButton::clicked, this, &UserGUI::nextTutorial);
	QObject::connect(this->prevBtn, &QPushButton::clicked, this, &UserGUI::prevTutorial);
	QObject::connect(this->addBtn, &QPushButton::clicked, this, &UserGUI::addTutorial);
	QObject::connect(this->filterBtn, &QPushButton::clicked, this, &UserGUI::filterTutorials);

	char toStr[250]; std::string str;
	dataBase.at(this->index).toString(toStr); str += toStr;
	putEndline(toStr);

	this->tutorial = new QLabel{ toStr };
	this->browseButtons->addWidget(this->curTutLabel, 0, Qt::AlignLeft);
	this->browseButtons->addWidget(this->tutorial, 1, Qt::AlignLeft);

	this->browseButtons->addWidget(this->prevBtn, 2, 0, Qt::AlignCenter);
	this->browseButtons->addWidget(this->filterBtn, 3, 1, Qt::AlignCenter);
	this->browseButtons->addWidget(this->nextBtn, 2, 2, Qt::AlignCenter);
	this->browseButtons->addWidget(this->addBtn, 2, 1, Qt::AlignCenter);
	this->browseButtons->addWidget(this->backBtn, 4, 1, Qt::AlignCenter);

	this->resetList();
}

void UserGUI::applyFilter() {
	this->tutorials->clear();

	this->presenter = this->presenterTextBox->text().toStdString();

	std::vector<Tutorial> dv;
	this->us->getTutorials(&dv);
	std::string pre = this->presenter;

	this->us->filterByPresenter(&dv, pre);

	for (auto tut : dv) {
		char string[350]; tut.toString(string);
		QListWidgetItem* lineEdit = new QListWidgetItem{ string };
		this->tutorials->addItem(lineEdit);
	}
	this->tutorials->setMinimumWidth(this->tutorials->sizeHintForColumn(0));
	
	delete this->popUpFilter;
}

void UserGUI::filterTutorials() {
	QIcon* ic = new QIcon("Icon.ico");
	QFormLayout* form = new QFormLayout{};
	this->popUpFilter = new QWidget{};
	this->popUpFilter->setLayout(form);
	this->popUpFilter->setWindowIcon(*ic);

	QLabel* label = new QLabel{ "Press submit with an empty box for all tutorials." };

	this->presenterTextBox = new QLineEdit{};
	QLabel* presenterLabel = new QLabel{ "&Presenter:" };
	presenterLabel->setBuddy(this->presenterTextBox);

	this->FSBtn = new QPushButton{ "Apply" };
	this->FSBtn->setMaximumWidth(230);

	form->setAlignment(Qt::AlignCenter);
	form->addWidget(label);
	form->addRow(presenterLabel, this->presenterTextBox);
	form->addWidget(this->FSBtn);

	this->popUpFilter->resize(380, 50);
	this->popUpFilter->setWindowTitle("Filter");
	this->popUpFilter->show();

	QObject::connect(this->FSBtn, &QPushButton::clicked, this, &UserGUI::applyFilter);

}

void UserGUI::resetList() {
	this->tutorials->clear();
	
	std::vector<Tutorial> v;
	this->us->getTutorials(&v); 
	for (auto tut : v) {
		char string[350]; tut.toString(string);
		QListWidgetItem* lineEdit = new QListWidgetItem{ string };
		this->tutorials->addItem(lineEdit);
		
	}
	this->tutorials->setMinimumWidth(this->tutorials->sizeHintForColumn(0));
}

void UserGUI::exportTutorials() {

	if (this->us->getWlUpCast() == "csv")
		ShellExecuteA(NULL, NULL, "watchList.csv", NULL, NULL, SW_SHOWMAXIMIZED);
	else
		ShellExecuteA(NULL, NULL, "watchList.html", NULL, NULL, SW_SHOWMAXIMIZED);
}

void UserGUI::addTutorial() {
	try {
		this->us->addTutorial(this->dataBase.at(this->index));
	} catch (std::exception) {
		/*if(this->exception != NULL)
			delete this->exception;*/
		this->exception = new QLabel{"This tutorial is already in the watchlist!"};
		this->browseLayout->addWidget(this->exception, 5, 0, Qt::AlignRight);
		QFont font = this->exception->font();
		font.setBold(true);
		font.setPointSize(11);
		this->exception->setFont(font);
		this->timer = new QTimer(this);
		QTimer::singleShot(2000, this, &UserGUI::disableExceptionLabel);
		QColor color = Qt::red;
		QPalette palette = this->exception->palette();
		palette.setColor(QPalette::WindowText, color);
		this->exception->setPalette(palette);
	}
	this->resetList();
}

void UserGUI::disableExceptionLabel() {
	this->exception->setHidden(true);
}

void UserGUI::nextTutorial(){
	char toStr[250]; std::string str; this->index += 1;
	if (this->index == this->dataBase.size()) index = 0;
	dataBase.at(this->index).toString(toStr); str += toStr;
	putEndline(toStr);
	delete this->tutorial;
	this->tutorial = new QLabel{ toStr };
	this->browseButtons->addWidget(this->tutorial, 1, Qt::AlignLeft);
}

void UserGUI::prevTutorial(){
	char toStr[250]; std::string str; this->index -= 1;
	if (this->index == -1) index = this->dataBase.size() - 1;
	dataBase.at(this->index).toString(toStr); str += toStr;
	putEndline(toStr);
	delete this->tutorial;
	this->tutorial = new QLabel{ toStr };
	this->browseButtons->addWidget(this->tutorial, 1, Qt::AlignLeft);
}
