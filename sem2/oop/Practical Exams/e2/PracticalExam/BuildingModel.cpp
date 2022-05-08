#include "BuildingModel.h"
#include <qbrush.h>

BuildingTableModel::BuildingTableModel(BuildingService& s, std::string theme, QObject* parent) : QAbstractTableModel(parent), serv{ s }{
	this->theme = theme;
}

int BuildingTableModel::rowCount(const QModelIndex& parent) const
{
	return this->serv.size() + 1;
}

int BuildingTableModel::columnCount(const QModelIndex& parent) const
{
	return 4;
}

QVariant BuildingTableModel::data(const QModelIndex& index, int role) const
{
	int row = index.row();
	int column = index.column();

	std::vector<Building> buildings = this->serv.getBuildings();

	if (row == buildings.size())
	{
		return QVariant();
	}

	Building B = buildings[row];

	if (role == Qt::DisplayRole || role == Qt::EditRole)
	{
		switch (column)
		{
		case 0:
			return QString::fromStdString(B.getId());
		case 1:
			return QString::fromStdString(B.getDescription());
		case 2:
			return QString::fromStdString(B.getTheme());
		case 3:
			return QString::fromStdString(B.getLocation());
		default:
			break;
		}
	}
	if (role == Qt::BackgroundRole)
	{
		if (B.getTheme() == this->theme)
		{
			return QBrush{ QColor{102, 153, 255} };
		}
	}
	return QVariant();
}

QVariant BuildingTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
	if (role == Qt::DisplayRole)
	{
		if (orientation == Qt::Horizontal)
		{
			switch (section)
			{
			case 0:
				return QString{ "Id" };
			case 1:
				return QString{ "Description" };
			case 2:
				return QString{ "Theme" };
			case 3:
				return QString{ "Location" };
			default:
				break;
			}
		}
	}
	return QVariant();
}

bool BuildingTableModel::setData(const QModelIndex& index, const QVariant& value, int role)
{
	if(!index.isValid() || role != Qt::EditRole)
		return false;

	// set the new data to the gene
	int Index = index.row();

	// get the genes
	std::vector<Building> buildings = this->serv.getBuildings();
	std::string v;
	// Allow adding in the table
	//if the index is >= number of genes => a new gene is added
	if (Index == buildings.size())
	{
		this->beginInsertRows(QModelIndex{}, Index, Index);

		switch (index.column())
		{
		case 0:
			v = value.toString().toStdString();
			if(this->serv.buildingExists(v) == false)
				this->serv.addBuilding(Building{ v, "tempDesc", this->theme, ""});
			break;
		case 1:
			break;
		case 2:
			break;
		case 3:
			break;
		}

		this->endInsertRows();
		return true;
	}

	Building& current = buildings[Index];
	switch (index.column())
	{
	case 0:
		v = value.toString().toStdString();
		if (current.getTheme() == this->theme)
			if (this->serv.buildingExists(v) == false)
				current.setId(value.toString().toStdString());
		break;
	case 1:
		if (current.getTheme() == this->theme)
			current.setDescription(value.toString().toStdString());
		break;
	case 2:
		break;
	case 3:
		v = value.toString().toStdString();
		if (current.getTheme() == this->theme)
			if (this->serv.sameLocation(v) == false)
				current.setLocation(v);
		break;
	}
	this->serv.updateBuilding(Index, current);

	// emit the dataChanged signal
	emit dataChanged(index, index);

	return true;
}

Qt::ItemFlags BuildingTableModel::flags(const QModelIndex& index) const
{
	return Qt::ItemIsSelectable | Qt::ItemIsEditable | Qt::ItemIsEnabled;
}

void BuildingTableModel::update(std::vector<Building> v){
	if (this->serv.size() > 0) {
		this->beginRemoveRows({}, 0, this->serv.size() - 1);
		this->endRemoveRows();
	}


	if (this->serv.size() > 0) {
		this->beginInsertRows({}, 0, this->serv.size() - 1);
		endInsertRows();
	}
}
