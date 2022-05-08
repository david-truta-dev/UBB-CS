#include "GUI.h"
#include <QtWidgets/QApplication>
#include "EthnologistRepo.h"
#include "BuildingRepo.h"
#include "EthnologistService.h"
#include "BuildingService.h"

int main(int argc, char *argv[])
{
    EthnologistRepo Erepo{"ethnologists.txt"};
    BuildingRepo Brepo{"buildings.txt"};
    EthnologistService Eserv{ Erepo };
    BuildingService Bserv{ Brepo };
    QApplication a(argc, argv);
    GUI w{ Bserv, Eserv };
    return a.exec();
}
