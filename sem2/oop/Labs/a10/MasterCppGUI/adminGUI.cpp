#include "adminGUI.h"
#include <sstream>
#include <QLabel>
#include <QLineEdit>
#include <QTextEdit>

AdminGUI::AdminGUI(AdminService* as, QWidget* parent) : QWidget(parent){
	this->as = as;
	this->initGUI();
}

void reformatBtn(QPushButton* btn) {
	btn->setMinimumHeight(90);
	btn->setMaximumHeight(90);
	btn->setMinimumWidth(90);
	btn->setMaximumWidth(90);
	btn->setIconSize(QSize(90, 90));
}

void AdminGUI::initGUI(){
	this->mainLayout = new QGridLayout{};
	this->tutorials = new QListWidget{};
	this->tutorials->setMinimumWidth(550);
	this->buttons = new QVBoxLayout{};
	this->setLayout(this->mainLayout);
	this->mainLayout->addWidget(this->tutorials, 0,0,Qt::AlignLeft);
	this->mainLayout->addLayout(this->buttons, 0, 1, Qt::AlignLeft);
	this->buttons->setContentsMargins(20,20,20,20);

	this->addBtn = new QPushButton{};
	reformatBtn(this->addBtn);
	QIcon add("addBtn.png");
	this->addBtn->setIcon(add);
	this->removeBtn = new QPushButton{};
	QIcon remove("removeBtn.png");
	this->removeBtn->setIcon(remove);
	reformatBtn(this->removeBtn);
	this->updateBtn = new QPushButton{};
	QIcon update("updateBtn.png");
	this->updateBtn->setIcon(update);
	reformatBtn(this->updateBtn);
	this->filterBtn = new QPushButton{};
	QIcon filter("filterBtn.png");
	this->filterBtn->setIcon(filter);
	reformatBtn(this->filterBtn);

	//Connect buttons:
	QObject::connect(this->addBtn, &QPushButton::clicked, this, &AdminGUI::addForm);
	QObject::connect(this->removeBtn, &QPushButton::clicked, this, &AdminGUI::removeForm);
	QObject::connect(this->updateBtn, &QPushButton::clicked, this, &AdminGUI::updateForm);
	QObject::connect(this->filterBtn, &QPushButton::clicked, this, &AdminGUI::filterForm);

	this->buttons->addWidget(this->addBtn);
	this->buttons->addWidget(this->removeBtn);
	this->buttons->addWidget(this->updateBtn);
	this->buttons->addWidget(this->filterBtn);

	//Adding the tutorials to table:
	this->resetList();
}

void AdminGUI::resetList() {
	this->tutorials->clear();

	std::vector<Tutorial> v;
	this->as->getTutorials(&v);
	for (auto tut : v) {
		char string[350]; tut.toString(string);
		QListWidgetItem* lineEdit = new QListWidgetItem{ string };
		this->tutorials->addItem(lineEdit);

	}
	this->tutorials->setMinimumWidth(this->tutorials->sizeHintForColumn(0));
}

bool isDigits(const std::string& str) {
	return str.find_first_not_of("0123456789") == std::string::npos;
}

Duration AdminGUI::splitDuration(std::string d) {
	std::string minutes, seconds; int m, s;
	int i = 0;
	while (i < d.size() && d[i] != ':') {
		minutes += d[i];
		i++;
	}
	if (d.size() == i) { seconds = minutes; minutes = "0"; }
	else {
		i++;
		while (i < d.size()) { seconds += d[i]; i++; }
	}
	if (isDigits(minutes) == false || isDigits(seconds) == false)
		throw TutorialValidatorException("Duration is not ok :(");
	std::stringstream M(minutes), S(seconds);
	M >> m; S >> s;
	return Duration(m, s);
}

void AdminGUI::submitAdd() {
	std::string link, title, presenter, d, l;
	Duration duration;
	int likes = 0;

	link = this->linkTextBoxAdd->text().toStdString();
	title = this->titleTextBoxAdd->text().toStdString();
	presenter = this->presenterTextBoxAdd->text().toStdString();
	l = this->likesTextBoxAdd->text().toStdString();
	std::stringstream L(l); L >> likes;
	try {
		d = this->durationTextBoxAdd->text().toStdString(); duration = this->splitDuration(d);
		try {
			this->as->addTutorial(link, title, presenter, duration, likes);
		} catch (TutorialDatabaseException tde) {
			this->exception = new QLabel{ tde.what().c_str() };
			this->mainLayout->addWidget(this->exception, 5, 0, Qt::AlignLeft);
			QFont font = this->exception->font();
			font.setBold(true);
			font.setPointSize(11);
			this->exception->setFont(font);
			this->timer = new QTimer(this);
			QTimer::singleShot(2000, this, &AdminGUI::disableExceptionLabel);
			QColor color = Qt::red;
			QPalette palette = this->exception->palette();
			palette.setColor(QPalette::WindowText, color);
			this->exception->setPalette(palette);
		}
		
		this->resetList();
		delete this->addPopUp;
	} catch (TutorialValidatorException tve) {
		this->exception = new QLabel{ tve.what().c_str() };
		this->mainLayout->addWidget(this->exception, 5, 0, Qt::AlignLeft);
		QFont font = this->exception->font();
		font.setBold(true);
		font.setPointSize(11);
		this->exception->setFont(font);
		this->timer = new QTimer(this);
		QTimer::singleShot(2000, this, &AdminGUI::disableExceptionLabel);
		QColor color = Qt::red;
		QPalette palette = this->exception->palette();
		palette.setColor(QPalette::WindowText, color);
		this->exception->setPalette(palette);
	}
}

void AdminGUI::disableExceptionLabel(){
	this->exception->setHidden(true);
}

void AdminGUI::addForm() {
	QFormLayout* form = new QFormLayout{};
	this->addPopUp = new QWidget{};
	this->addPopUp->setLayout(form);
	QIcon* ic = new QIcon("Icon.ico");
	this->addPopUp->setWindowIcon(*ic);

	this->linkTextBoxAdd = new QLineEdit{};
	QLabel* linkLabel = new QLabel{ "&Link:" };
	linkLabel->setBuddy(this->linkTextBoxAdd);

	this->titleTextBoxAdd = new QLineEdit{};
	QLabel* titleLabel = new QLabel{ "&Title:" };
	titleLabel->setBuddy(this->titleTextBoxAdd);

	this->presenterTextBoxAdd = new QLineEdit{};
	QLabel* presenterLabel = new QLabel{ "&Presenter:" };
	presenterLabel->setBuddy(this->presenterTextBoxAdd);

	this->durationTextBoxAdd = new QLineEdit{};
	QLabel* durationLabel = new QLabel{ "&Duration:" };
	durationLabel->setBuddy(this->durationTextBoxAdd);

	this->likesTextBoxAdd = new QLineEdit{};
	QLabel* likesLabel = new QLabel{ "&Likes:" };
	likesLabel->setBuddy(this->likesTextBoxAdd);

	this->ASBtn = new QPushButton{ "Add" };
	this->ASBtn->setMaximumWidth(230);

	form->addRow(linkLabel, this->linkTextBoxAdd);
	form->addRow(titleLabel, this->titleTextBoxAdd);
	form->addRow(presenterLabel, this->presenterTextBoxAdd);
	form->addRow(durationLabel, this->durationTextBoxAdd);
	form->addRow(likesLabel, this->likesTextBoxAdd);
	form->addWidget(this->ASBtn);
	
	QObject::connect(this->ASBtn, &QPushButton::clicked, this, &AdminGUI::submitAdd);

	this->addPopUp->resize(380, 50);
	this->addPopUp->setWindowTitle("Add");
	this->addPopUp->show();
}

std::string convertPaMasaInDracu2(std::string s) {
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

void AdminGUI::removeForm() {
	QListWidgetItem* tutorial = NULL;
	tutorial = this->tutorials->currentItem();
	if (tutorial == NULL) return;
	bool removed = false;
	std::string link = convertPaMasaInDracu2(tutorial->text().toStdString());
	std::vector<Tutorial> dv; this->as->getTutorials(&dv);

	this->as->removeTutorial(link);
	this->resetList();
}

void AdminGUI::submitUpdate() {
	std::string link, title, presenter, d, l;
	Duration duration;
	int likes = 0;

	link = this->linkTextBoxUpdate->text().toStdString();
	title = this->titleTextBoxUpdate->text().toStdString();
	presenter = this->presenterTextBoxUpdate->text().toStdString();
	l = this->likesTextBoxUpdate->text().toStdString();
	std::stringstream L(l); L >> likes;
	try {
		d = this->durationTextBoxUpdate->text().toStdString(); duration = this->splitDuration(d);
		try {
			this->as->updateTutorial(link, title, presenter, duration, likes);
		}
		catch (TutorialDatabaseException tde) {
			this->exception = new QLabel{ tde.what().c_str() };
			this->mainLayout->addWidget(this->exception, 5, 0, Qt::AlignLeft);
			QFont font = this->exception->font();
			font.setBold(true);
			font.setPointSize(11);
			this->exception->setFont(font);
			this->timer = new QTimer(this);
			QTimer::singleShot(2000, this, &AdminGUI::disableExceptionLabel);
			QColor color = Qt::red;
			QPalette palette = this->exception->palette();
			palette.setColor(QPalette::WindowText, color);
			this->exception->setPalette(palette);
		}

		this->resetList();
		delete this->popUpUpdate;
	}
	catch (TutorialValidatorException tve) {
		this->exception = new QLabel{ tve.what().c_str() };
		this->mainLayout->addWidget(this->exception, 5, 0, Qt::AlignLeft);
		QFont font = this->exception->font();
		font.setBold(true);
		font.setPointSize(11);
		this->exception->setFont(font);
		this->timer = new QTimer(this);
		QTimer::singleShot(2000, this, &AdminGUI::disableExceptionLabel);
		QColor color = Qt::red;
		QPalette palette = this->exception->palette();
		palette.setColor(QPalette::WindowText, color);
		this->exception->setPalette(palette);
	}
}

void AdminGUI::updateForm() {
	QFormLayout* form2 = new QFormLayout{};
	this->popUpUpdate = new QWidget{};
	this->popUpUpdate->setLayout(form2);

	this->linkTextBoxUpdate = new QLineEdit{};
	QLabel* linkLabel = new QLabel{ "&Link:" };
	linkLabel->setBuddy(this->linkTextBoxUpdate);

	this->titleTextBoxUpdate = new QLineEdit{};
	QLabel* titleLabel = new QLabel{ "&Title:" };
	titleLabel->setBuddy(this->titleTextBoxUpdate);

	this->presenterTextBoxUpdate = new QLineEdit{};
	QLabel* presenterLabel = new QLabel{ "&Presenter:" };
	presenterLabel->setBuddy(this->presenterTextBoxUpdate);

	this->durationTextBoxUpdate = new QLineEdit{};
	QLabel* durationLabel = new QLabel{ "&Duration:" };
	durationLabel->setBuddy(this->durationTextBoxUpdate);

	this->likesTextBoxUpdate = new QLineEdit{};
	QLabel* likesLabel = new QLabel{ "&Likes:" };
	likesLabel->setBuddy(this->likesTextBoxUpdate);

	this->USBtn = new QPushButton{"Apply"};
	this->USBtn->setMaximumWidth(230);

	form2->addRow(linkLabel, this->linkTextBoxUpdate);
	form2->addRow(titleLabel, this->titleTextBoxUpdate);
	form2->addRow(presenterLabel, this->presenterTextBoxUpdate);
	form2->addRow(durationLabel, this->durationTextBoxUpdate);
	form2->addRow(likesLabel, this->likesTextBoxUpdate);
	form2->addRow(this->USBtn);

	QObject::connect(this->USBtn, &QPushButton::clicked, this, &AdminGUI::submitUpdate);

	popUpUpdate->resize(380, 50);
	popUpUpdate->setWindowTitle("Update");
	popUpUpdate->show();
}

void AdminGUI::applyFilter() {
	this->tutorials->clear();

	this->presenter = this->presenterTextBox->text().toStdString();

	std::vector<Tutorial> dv;
	this->as->getTutorials(&dv);
	std::string pre = this->presenter;

	this->as->filterByPresenter(&dv, pre);

	for (auto tut : dv) {
		char string[350]; tut.toString(string);
		QListWidgetItem* lineEdit = new QListWidgetItem{ string };
		this->tutorials->addItem(lineEdit);
	}
	this->tutorials->setMinimumWidth(this->tutorials->sizeHintForColumn(0));

	delete this->popUpFilter;
}

void AdminGUI::filterForm() {
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

	QObject::connect(this->FSBtn, &QPushButton::clicked, this, &AdminGUI::applyFilter);

}
