#include <stdio.h>
void convert(char[], char[], char[]);
int main()
{
    char s1[100],s2[100],alphabet[]="OPQRSTUVWXYZABCDEFGHIJKLMN";
    printf("Enter string:");
    scanf("%s",s1);
    convert(s1,s2,alphabet);
    printf("The converted string is:%s",s2);
    return 0;
}
