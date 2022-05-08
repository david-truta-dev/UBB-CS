#include <stdlib.h>
#include "undoRedo.h"

UndoRedo* createUndoRedo() {
	UndoRedo* ur = (UndoRedo*)malloc(sizeof(UndoRedo));
	if (ur == NULL) return;
	ur->undoAct = createDynamicArray(5);
	ur->redoAct = createDynamicArray(5);
	return ur;
}

void destroyUndoRedo(UndoRedo* ur) {
	destroyDynamicArray(ur->undoAct);
	destroyDynamicArray(ur->redoAct);
	free(ur);
	ur = NULL;
}

void saveUndoAct(UndoRedo* ur, Product p) {
	addTElem(ur->undoAct, p);
}

void saveRedoAct(UndoRedo* ur, Product p) {
	addTElem(ur->redoAct, p);
}

void deleteUndoAct(UndoRedo* ur, Product p) {
	removeTElem(ur->undoAct, ur->undoAct->size-1);
}

void deleteRedoAct(UndoRedo* ur, Product p) {
	removeTElem(ur->redoAct, ur->redoAct->size - 1);
}

void deleteRedoActs(UndoRedo* ur) {
	while( ur->redoAct->size > 0)
		removeTElem(ur->redoAct, ur->redoAct->size - 1);
}

int undoOp(UndoRedo* ur, ProductRepo* r) {
	if (ur->undoAct->size == 0)
		return 1;
	if (ur->undoAct->elems[ur->undoAct->size - 1].type == 'a') {

		ur->undoAct->elems[ur->undoAct->size - 1].type = 'r';
		saveRedoAct(ur, ur->undoAct->elems[ur->undoAct->size - 1]);

		deleteProduct(r, ur->undoAct->elems[ur->undoAct->size - 1].id);

		deleteUndoAct(ur, ur->undoAct->elems[ur->undoAct->size - 1]);
	}
	else if (ur->undoAct->elems[ur->undoAct->size - 1].type == 'r') {
		saveProduct(r, ur->undoAct->elems[ur->undoAct->size - 1]);
		
		ur->undoAct->elems[ur->undoAct->size - 1].type = 'a';
		saveRedoAct(ur, ur->undoAct->elems[ur->undoAct->size - 1]);

		deleteUndoAct(ur, ur->undoAct->elems[ur->undoAct->size - 1]);
	}
	else if (ur->undoAct->elems[ur->undoAct->size - 1].type == 'u') {
		
		saveRedoAct(ur, ur->undoAct->elems[ur->undoAct->size - 1]);

		updateProduct(r, ur->undoAct->elems[ur->undoAct->size - 1]);
			
		deleteUndoAct(ur, ur->undoAct->elems[ur->undoAct->size - 1]);
	}
	return 0;
}

int redoOp(UndoRedo* ur, ProductRepo* r) {
	if (ur->redoAct->size == 0)
		return 1;
	if (ur->redoAct->elems[ur->redoAct->size - 1].type == 'a') {
		
		ur->redoAct->elems[ur->redoAct->size - 1].type = 'r';
		saveUndoAct(ur, ur->redoAct->elems[ur->redoAct->size - 1]);

		deleteProduct(r, ur->redoAct->elems[ur->redoAct->size - 1].id);

		deleteRedoAct(ur, ur->redoAct->elems[ur->redoAct->size - 1]);
	}
	else if (ur->redoAct->elems[ur->redoAct->size - 1].type == 'r') {
		saveProduct(r, ur->redoAct->elems[ur->redoAct->size - 1]);
		
		ur->redoAct->elems[ur->redoAct->size - 1].type = 'a';
		saveUndoAct(ur, ur->redoAct->elems[ur->redoAct->size - 1]);

		deleteRedoAct(ur, ur->redoAct->elems[ur->redoAct->size - 1]);
	}
	else if (ur->redoAct->elems[ur->redoAct->size - 1].type == 'u') {
		
		saveUndoAct(ur, ur->redoAct->elems[ur->redoAct->size - 1]);

		updateProduct(r, ur->redoAct->elems[ur->redoAct->size - 1]);

		deleteRedoAct(ur, ur->redoAct->elems[ur->redoAct->size - 1]);
	}
	return 0;
}