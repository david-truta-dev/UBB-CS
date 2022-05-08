#pragma once
#include "date.h"

typedef struct Product{
	char type;
	char id[50];
	char name[25];
	char category[25];
	float quantity;
	Date date;
}Action;
