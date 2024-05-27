#include <stdio.h>

int main(){
    int m = 10;
    int n = 5;

    int ra = sum(m, n);

    printf("%d\n", ra);

    return 0;
}

sum(int a0, int a1){
    return (a0 + a1);
}