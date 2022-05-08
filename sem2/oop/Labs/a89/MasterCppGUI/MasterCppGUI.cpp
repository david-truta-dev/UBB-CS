#include "MasterCppGUI.h"
#include "tutorialDatabaseCSV.h"
#include "tutorialDatabaseHTML.h"
#include "watchListCSV.h"
#include "watchListHTML.h"

GUI::GUI(QWidget *parent) : QMainWindow(parent){
    ui.setupUi(this);
    this->initGUI();
}

void GUI::initGUI() {
    QIcon* ic = new QIcon("Icon.ico");
    this->setWindowIcon(*ic);
    this->resize(200, 35);
    this->setWindowTitle("Mega Cpp  Master");

    this->mainWidget = new QStackedWidget{};
    this->setCentralWidget(this->mainWidget);

    this->setUpChooseMode();
}

void GUI::setUpChooseMode(){
    this->chooseModeWidget = new QWidget{};
    this->chooseModeLayout = new QVBoxLayout{};

    this->mode = new QLabel{ "Choose Mode:" };
    this->userBtn = new QPushButton{ "USER" };
    this->adminBtn = new QPushButton{ "ADMIN" };

    //Connect the buttons:
    QObject::connect(this->adminBtn, &QPushButton::clicked, this, &GUI::goToAdminGUI);
    QObject::connect(this->userBtn, &QPushButton::clicked, this, &GUI::setUpChooseOutput);

    this->chooseModeLayout->addWidget(this->mode, 0, Qt::AlignHCenter);
    this->chooseModeLayout->addWidget(this->userBtn);
    this->chooseModeLayout->addWidget(this->adminBtn);

    this->chooseModeWidget->setLayout(this->chooseModeLayout);
    this->mainWidget->addWidget(this->chooseModeWidget);
}


void GUI::goToAdminGUI() {
    this->td = new TutorialDatabase;
    this->wl = new WatchList;
    this->as = new AdminService{ this->td };
    this->us = new UserService{ this->wl };
    this->admGUI = new AdminGUI{ this->as };
    this->resize(this->sizeHint());
    this->mainWidget->addWidget(this->admGUI);
    this->mainWidget->setCurrentIndex(this->mainWidget->indexOf(this->admGUI));
}



void GUI::setUpChooseOutput() {
    this->chooseOutputWidget = new QWidget{};
    this->chooseOutputLayout = new QVBoxLayout{};

    this->output = new QLabel{ "Choose Output:" };
    this->csvBtn = new QPushButton{ "CSV" };
    this->htmlBtn = new QPushButton{ "HTML" };

    //Connect the buttons:
    QObject::connect(this->csvBtn, &QPushButton::clicked, this, &GUI::csvMode);
    QObject::connect(this->htmlBtn, &QPushButton::clicked, this, &GUI::htmlMode);

    this->chooseOutputLayout->addWidget(this->output, 0, Qt::AlignHCenter);
    this->chooseOutputLayout->addWidget(this->csvBtn);
    this->chooseOutputLayout->addWidget(this->htmlBtn);

    this->chooseOutputWidget->setLayout(this->chooseOutputLayout);
    this->mainWidget->addWidget(this->chooseOutputWidget);
    this->mainWidget->setCurrentIndex(this->mainWidget->indexOf(this->chooseOutputWidget));
}

void GUI::csvMode() {
    this->td = new TutorialDatabaseCSV;
    this->wl = new WatchListCSV;
    this->goToUserGUI();
}

void GUI::htmlMode() {
    this->td = new TutorialDatabaseHTML;
    this->wl = new WatchListHTML;
    this->goToUserGUI();
}

void GUI::goToUserGUI() {
    this->as = new AdminService{ this->td };
    this->us = new UserService{ this->wl };
    this->useGUI = new UserGUI{ this->us, this->as };
    this->resize(1350, 320);
    this->mainWidget->addWidget(this->useGUI);
    this->mainWidget->setCurrentIndex(this->mainWidget->indexOf(this->useGUI));
}

GUI::~GUI() {
    delete this->td;
    delete this->wl;
    delete this->as;
    delete this->us;
}
