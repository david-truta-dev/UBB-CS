#pragma once
#include <QtWidgets/QMainWindow>
#include "ui_MasterCppGUI.h"
#include <QHBoxLayout>
#include <QPushButton>
#include "adminGUI.h"
#include "userGUI.h"
#include <QStackedWidget>
#include <QLabel>
#include "adminService.h"
#include "userService.h"

class GUI : public QMainWindow
{
    Q_OBJECT

public:
    TutorialDatabase* td;
    WatchList* wl;

    AdminService* as;
    UserService* us;

    AdminGUI* admGUI;
    UserGUI* useGUI;

    QStackedWidget* mainWidget;

    QLabel* mode;
    QWidget* chooseModeWidget;
    QVBoxLayout* chooseModeLayout;
    QPushButton* userBtn;
    QPushButton* adminBtn;

    QLabel* output;
    QWidget* chooseOutputWidget;
    QVBoxLayout* chooseOutputLayout;
    QPushButton* csvBtn;
    QPushButton* htmlBtn;

    GUI(QWidget* parent = 0);
    ~GUI();

private:
    Ui::MasterCppGUIClass ui;
    void initGUI();
    void setUpChooseMode();
    void goToAdminGUI();
    void goToUserGUI();
    void setUpChooseOutput();
    void csvMode();
    void htmlMode();
};
