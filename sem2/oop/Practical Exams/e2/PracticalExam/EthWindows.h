#pragma once
#include "EthnologistService.h"
#include "BuildingModel.h"
#include <qpalette.h>
#include <QVBoxLayout>
#include <QSortFilterProxyModel>
#include <QTableView>
#include "Observer.h"

class EthnologistWindow : public QWidget, Observer{
private:
	std::string the;
	BuildingService& service;
	QVBoxLayout* Layout;
	BuildingTableModel* tableModel;
	QSortFilterProxyModel* proxyModel;
	QTableView* buildingTableView;

public:
	EthnologistWindow(BuildingService& s, std::string theme) : service{ s } {
		this->the = theme;
		QPalette pal = palette();
		//pal.setColor(QPalette::ColorRole , );
		this->setAutoFillBackground(true);
		this->setPalette(QPalette(QColor(rand()%255, rand() % 255, rand() % 255)));

		this->service.addObserver(this);

		this->Layout = new QVBoxLayout{};
		//create model:
		this->tableModel = new BuildingTableModel{ this->service, this->the };
		//create view:
		this->buildingTableView = new QTableView{};

		//set Layout:
		this->setLayout(this->Layout);
		//set model:
		this->buildingTableView->setModel(this->tableModel);

		//resize col. to content:
		this->buildingTableView->resizeColumnsToContents();
		this->setMinimumSize(440, 150);

		//add Widgets to Layout:
		this->Layout->addWidget(this->buildingTableView);

		this->proxyModel = new QSortFilterProxyModel{};
		this->proxyModel->setSourceModel(this->tableModel);
		this->proxyModel->sort(2);
		this->buildingTableView->setModel(proxyModel);

	}

	void update() override {
		this->tableModel->update(this->service.getBuildings());
		this->proxyModel->sort(0);
	}

};