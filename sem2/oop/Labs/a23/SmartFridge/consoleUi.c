#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "consoleUi.h"

ConsoleUi createConsoleUi(ProductService* s) {
	ConsoleUi ui;
	ui.service = s;
	return ui;
}

void beCool();

void printMenu() {
	printf(" Here are the options for your SmartFridge! :\n" \
		"     'a' - add a product to the fridge.\n" \
		"     'r' - remove a product from the fridge.\n" \
		"     'u' - update an existing product.\n"\
		"     'dq' - display products that contain a given string, sorted asce. by quantity(empty str = display all).\n"\
		"     'dn' - display products that contain a given string(in name), sorted desc. by name(empty str = display all).\n"\
		"     'dc' - display products that contain a given string(in cat.), who is about to expire(empty str = display all).\n"\
		"     'un' - undo the last step that modified the data.\n"\
		"     're' - redo the last step that modified th data.\n"\
		"   'x' - quit.\n>> ");
}

void readAtributes(char name[], char category[], float* quantity, int date[]) {
	char dateC[3][10], quantityC[10]; strcpy(quantityC, "");
	printf(" Product details:\n");
	printf("Name:"); while (scanf("%s", name) < 1); strlwr(name);
	printf("Category:"); while (scanf("%s", category) < 1); strlwr(category);
	printf("Qunatity:"); while (scanf("%s", quantityC) < 0);
	printf(" Expiration Date:\n");
	printf("Year:");  while (scanf("%4s", &dateC[0]) < 0);
	printf("Month:");  while (scanf("%2s", &dateC[1]) < 0);
	printf("Day:");  while (scanf("%2s", &dateC[2]) < 0);
	*quantity = (float)atof(quantityC); if (*quantity == 0) *quantity = -1;
	date[0] = (float)atoi(dateC[0]);
	date[1] = (float)atoi(dateC[1]);
	date[2] = (float)atoi(dateC[2]);
}

void uiAddProduct(ConsoleUi* ui) {
	char name[50], category[50], fault[30], type = 'a';
	float quantity;
	int date[3];
	readAtributes(name, category, &quantity, date);
	strcpy(fault, addProduct(ui->service, name, category, quantity, date));
	if (strcmp(fault, "none ") == 0) 
		printf("Product successfully added!\n");
	else printf("The %sis/are not valid!\n", fault);
}

void uiRemoveProduct(ConsoleUi* ui) {
	char id[100], fault[30], type = 'r';
	printf("Id:"); while (scanf("%s", id) < 0);
	strcpy(fault, removeProduct(ui->service, id));
	if (strcmp(fault, "none ") == 0)
		printf("Product successfully removed!\n");
	else printf("%s\n", fault);
}

void uiUpdateProduct(ConsoleUi* ui) {
	char name[50], fault[30], category[50], type = 'u';
	float quantity;
	int date[3];
	readAtributes(name, category, &quantity, date);
	strcpy(fault, upProduct(ui->service, name, category, quantity, date));
	if (strcmp(fault, "none ") == 0) 
		printf("Product successfully updated!\n");
	else printf("%s\n", fault);
}

void uiListAll(Product* prod, int size) {
	char str[120];
	printf("\n");
	for (int i = 0; i < size; i++) {
		toString(prod[i], str);
		printf("%d. ", i + 1);
		puts(str);
	}
}

void readAndFilter(ConsoleUi* ui, char filter[], Product* prod, int* newSize, char w) {
	printf("Give string:");
	strcpy(filter, "");
	int trash = getchar();
	fgets(filter, 25, stdin);
	filter[strcspn(filter, "\n")] = 0;
	filterProductsByString(ui->service, filter, prod, newSize, w);
}

void uiDisplayByQuantity(ConsoleUi* ui) {
	char filter[25], choise[20]; int newSize = 0;
	Product* prod = (Product*)malloc(sizeof(Product) * ui->service->repo->nrOfProducts);
	// For requirement b, add a different type of filtering(of your choice).
	// For bonus:
	printf("'n' - by name\n'c'- by category\nThe type of filter:");
	while (scanf("%s", choise) < 1); strlwr(choise);
	if (strlen(choise) > 1) { printf("\nEnter only a letter !\n"); return; }

	readAndFilter(ui, filter, prod, &newSize, choise[0]);
	if (newSize == 0) printf("No product names were matched.\n");
	else {
		sortProductsByQuantity(ui->service, prod, &newSize, 'a');
		uiListAll(prod, newSize);

		free(prod);
		prod = NULL;
	}
}

void uiDisplayByName(ConsoleUi* ui) {
	char filter[25]; int newSize = 0;
	Product* prod = (Product*)malloc(sizeof(Product) * ui->service->repo->nrOfProducts);
	readAndFilter(ui, filter, prod, &newSize, 'n');
	if (newSize == 0) printf("No product names were matched.\n");
	else {
		sortProductsByNameSelect(ui->service, prod, &newSize);
		uiListAll(prod, newSize);

		free(prod);
		prod = NULL;
	}
}

void uiDisplayExpiring(ConsoleUi* ui) {
	int size, days; char filter[25], daysC[25], choise[25];
	Product* prod = (Product*)malloc(sizeof(Product) * ui->service->repo->nrOfProducts);
	readAndFilter(ui, filter, prod, &size, 'c');
	if (size == 0) printf("No product names were matched.\n");
	else {
		strcpy(daysC, "");
		printf("\nGive number of days before expiring:");
		while (scanf("%4s", daysC) < 0);
		days = atoi(daysC);

		ExpiringProduct(ui->service, prod, &size, days);

		//For requirement c, add descending sorting. The user should choose the type of sort and 
		//the program will show the list of entities accordingly.
		// For Bonus:
		printf("\n'b' - bubble sort\n's'- selsect sort\n'g'- gnome sort\nSorting descendingly sorted by name using:");
		while (scanf("%s", choise) < 1); strlwr(choise);
		if (strlen(choise) > 1) { printf("\nEnter only a letter !\n"); return; }

		if (choise[0] == 's') sortProductsByNameSelect(ui->service, prod, &size);
		else if (choise[0] == 'b') sortProductsByNameBubble(ui->service, prod, &size);
		else if (choise[0] == 'g') sortProductsByNameGnome(ui->service, prod, &size);
		else { printf("\nEnter a valid sort type !\n"); return; }

		uiListAll(prod, size);

		free(prod);
		prod = NULL;
	}

}

void uiUndo(ConsoleUi* ui) {
	if (undo(ui->service) == 1)
		printf("\nNo more undoes!\n");
	else printf("\nUndo was successfull!\n");
}

void uiRedo(ConsoleUi* ui) {
	if (redo(ui->service) == 1)
		printf("\nNo more redoes!\n");
	else printf("\nRedo was successfull!\n");
}

void run(ConsoleUi* ui) {
	char input[50];
	strcpy(input, "not x");
	beCool();
	while (strcmp("x", input) != 0) {
		printf("\n");
		printMenu();
		while (scanf("%s", input) < 1);
		strlwr(input);
		if (strcmp(input, "a") == 0)	uiAddProduct(ui);
		else if (strcmp(input, "r") == 0)	uiRemoveProduct(ui);
		else if (strcmp(input, "u") == 0)	uiUpdateProduct(ui);
		else if (strcmp(input, "dq") == 0)	uiDisplayByQuantity(ui);
		else if (strcmp(input, "dn") == 0)	uiDisplayByName(ui);
		else if (strcmp(input, "dc") == 0)	uiDisplayExpiring(ui);
		else if (strcmp(input, "un") == 0)	uiUndo(ui);
		else if (strcmp(input, "re") == 0)	uiRedo(ui);
		else if (strcmp(input, "x") != 0) printf("Enter a relevand command!\n");
	}
	printf("\nFridge go BRRRRRRrrrr... \n");
}

void beCool() {
 printf("                                                     +----------------+                                        \n"\
		"                                                     |                |                                        \n"\
		"                                                     |                |                                        \n"\
		"                                                     |                |                                        \n"\
		"         the Cool Fridge,                            |                |                                        \n"\
		"                    be cool                          |                |                                        \n"\
		"                                                     |             ++ |                                        \n"\
		"                                                     |             || |                                        \n"\
		"                                                     |             || |                                        \n"\
		"                                                     |             ++ |                                        \n"\
		"                                                     |                |                                        \n"\
		"                                                     +----------------+                                        \n"\
		"                                                     |             ++ |                                        \n"\
		"                                                     |             ++ |                                        \n"\
		"                                                     |                |                                        \n"\
		"                                                     |                |                                        \n"\
		"                                                     |                |                                        \n"\
		"                                                     +----------------+                                          ");
}