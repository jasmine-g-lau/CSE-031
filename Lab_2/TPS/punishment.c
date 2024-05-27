#include <stdio.h>

int main(){

    printf("Enter the repetition count for the punishment phrase: ");
    int count = 0;
    scanf("%d", &count); //take user input

    printf("Enter the line where you want to insert the typo: ");
    int typo = 0;
    scanf("%d", &typo);

    while(count < 0 || typo < 0 || typo > count){
        if(count < 0){
            printf("You entered an invalid value for the repetition count! Please re-enter: ");
            scanf("%d", &count);
        }
        
        if(typo < 0 || typo > count){
            printf("You entered an invalid value for the typo placement! Please re-enter: ");
            scanf("%d", &typo);
        }   
    }
    
    for(int i = 1; i < count; i++){
        if(i == typo){
            printf("Cading wiht is C avesone!\n");
        }
        printf("Coding with C is awesome!\n");
    }
    
    return 0;
}