#include <stdio.h>

int main() {
    int x, y, *px, *py;
    int arr[10];

    printf("x = %d, y = %d, arr[10] = %d\n", x, y, arr[10]);

    x = 0;
    y = 0;
    for (int i = 0; i < 10; i++) {
        arr[i] = 0;
    }

    printf("\n");
    printf("x address %p\n", (void*)&x);
    printf("y address %p\n", (void*)&y);

    px = &x;
    py = &y;
    printf("\n");
    printf("value of px: %p, address of px: %p\n", (void*)px, (void*)&x);
    printf("value of py: %p, address of py: %p\n", (void*)py, (void*)&y);

    printf("\n");
    printf("contents of arr:\n");
    for(int i = 0; i < 10; i++){
        printf("arr %d: %d\n", i+1, arr[i+1]);
    }

    printf("\n");
    printf("address of arr: %p, address of arr[0]: %p\n", (void*)arr, (void*)&arr[0]);

    printf("\n");
    printf("address of arr: %p\n", (void*)&arr);

    return 0;
}
