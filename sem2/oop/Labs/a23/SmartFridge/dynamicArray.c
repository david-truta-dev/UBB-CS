#include "dynamicArray.h"
#include <stdlib.h>

DynamicArray* createDynamicArray(int cap) {
	DynamicArray* da = (DynamicArray*)malloc(sizeof(DynamicArray));

	if (da == NULL) return NULL;

	da->capacity = cap;
	da->size = 0;

	da->elems = (TElement*)malloc(sizeof(TElement) * da->capacity);

	if (da->elems == NULL) return NULL;

	return da;
}

void destroyDynamicArray(DynamicArray* da) {
	if (da == NULL)return;

	free(da->elems);
	da->elems = NULL;

	free(da);
	da = NULL;
}

void reSize(DynamicArray* da, float newCap) {
	da->capacity = da->capacity * newCap;

	TElement* new = (TElement*)malloc(sizeof(TElement) * da->capacity);
	if (new == NULL) return;
	for (int i = 0; i < da->size; i++) {
		if (&new[i] == NULL) return;
		new[i] = da->elems[i];
	}

	free(da->elems);
	da->elems = new;

}

void addTElem(DynamicArray* da, TElement e) {
	if (da == NULL) return;
	if (da->elems == NULL) return;

	if (da->size == da->capacity)reSize(da, 1.5);
	da->elems[da->size] = e;
	da->size += 1;
}

void removeTElem(DynamicArray* da, int poz) {
	if (da == NULL) return;
	if (da->elems == NULL) return;

	for (int i = poz; i < da->size - 1; i++) {
		da->elems[i] = da->elems[i + 1];
	}
	da->size -= 1;

	if (da->size > 1 && da->size <= da->capacity * 0.5)reSize(da, 0.5);
}

int findTElem(DynamicArray* da, TElement e) {
	if (da == NULL) return;
	if (da->elems == NULL) return;
	int poz = -1;

	for (int i = 0; i < da->size; i++) {
		if (&da->elems[i] == NULL) return;
		if (strcmp(da->elems[i].id, e.id) == 0) return i;
	}
	return poz;
}
