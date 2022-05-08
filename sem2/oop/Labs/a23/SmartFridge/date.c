#include "date.h"

Date createDate(int year, int month, int day) {
	Date d;
	d.year = year;
	d.month = month;
	d.day = day;
	return d;
}
