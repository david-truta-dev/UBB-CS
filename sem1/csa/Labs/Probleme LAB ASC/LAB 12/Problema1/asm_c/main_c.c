#include <stdio.h>
#include <stdlib.h>

void perm_str(char *);

char * convert_num_to_hexa_string(int, int *);

int main()
{
    int i, number;
    char *hexa_representation;
    int representation_length = 0;
    printf("Enter a number: ");
    scanf("%d", &number);
    
    hexa_representation = convert_num_to_hexa_string(number, &representation_length);
    
    printf("The representation in base 16 and its permutations are: \n");
    for(i = 0; i < representation_length; i++)
    {
        printf("%s\n", hexa_representation);
        perm_str(hexa_representation);
    }
    
    return 0;
}