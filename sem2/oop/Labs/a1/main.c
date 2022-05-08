/* 3. **a.** Print the Pascal triangle of dimension `n` of all combinations `C(m, k)` of m objects taken by `k, k = 0, 1, ..., m`, for line `m, where m = 1, 2, ..., n`.\
      **b.** Given a vector of numbers, find the longest contiguous subsequence of prime numbers. 
        de azi - descomp in fact primi a unui nr.
*/
#include <stdio.h>

int combinari(int n, int k){
    if (k == 0 || n == k)return 1;
    return combinari(n - 1, k - 1) + combinari(n - 1, k);
}

int prim(int n) {
    if (n < 2 || n > 2 && n % 2 == 0)return 0;
    for (int d = 3; d * d <= n; d += 2)
        if (n % d == 0)return 0;
    return 1;
}

int actualizare(int f, int s, int* fi, int* si) {
    //Primeste ca param doua intervale si daca primul este strict mai lung decat al doilea, al doilea primeste valorile primului.
    if (*si - *fi < s - f){ 
        *fi = f;
        *si = s;
    }
}

void gasire_secventa(int n, int v[], int* first_index, int* second_index){
    int f=0, s=0;
    for (int i = 1; i <= n; i++) {
        if (prim(v[i])){
            if (i == 1 || prim(v[i - 1]) == 0) f = i;
            s = i;
        }
        else actualizare(f, s, first_index, second_index);
    }
    actualizare(f, s, first_index, second_index);
}

void desc_fact_primi(int n) {
    int d = 2;
    printf("Numarul dat, descompus in facotri primi este: ");
    while (n > 1) {
        
        while (!prim(d))
            d += 1;
        
        while (n % d == 0) { 
            n = n / d; 
            printf("%d ", d);
        }
        d += 1;
    }
    printf("\n");
}

void construire_si_printare_triunghi(int n) {
    int nr_spatii = n - 1;
    for (int m = 0; m < n; m++) {
        for (int i = 1; i <= nr_spatii; i++)
            printf(" ");
        for (int k = 0; k <= m; k++) {
            printf("%d ", combinari(m, k));
        }
        nr_spatii--;
        printf("\n");
    }
}

void printare_secventa(int a, int b, int v[]) {
    for (int i = a; i <= b; i++)
        printf("v[%d]=%d\n", i, v[i]);
    printf("\n");
}

void ui_rezolvare(int* n, int v[]) {
    printf("\na)\n");
    construire_si_printare_triunghi(*n);

    int fi = 0, si = 0;
    printf("\nb)\n");
    gasire_secventa(*n, v, &fi, &si);
    if (si == 0) printf("Nu exista destule numere prime pentru a forma o secventa...\n");
    else printare_secventa(fi, si, v);
}

void ui_citire(int* n, int v[]) {
    printf("How many numbers do you want to read?\n>");
    scanf_s("%d", n);
    for (int i = 1; i <= *n; i++)
    {
        printf("v[%d]=", i);
        scanf_s("%d", &v[i]);
    }
}

void ui_citire2(int* n) {
    printf("Introdu un numar:");
    scanf_s("%d", n);
}

void ui_printare_meniu() {
    printf(" -------- Options ---------\n1 - read a vector of numbers.\n2 - solve a) and b).\n3 - Descompunere in factori primi\n4 - exit the program.\n>");
}

void ui_input_meniu(char* c) {
    scanf_s(" %c", c, 1);
}

void ui_meniu(int* n, int v[]) {
    char c = '1';
    int citit = 0;
    while (c != '4') {
        ui_printare_meniu();
        ui_input_meniu(&c);
        if (c == '1'){
            ui_citire(n, v);
            citit = 1;
        }
        else if (c == '2' && citit) {
            ui_rezolvare(n, v);
        }
        else if (c == '3') {
            int m;
            ui_citire2(&m);
            desc_fact_primi(m);
        }
        else {
            printf("Bruh...\n");
        }
    }
}

int main()
{
    int n, v[100];
    ui_meniu(&n, v);
}
