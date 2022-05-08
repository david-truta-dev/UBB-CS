#pragma once
#include "product.h"

/*
	changes the value of char fault to "none " if the product given is valid. Otherwise it will return a string of the problems. Ex: "category date ".
	Input: pointer of a product, a vector of chars.
	Output: Modifies the value of fault.
*/
void validateProduct(Product* p, char fault[]);

