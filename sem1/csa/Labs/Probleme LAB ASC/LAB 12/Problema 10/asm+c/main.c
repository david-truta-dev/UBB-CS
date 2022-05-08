#include <stdio.h>
/*
10. Multiple strings of characters are being read. Determine whether the first appears as a subsequence in each of the others and give an appropriate message.
*/
int is_subsequence(char [],char []);
int main()
{
    char s1[101],s[101];
    int n,is_subseq,i;
    printf("Enter n: ");
    scanf("%d",&n);
    
    fgets(s1,101,stdin);    // read empty line
    printf("\nEnter sequence: ");
    fgets(s1,101,stdin);
    for(i=0;s1[i];i++)//get index for null
        ;
    s1[i-1]='\0';   // move the null earlier
    /*
    because fgets is kinda shitty and adds new line char at the end
    of the string when reading.
    */
    
    for(i=0;i<n-1;i++)
    {
        printf("\nEnter sequence: ");
        fgets(s,101,stdin);
        is_subseq = is_subsequence(s1,s);
        if (is_subseq)
            printf("It is a subsequence.");
        else
            printf("It is not a subsequence.");
    }
	return 0;
}



