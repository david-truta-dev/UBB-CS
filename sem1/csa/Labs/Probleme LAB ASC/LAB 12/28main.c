#include <stdio.h>

char input[105];
char lower[105], upper[105];

void put_lower(char*, char*);
void put_upper(char*, char*);

int main() {
    printf("input sentence: ");
    fgets(input, 101, stdin);
    
	put_lower(input, lower);
	put_upper(input, upper);
	
    printf("lower: %s\n", lower);
    printf("upper: %s\n", upper);
    
	return 0;
}