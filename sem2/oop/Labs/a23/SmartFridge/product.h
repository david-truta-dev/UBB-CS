#pragma once
#include "date.h"

typedef struct {
	char type;
	char id[50];
	char name[25];
	char category[25];
	float quantity;
	Date date;
}Product;

Product createProduct(char id[], char name[], char category[], float quantity, Date d);
char* getId(Product* p);
char* getName(Product* p);
void setName(Product* p, char name[]);
char* getCategory(Product* p);
void setCategory(Product* p, char category[]);
float getQuantity(Product* p);
void setQuantity(Product* p, float quantity);
void toString(Product p, char str[]);
