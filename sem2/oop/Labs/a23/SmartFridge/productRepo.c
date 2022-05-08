#include "productRepo.h"
#include <stdlib.h>
#include <string.h>

ProductRepo createProductRepo() {
	ProductRepo repo;
	repo.da = createDynamicArray(10);
	repo.nrOfProducts = repo.da->size;
	repo.products = repo.da->elems;
	return repo;
}

void destroyProductRepo(ProductRepo* r) {
	destroyDynamicArray(r->da);
	r->products = NULL;
}

void saveProduct(ProductRepo* r, Product p) {
	addTElem(r->da, p);
	r->products = r->da->elems;
	r->nrOfProducts = r->da->size;
}

void deleteProduct(ProductRepo* r, char id[]) {
	int poz = r->nrOfProducts + 1;
	for (int i = 0; i < r->nrOfProducts; i++) {
		if (strcmp(getId(&r->products[i]), id) == 0) {
			poz = i;
			break;
		}
	}
	if (poz == r->nrOfProducts + 1) return;
	removeTElem(r->da, poz);
	r->products = r->da->elems;
	r->nrOfProducts = r->da->size;
}

void updateProduct(ProductRepo* r, Product p) {
	for (int i = 0; i < r->nrOfProducts; i++) {
		if (strcmp(getId(&r->products[i]), getId(&p)) == 0) {
			r->products[i] = p;
			break;
		}
	}
}

Product* findProduct(ProductRepo* r, char id[]) {
	for (int i = 0; i < r->nrOfProducts; i++) {
		if (strcmp(getId(&r->products[i]), id) == 0) {
			return &r->products[i];
		}
	}
	return NULL;
}
