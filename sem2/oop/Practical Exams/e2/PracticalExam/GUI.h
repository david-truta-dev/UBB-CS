#pragma once

#include <QtWidgets/QWidget>
#include "ui_GUI.h"
#include "EthnologistService.h"
#include <vector>
#include "EthWindows.h"

class GUI : public QWidget
{
    Q_OBJECT

public:
    GUI(BuildingService& bs, EthnologistService& serv, QWidget *parent = 0);

private:
    Ui::GUIClass ui;
    EthnologistService& EthService;
    BuildingService& buildingService;
    std::vector<EthnologistWindow*> windows;



    void createWindows();
};
