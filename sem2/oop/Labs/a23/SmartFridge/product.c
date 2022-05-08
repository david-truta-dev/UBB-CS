#include "product.h"
#include <string.h>
#include <stdio.h>


Product createProduct(char id[], char name[], char category[], float quantity, Date d) {
	Product p;
	strcpy(p.id, id);
	strcpy(p.name, name);
	strcpy(p.category, category);
	p.quantity = quantity;
	p.date = d;
	return p;
}

char* getId(Product* p) {
	return p->id;
}

char* getName(Product *p) {
	return p->name;
}

void setName(Product* p, char name[]) {
	strcpy(p->name, name);
}

char* getCategory(Product* p) {
	return p->category;
}

void setCategory(Product* p, char category[]) {
	strcpy(p->category, category);
}

float getQuantity(Product* p) {
	return p->quantity;
}

void setQuantity(Product* p, float quantity) {
	p->quantity = quantity;
}

void toString(Product p, char str[]) {
	sprintf(str, " Name: %s | Category: %s | Quantity: %.2f | Date %d/%d/%d ", p.name, p.category, p.quantity, p.date.year, p.date.month, p.date.day);
}
