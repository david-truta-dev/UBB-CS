#pragma once
#include "productRepo.h"

typedef struct {
	DynamicArray* undoAct;
	DynamicArray* redoAct;
}UndoRedo;

/*
	Creates an object of type UndoRedo and it returns it's pointer. 
	Input: -
	Output: Returns pointer to UndoRedo object.
*/
UndoRedo* createUndoRedo();

/*
	Destroys the UndoRedo object created(frees all memory used bu it, and sets pointers to NULL).
	Input: pointer of an UndoRedo type object
	Output: -
*/
void destroyUndoRedo(UndoRedo* ur);

/*
	Saves a product and the last operation with that product(by it's atribute) to Dyn. Arr. undoAct.
	Input: pointer of an UndoRedo type object, value of an object of type product.
	Output: -
*/
void saveUndoAct(UndoRedo* ur, Product p);

/*
	Removes all redo actions.
	Input: pointer of an UndoRedo type object.
	Output: -
*/
void deleteRedoActs(UndoRedo* ur);

/*
	Undoes an operation that modified objects from repo.
	Input: pointer of an UndoRedo type object, pointer of a ProductRepo type objec.
	Output: Returns 0 if it was successfull, it returns 1 otherwise.
*/
int undoOp(UndoRedo*, ProductRepo*);

/*
	Redoes an undo.
	Input: pointer of an UndoRedo type object, pointer of a ProductRepo type objec.
	Output: Returns 0 if it was successfull, it returns 1 otherwise.
*/
int redoOp(UndoRedo*, ProductRepo*);
