#include <stdio.h>
/*
7. Three strings (of characters) are given. Show the longest prefix for each of the three pairs of two strings that can be formed.
*/
int get_prefix(char [],char [], char[]);
int main()
{
    char s1[101]="ana are mere.",s2[101]="anul nou va fi mai bun.",s3[101]="anunt important",result[101];
    int have_prefix;
    
    have_prefix = get_prefix(s1,s2,result);
    if(have_prefix)
        printf("The prefix for s1 and s2 is: %s.\n",result);
    else
        printf("The prefix for s1 and s2 is: There is no prefix.\n",result);
    
    have_prefix = get_prefix(s1,s3,result);
    if(have_prefix)
        printf("The prefix for s1 and s3 is: %s.\n",result);
    else
        printf("The prefix for s1 and s3 is: There is no prefix.\n",result);
    
    have_prefix = get_prefix(s2,s3,result);
    if(have_prefix)
        printf("The prefix for s2 and s3 is: %s.\n",result);
    else
        printf("The prefix for s2 and s3 is: There is no prefix.\n",result);
    
	return 0;
}



