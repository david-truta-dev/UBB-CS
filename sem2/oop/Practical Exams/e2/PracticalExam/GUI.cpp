#include "GUI.h"

GUI::GUI(BuildingService& bs, EthnologistService& serv, QWidget* parent) : QWidget(parent), EthService{ serv }, buildingService{ bs }{
    ui.setupUi(this);

    createWindows();
}

void GUI::createWindows() {
	for (auto w : this->EthService.getEth()) {
		EthnologistWindow* q = new EthnologistWindow{ this->buildingService,  w.getTheme() };
		q->setWindowTitle(QString::fromStdString(w.getName()));
		this->windows.push_back(q);

		q->show();
	}
}

