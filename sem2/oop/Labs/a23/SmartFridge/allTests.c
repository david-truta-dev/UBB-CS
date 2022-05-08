#include "validator.h"
#include "productService.h"
#include <string.h>
#include <assert.h>

Product aProduct() {
	char id[40], name[20], category[20];
	float quantity = 1.321;
	Date date = createDate(2020, 12, 31);
	strcpy(id, "porkmeats");
	strcpy(name, "pork");
	strcpy(category, "meats");
	Product p = createProduct(id, name, category, quantity, date);
	return p;
}

void productTest() {
	Product p = aProduct();
	assert(strcmp(getId(&p), "porkmeats") == 0);
	assert(strcmp(p.name, "pork") == 0);
	setName(&p, "chicken");
	assert(strcmp(getName(&p), "chicken") == 0);
	assert(strcmp(getCategory(&p), "meats") == 0);
	setCategory(&p, "Meats");
	assert(strcmp(getCategory(&p), "Meats") == 0);
	assert(getQuantity(&p) < 1.33 && getQuantity(&p) > 1.31);
	setQuantity(&p, 2.2);
	assert(getQuantity(&p) < 2.3 && getQuantity(&p) > 2.1);
	char acutal[100], expected[100];
	strcpy(expected, " Name: porkmeats | Category: Meats | Quantity: 2.2 | Date 2020/12/31 ");
}

void validationTest() {
	Product p = aProduct(); char fault[30];
	p.quantity = -1;
	p.date.year = 2019; p.date.month = 2; p.date.day = 28;
	strcpy(p.id, "candysweets");
	strcpy(p.name, "candy");
	strcpy(p.category, "sweets");


	validateProduct(&p, fault);
	assert(strcmp(fault, "quantity date ") == 0);

	p.date.year = 2020; p.quantity = 1.111;
	strcpy(p.category, "not a category");

	validateProduct(&p, fault);
	assert(strcmp(fault, "category ") == 0);

	strcpy(p.category, "fruits");

	validateProduct(&p, fault);
	assert(strcmp(fault, "none ") == 0);
}

void repoTest() {
	ProductRepo repo = createProductRepo();

	Product p = aProduct();
	saveProduct(&repo, p);
	assert(findProduct(&repo, p.id) != NULL);

	deleteProduct(&repo, p.id);
	assert(findProduct(&repo, p.id) == NULL);

	saveProduct(&repo, p);
	p.quantity = 3.33;
	updateProduct(&repo, p);
	assert(repo.products[0].quantity < 3.34 && repo.products[0].quantity > 3.32);

	destroyProductRepo(&repo);
	assert(&repo != NULL);
}

void serviceTest() {
	ProductRepo repo = createProductRepo();
	UndoRedo* ur = createUndoRedo();
	ProductService service = createProductService(&repo, ur);
	
	char fault[50]; int date[3] = { 1999, 2, 30 };
	strcpy(fault, addProduct(&service, "numelume", "nemcategorie", -1.1, date));
	assert(strcmp(fault, "category quantity date ") == 0);

	date[2] = 27;
	strcpy(fault, addProduct(&service, "pui", "meats", 1.123, date));
	assert(strcmp(fault, "none ") == 0);
	assert(repo.nrOfProducts == 11);
	
	undo(&service);
	undo(&service);
	assert(repo.nrOfProducts == 9);

	redo(&service);
	assert(repo.nrOfProducts == 10);
	
	redo(&service);
	strcpy(fault, removeProduct(&service, "puimeats"));
	assert(strcmp(fault, "none ") == 0);

	strcpy(fault, removeProduct(&service, "numelume"));
	assert(strcmp(fault, "Product doesn't exist!\n") == 0);

	strcpy(fault, upProduct(&service, "numelume", "nemcategorie", -1.1, date));
	assert(strcmp(fault, "Product doesn't exist!\n") == 0);

	addProduct(&service, "pui", "meats", 1.123, date);
	strcpy(fault, upProduct(&service, "pui", "meats", 1.123, date));
	assert(strcmp(fault, "none ") == 0);

	destroyProductRepo(&repo);
	destroyUndoRedo(ur);
}

void runAllTests() {
	productTest();
	validationTest();
	repoTest();
	serviceTest();
}
