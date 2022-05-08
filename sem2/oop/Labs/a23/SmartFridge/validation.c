#include "validator.h"
#include <string.h>

char* validateDate(Date d) {
	int leap = 0, max_days[14] = {0, 31, 27, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	if (d.year % 400 == 0 || d.year % 4 == 0) leap = 1;
	if (d.month < 1 || d.month > 12) return "date ";
	if (d.month == 2 && leap == 1) {
		if (d.day < 1 || d.day >28)
			return "date ";
	}
	else if (d.day < 1 || d.day >max_days[d.month])return "date ";
	return "";
}

void validateProduct(Product* p, char fault[]) {
	strcpy(fault, "");
	if (strcmp(p->category, "dairy")!=0 && strcmp(p->category, "sweets") != 0 && strcmp(p->category, "meats") != 0 && strcmp(p->category, "fruits") != 0) strcat(fault, "category ");
	if (p->quantity < 0) strcat(fault, "quantity ");
	strcat(fault, validateDate(p->date));
	if (strcmp(fault, "") != 0) return;
	strcpy(fault, "none ");
}
