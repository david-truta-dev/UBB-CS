#pragma once
#include "productRepo.h"
#include "undoRedo.h"

typedef struct {
	ProductRepo* repo;
	UndoRedo* ur;
}ProductService;

/*
	Creates and returns an onj of type ProductService.
	Input: Pointer to ProductRepo obj., Pointer to UndoRedo obj.
	Output: Returns value of a ProductService obj.
*/
ProductService createProductService(ProductRepo* r, UndoRedo* ur);

/*
	Creats and adds the product with given attributes and returns "none ", if not found or invalid returns problem.
	Input: Pointer to ProductService obj., attributes of a product.
	Output: Adds the product with the given id and returns "none " if successful, otherwise returns the problem.
*/
char* addProduct(ProductService* s, char name[], char category[], float quantity, int date[]);

/*
	Removes the product with given id and returns "none ", if not found or invalid returns problem.
	Input: Pointer to ProductService obj., 'id' arr. of charaters
	Output: Removes the product with the given id and returns "none " if successful, otherwise returns the problem.
*/
char* removeProduct(ProductService* s, char id[]);

/*
	Updates the product with given id(name+categ) and returns "none ", if not found or invalid returns problem.
	Input: Pointer to ProductService obj., 'id' arr. of charaters
	Output: Modifies the product with the given id and returns "none " if successful, otherwise returns the problem.
*/
char* upProduct(ProductService* s, char name[], char category[], float quantity, int date[]);

/*
	Recieves a empty arr. of Product objs. and adds the products that contain the given string in name or categ.
	 'size' is the nr of prod that are in the arr. 'w' should be 'n' for filtering name field, 'c' for filtering category field.
	Input: Pointer to ProductService obj., pointer to begining of arr., pointer to size of arr.
			'w' a character.
	Output: Modifies 'products'. and 'newSize'
*/
void filterProductsByString(ProductService* s, char [], Product*, int* newSize, char w);

/*
	Recieves a arr. of Product objs. and sorts(using select sort) them by quantity.
	 'size' is the nr of prod that are in the arr. 'order' should be 'd' for descending sort, 'a' for ascending sort.
	Input: Pointer to ProductService obj., pointer to begining of arr., pointer to size of arr.
			'order' a character.
	Output: Modifies 'products'.
*/
void sortProductsByQuantity(ProductService* s, Product* , int* size, char order);

/*
	Recieves a arr. of Product objs. and sorts(using select sort) them descenigly by name.
	 'size' is the nr of prod that are in the arr.
	Input: Pointer to ProductService obj., pointer to begining of arr., pointer to size of arr.
	Output: Modifies 'products'.
*/
void sortProductsByNameSelect(ProductService* s, Product*, int* size);

/*
	Recieves a arr. of Product objs. and sorts(using bubble sort) them descenigly by name.
	 'size' is the nr of prod that are in the arr.
	Input: Pointer to ProductService obj., pointer to begining of arr., pointer to size of arr.
	Output: Modifies 'products'.
*/
void sortProductsByNameBubble(ProductService* s, Product*, int* size);

/*
	Recieves a arr. of Product objs. and sorts(using gnome sort) them descenigly by name.
	 'size' is the nr of prod that are in the arr.
	Input: Pointer to ProductService obj., pointer to begining of arr., pointer to size of arr.
	Output: Modifies 'products'.
*/
void sortProductsByNameGnome(ProductService* s, Product*, int* size);

/*
	Recieves a arr. of Product objs. and sorts them descenigly by category.
	 'size' is the nr of prod that are in the arr.
	Input: Pointer to ProductService obj., pointer to begining of arr., pointer to size of arr.
	Output: Modifies 'products'.
*/
void sortProductsByCategory(ProductService* s, Product*, int* size);

/*
	Undoes lat operation that modif. the repo.
	 ! Dependent on UndoRedo
	Input: Pointer to ProductService obj.
	Output: Returns 0 if successfull, 1 otherwise.
*/
int undo(ProductService* s);

/*
	Redoes lat operation that modif. the repo.
	 ! Dependent on UndoRedo
	Input: Pointer to ProductService obj.
	Output: Returns 0 if successfull, 1 otherwise.
*/
int redo(ProductService* s);

/*
	Recieves a arr. in 'products' and removes every product that is not expired and does not
	expire in the next following 'days'. 'size' is the nr of prod that are initialy in the arr.
	Input: Pointer to ProductService obj., pointer to begining of arr., pointer to size of arr.
			, int - nr of days
	Output: Modifies 'products' and 'size'.
*/
void ExpiringProduct(ProductService* s, Product* products, int* size, int days);
