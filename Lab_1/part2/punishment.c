#include <stdio.h>

int main(){

    printf("Enter the repetition count for the punishment phrase: ");
    int count = 0;
    scanf("%d", &count); //take user input

    while(count <= 0){
        printf("You entered an invalid value for the repetition count! Please re-enter: ");
        scanf("%d", &count);
    }

    printf("\nEnter the line where you want to insert the typo: ");
    int typo = 0;
    scanf("%d", &typo);

    while(typo <= 0 || typo > count){
        printf("You entered an invalid value for the typo placement! Please re-enter: ");
        scanf("%d", &typo); 
    }
    
    printf("\n");

    for(int i = 0; i <= count-1; i++){
        if(i+1 == typo){
            printf("Cading wiht is C avesone!\n");
        }
        else{
            printf("Coding with C is awesome!\n");
        }
    }
    
    return 0;
}