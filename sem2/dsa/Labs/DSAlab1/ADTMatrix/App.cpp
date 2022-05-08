
#include <iostream>
#include "Matrix.h"
#include "ExtendedTest.h"
#include "ShortTest.h"

using namespace std;


int main() {
	//ADT  Matrix – represented  as  a  sparse  matrix,
	// compressed  sparse  column  representationusing dynamic arrays.

	testAll();
	testAllExtended();
	cout << "Test End" << endl;
	system("pause");
}