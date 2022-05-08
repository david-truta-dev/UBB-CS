#include "productService.h"
#include "validator.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>


void addRandomProducts(ProductService* s);

ProductService createProductService(ProductRepo* r, UndoRedo* ur) {
	ProductService service;
	service.repo = r;
	service.ur = ur;
	addRandomProducts(&service);
	return service;
}

Product createProductWithAtributes() {
	char sweets[4][10] = { "milka", "caramel", "mars" };
	char meats[4][10] = { "chicken", "pork", "turkey" };
	char fruits[5][10] = { "apple", "pineapple", "pear", "banana" };
	char dairy[4][10] = { "cheese", "milk", "parmesan" };
	char categorys[6][10] = { "sweets", "meats", "fruits", "dairy" };
	int years[3] = { 2020, 2021 }, days[14] = { 31, 27, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	char id[20], name[10], category[10];
	int month = rand() % 12, yearIndex = rand() % 2;
	strcpy(category, categorys[rand() % 4]);
	strcpy(name, "\0");
	if (strcmp(category, "sweets") == 0) strcpy(name, sweets[rand() % 3]);
	else if (strcmp(category, "meats") == 0) strcpy(name, meats[rand() % 3]);
	else if (strcmp(category, "fruits") == 0) strcpy(name, fruits[rand() % 4]);
	else if (strcmp(category, "dairy") == 0) strcpy(name, dairy[rand() % 3]);
	strcpy(id, name);
	strcat(id, category);
	float quantity = ((rand() % 80) + 1) / (float)((rand() % 10) + 1);
	Date date = createDate(years[yearIndex], month + 1, (rand() % days[month]) + 1);
	Product p = createProduct(id, name, category, quantity, date);
	return p;
}


void addRandomProducts(ProductService* s) {
	srand(time(NULL));
	while (s->repo->nrOfProducts < 10) {
		Product p = createProductWithAtributes();
		int date[3] = { p.date.year, p.date.month, p.date.day };
		addProduct(s, p.name, p.category, p.quantity, date);
	}
}

char* addProduct(ProductService* service, char name[], char category[], float quantity, int date[]) {
	char id[100], fault[30];
	strcpy(id, name);
	strcat(id, category);
	Date d = createDate(date[0], date[1], date[2]);
	Product pNew = createProduct(id, name, category, quantity, d);
	validateProduct(&pNew, fault);
	if (strcmp(fault, "none ") != 0)return fault;
	deleteRedoActs(service->ur);
	Product* p = findProduct(service->repo, id);
	if (p != NULL) {
		p->type = 'u';
		saveUndoAct(service->ur, *p);
		setQuantity(p, getQuantity(p) + getQuantity(&pNew));
	}
	else {
		saveProduct(service->repo, pNew);
		pNew.type = 'a';
		saveUndoAct(service->ur, pNew);
	}
	return fault;
}

char* removeProduct(ProductService* s, char id[]) {
	Product* p = findProduct(s->repo, id);
	if (p != NULL) {
		deleteRedoActs(s->ur);
		p->type = 'r';
		saveUndoAct(s->ur, *p);
		deleteProduct(s->repo, id);
		return "none ";
	}
	return "Product doesn't exist!\n";
}

char* upProduct(ProductService* s, char name[], char category[], float quantity, int date[]) {
	char id[100], fault[30];
	strcpy(id, name);
	strcat(id, category);
	Date d = createDate(date[0], date[1], date[2]);
	Product* p = findProduct(s->repo, id), pNew = createProduct(id, name, category, quantity, d);
	if (p == NULL) return "Product doesn't exist!\n";
	validateProduct(p, fault);
	if (strcmp(fault, "none ") != 0) {
		strcat(fault, "invalid!");
		return fault;
	}
	deleteRedoActs(s->ur);
	p->type = 'u';
	saveUndoAct(s->ur, *p);
	updateProduct(s->repo, pNew);
	return "none ";
}

int undo(ProductService* s) {
	return undoOp(s->ur, s->repo);
}

int redo(ProductService* s) {
	return redoOp(s->ur, s->repo);
}

void filterProductsByString(ProductService* s, char string[], Product* p, int* newSize, char w) {
	*newSize = 0;
	for (int i = 0; i < s->repo->nrOfProducts; i++) {
		if (w == 'n') {
			if (strstr(getName(&s->repo->products[i]), string) != NULL) {
				p[(*newSize)++] = s->repo->products[i];
			}
		}
		else if (w == 'c') {
			if (strstr(getCategory(&s->repo->products[i]), string) != NULL) {
				p[(*newSize)++] = s->repo->products[i];
			}
		}
	}
}

void interChange(Product* p1, Product* p2) {
	Product aux = *p1;
	*p1 = *p2;
	*p2 = aux;
}

void sortProductsByQuantity(ProductService* s, Product* products, int* size, char order) {
	for (int i = 0; i < *size - 1; i++) {
		for (int j = i + 1; j < *size; j++)
			if (getQuantity(&products[i]) > getQuantity(&products[j]) && order == 'a') {
				interChange(&products[i], &products[j]);
			}
			else if (getQuantity(&products[i]) < getQuantity(&products[j]) && order == 'd') {
				interChange(&products[i], &products[j]);
			}
	}
}

void sortProductsByNameSelect(ProductService* s, Product* products, int* size) {
	//Select Sort
	for (int i = 0; i < *size - 1; i++) {
		for (int j = i + 1; j < *size; j++)
			if (strcmp(getName(&products[i]), getName(&products[j])) < 0) {
				interChange(&products[i], &products[j]);
			}
	}
}

void sortProductsByNameBubble(ProductService* s, Product* products, int* size) {
	//Bubble Sort
	for (int i = 0; i < *size - 1; i++)
		for (int j = 0; j < *size - 1; j++)
			if (strcmp(getName(&products[j]), getName(&products[j + 1])) < 0) {
				interChange(&products[j], &products[j + 1]);
			}
}

void sortProductsByNameGnome(ProductService* s, Product* products, int* size) {
	//Gnome Sort
	int i = 0;
	while (i < *size) {
		if (i == 0) i++;
		if (strcmp(getName(&products[i]), getName(&products[i-1])) < 0)i++;
		else {
			interChange(&products[i], &products[i - 1]);
			i--;
		}
	}

}

void sortProductsByCategory(ProductService* s, Product* products, int* size) {
	for (int i = 0; i < *size - 1; i++) {
		for (int j = i + 1; j < *size; j++)
			if (strcmp(getCategory(&products[i]), getCategory(&products[j])) < 0) {
				interChange(&products[i], &products[j]);
			}
	}
}

int leapYear(int year) {
	if (year % 400 == 0 || year % 4 == 0) return 1;
	return 0;
}

int daysBeforeExpires(Date date) {
	// The given date is considered valid.
	// Returns -1 if date is before current date, nr of days between current day and given date otherwise 
	time_t t = time(NULL);
	int days[14] = { 0, 31, 27, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }, res = 0;
	struct tm tm = *localtime(&t);
	Date currentDate = createDate(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
	//printf(" %d / %d / %d    %d / %d / %d    ", currentDate.year, currentDate.month, currentDate.day, date.year, date.month, date.day);
	if (date.year < currentDate.year) return -1;
	else if (date.year == currentDate.year) {
		if (date.month < currentDate.month) return -1;
		else if (date.month == currentDate.month) {
			if (date.day < currentDate.day) return -1;
			else if (date.day == currentDate.day) return 0;
			else { // (date.day > currentDate.day)
				res += date.day - currentDate.day;
			}
		}
		else { // (date.month > currentDate.month)
			res += days[currentDate.month] - currentDate.day + date.day;
			for (int i = currentDate.month + 1; i < date.month; i++) res += days[i];
		}
	}
	else { // (date.year > currentDate.year)
		if (date.month < currentDate.month) {
			res += date.day - currentDate.day;
			for (int i = currentDate.month; i <= 12; i++) res += days[i];
			for (int i = 1; i < date.month; i++) res += days[i];
			for (int i = currentDate.year + 1; i < date.year; i++) if (leapYear(i)) res += 366;
			else res += 365;
		}
		else if (date.month == currentDate.month) {
			res += 365;
			res += date.day - currentDate.day;
			for (int i = currentDate.month + 1; i < date.month; i++) res += days[i];
			for (int i = currentDate.year + 1; i < date.year; i++) if (leapYear(i)) res += 366;
			else res += 365;
		}
		else { // (date.month > currentDate.month)
			res += 365;
			res += days[currentDate.month] - currentDate.day + date.day;
			for (int i = currentDate.month + 1; i < date.month; i++) res += days[i];
			for (int i = currentDate.year + 1; i < date.year; i++) if (leapYear(i)) res += 366;
			else res += 365;
		}
	}
	return res;
}

void ExpiringProduct(ProductService* s, Product* prod, int* size, int days) {
	int i = 0;
	while (i < *size) {
		int dbe = daysBeforeExpires(prod[i].date);
		if (dbe != -1 && dbe > days) {
			prod[i] = prod[*size - 1];
			*size = *size - 1; i--;
		}
		i++;
	}
};
