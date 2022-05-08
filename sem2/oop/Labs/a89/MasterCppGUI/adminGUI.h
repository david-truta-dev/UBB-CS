#pragma once
#include <QWidget>
#include <qscrollarea.h>
#include <qlayout.h>
#include <QListWidget>
#include <QPushButton>
#include <QFormLayout>
#include <QTimer>
#include <QLabel>
#include "adminService.h"

class AdminGUI : public QWidget{

public:
	AdminGUI(AdminService* , QWidget* parent = 0);

private:
	void initGUI();

	AdminService* as;

	std::string presenter;

	QGridLayout* mainLayout;
	QListWidget* tutorials;
	QVBoxLayout* buttons;

	QPushButton* addBtn;
	QPushButton* ASBtn;
	QPushButton* removeBtn;
	QPushButton* updateBtn;
	QPushButton* filterBtn;
	QPushButton* FSBtn;
	QPushButton* USBtn;

	QWidget* popUpFilter;
	QLineEdit* presenterTextBox;

	QLineEdit* linkTextBoxAdd;
	QLineEdit* titleTextBoxAdd;
	QLineEdit* presenterTextBoxAdd;
	QLineEdit* durationTextBoxAdd;
	QLineEdit* likesTextBoxAdd;
	QWidget* addPopUp;

	QTimer* timer;
	QLabel* exception;

	QWidget* popUpUpdate;
	QLineEdit* linkTextBoxUpdate;
	QLineEdit* titleTextBoxUpdate;
	QLineEdit* presenterTextBoxUpdate;
	QLineEdit* durationTextBoxUpdate;
	QLineEdit* likesTextBoxUpdate;

	void addForm();
	void removeForm();
	void updateForm();
	void filterForm();
	void resetList();
	void applyFilter();
	void submitAdd();
	Duration splitDuration(std::string);
	void disableExceptionLabel();
	void submitUpdate();
};