#include <stdio.h>
#include <stdlib.h>
#include <math.h>

    ///  17. Read a string of unsigned numbers in base 10 from keyboard. 
    /// Determine the minimum value of the string and write it in the 
    /// file min.txt (it will be created) in 16 base.

int function(min, input);

int main()
{
    int len, input, min = INFINITY;
    FILE *descriptor; // datastructure from stdlib.h
    
    printf("Enter how many numbers do you want to give: ");
    scanf("%d", &len);
    
    for (int i = 0; i < len; i++)
    {
        printf("Enter a positive number in base 10: ");
        scanf("%d", &input);
        min = function(min, input);
    }
    
    printf("%x", min);
    descriptor = fopen("min.txt", "w");
    fprintf(descriptor, "%x", min);
    fclose(descriptor);
    
	return 0;
	
}