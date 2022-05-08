#pragma once
#include "dynamicArray.h"

typedef struct {
	DynamicArray* da;
	Product* products;
	int nrOfProducts;
}ProductRepo;

ProductRepo createProductRepo();
void destroyProductRepo(ProductRepo* r);

void saveProduct(ProductRepo* r, Product p);
void deleteProduct(ProductRepo* r, char id[]);
void updateProduct(ProductRepo* r, Product p);
Product* findProduct(ProductRepo* r, char id[]);
