#include <stdio.h>


void concatenate_words(char [],int,int,char[][101]);
int main()
{
    char result[201];
    char s[101][101];
    int n, i, m = 101;
    
    printf("Enter n: ");
    scanf("%d",&n);
    fgets(s[0],101,stdin);
    for(i=0;i<n;i++)
    {
        printf("Enter sentence %d: ",i);
        fgets(s[i],101,stdin);
    }
    
    concatenate_words(result,n,m,s);
    printf("%s",result);
	return 0;
}



