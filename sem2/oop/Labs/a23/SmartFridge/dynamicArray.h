#pragma once
#include "product.h"

typedef Product TElement;

typedef struct {
	TElement* elems;
	int capacity;
	int size;
}DynamicArray;


DynamicArray* createDynamicArray(int);
void destroyDynamicArray(DynamicArray* );

void addTElem(DynamicArray*, TElement);
void removeTElem(DynamicArray*, int);
int findTElem(DynamicArray* da, TElement e);
