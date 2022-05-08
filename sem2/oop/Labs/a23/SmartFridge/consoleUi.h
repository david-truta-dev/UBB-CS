#pragma once
#include "productService.h"

typedef struct {
	ProductService* service;
}ConsoleUi;

ConsoleUi createConsoleUi(ProductService* s);
void run(ConsoleUi* ui);
