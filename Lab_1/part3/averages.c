#include <stdio.h>

int main(){

    printf("Enter the 1st value: ");
    int value;
    scanf("%d", &value);

    int evenCount = 0, oddCount = 0, sumEven = 0, sumOdd = 0;
    float avg_even, avg_odd;
    int valCount = 2;

    while(value != 0){
        
        //separating values
        int tempVal = value;
        int splitVal = 0, tempSplit = 0;

        while(tempVal != 0){ //tempVal = 126
            int num = (tempVal % 10); //126%10 = 6... 12%10 = 2 ... 1%10 = 1
            tempSplit += num; //splitVal = 6 + 2 + 1 = 9
            tempVal /= 10; //tempVal = 126/10=12 ... 12/10=1
        }
        if(value < 0){
            splitVal += tempSplit;
        }
        else{
            splitVal += tempSplit;
        }
        
        //determine if value is odd or even
        if(splitVal != 0){
            if(splitVal % 2 == 0){ 
                sumEven += value;
                evenCount++;
            }else{
                sumOdd += value;//+9
                oddCount++; //+1
                
            }
        }

        //print out the command again
        if(valCount % 10 == 1 && valCount != 11){
            printf("Enter the %dst value: ", valCount);
        }
        else if(valCount % 10 == 2 && valCount != 12){
            printf("Enter the %dnd value: ", valCount);
        }
        else if(valCount % 10 == 3 && valCount != 13){
            printf("Enter the %drd value: ", valCount);
        }
        else{
            printf("Enter the %dth value: ", valCount);
        }

        splitVal = 0;
        value = 0;
        scanf("%d", &value);
        valCount ++;

    }

    avg_even = (float)sumEven/(float)evenCount;
    avg_odd = (float)sumOdd/(float)oddCount;
    
    printf("\n");
    if(evenCount != 0 || oddCount != 0){
        if(evenCount != 0){
            printf("Average of input values whose digits sum up to an even number: %.2f\n", avg_even);
        }
        if(oddCount != 0){
            printf("Average of input values whose digits sum up to an odd number: %.2f\n", avg_odd);
        }
    }
    else{
        printf("There is no average to compute.\n");

    }

    return 0;
}