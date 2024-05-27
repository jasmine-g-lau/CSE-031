//collaborated and worked together with Erika Maquiling
//gotten help from STEM CSE Tutor Porfi
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
void printPuzzle(char** arr, int cSize);
void searchPuzzle(char** arr, char* word);
int bSize;

char uppercase(char* word);
int counter;
int wordLength;
int** result;
int xOriginal, yOriginal = 0;
int wordFound = 0;
int row;
int column;

// Main function, DO NOT MODIFY 	
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
        return 2;
    }
    int i, j;
    FILE *fptr;

    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }

    // Read the size of the puzzle block
    fscanf(fptr, "%d\n", &bSize);
    
    // Allocate space for the puzzle block and the word to be searched
    char **block = (char**)malloc(bSize * sizeof(char*));
    char *word = (char*)malloc(20 * sizeof(char));

    // Read puzzle block into 2D arrays
    for(i = 0; i < bSize; i++) {
        *(block + i) = (char*)malloc(bSize * sizeof(char));
        for (j = 0; j < bSize - 1; ++j) {
            fscanf(fptr, "%c ", *(block + i) + j);            
        }
        fscanf(fptr, "%c \n", *(block + i) + j);
    }
    fclose(fptr);

    printf("Enter the word to search: ");
    scanf("%s", word);
    
    // Print out original puzzle grid
    printf("\nPrinting puzzle before search:\n");
    printPuzzle(block, bSize);
    
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
    
    return 0;
}

void printPuzzle(char** arr, int cSize) {
	// This function will print out the complete puzzle grid (arr). 
    // It must produce the output in the SAME format as the samples 
    // in the instructions.
    // Your implementation here...
    for(int i = 0; i < cSize; i++){
        for(int j = 0; j < cSize; j++){
            printf("%c ", *(*(arr+i) + j));
        }
        printf("\n");
    }
    printf("\n");

}

// function that turns each character into uppercase using ASCII
char uppercase(char* letter){
    if(*letter >= 'A' && *letter <= 'z'){
        if(*letter <= 'Z'){
            return *letter;
        } else {
            *letter = *letter - 32;
            return *letter;
        }
    }
}

int searcher(char** arr, char* letter, int x0, int y0){
    int i, j;
    // printf("current letter: %c\n", *letter);
    // printf("x0: %d y0: %d\n", x0, y0);

    //if current letter is last letter in word (next letter is null)
    if (*(letter + 1) == '\0'){
        //counter = 0;
        return 1;
    }

    //iterate over cells in puzzle grid
    for(i = 0; i < bSize; i++){
        for(j = 0; j < bSize; j++){
            if(x0 == i && y0 == j){ // makes sure it skips over itself
                continue;

            }

            //check adjacent 
            else if(i >= x0-1 && i <= x0+1 && j >= y0-1 && j <= y0+1){
                // printf("i: %d j: %d\n", i, j);
                
                //if adjacent cell contains next letter in word
                if(*(*(arr + i) + j) == *(letter + 1)){ 

                    //if word found, mark that cell as "result"
                    if(searcher(arr, letter + 1, i, j)){
                        
                        if(*(*(result + i) + j) != 0) {
                            *(*(result + i) + j) = *(*(result + i) + j)*10 + counter; // putting the numbers, making the path going backwards from recursion
                        } else *(*(result + i) + j) = counter; // putting the numbers, making the path going backwards from recursion
                        counter--; // decrement counter since counter is the length of strings, recursively calls so have to go backwards 

                        return 1;
                    } 
                }
            }
        }
    }

    return 0;
}

void searchPuzzle(char** arr, char* word) {
    // This function checks if arr contains the search word. If the 
    // word appears in arr, it will print out a message and the path 
    // as shown in the sample runs. If not found, it will print a 
    // different message as shown in the sample runs.
    // Your implementation here...
    int i, j, k, letter;

    result = (int**) malloc(bSize * (sizeof(int*)));

    // turns string into uppercase
    for(i = 0; i < strlen(word); i++){
        *(word + i) = uppercase(word + i);
    }

    *(word + strlen(word)) = '\0';
    counter = strlen(word);

    int wordLength = (int)(strlen(word));

    //initialize "result" grid 
    for(i = 0; i < bSize; i++){
        *(result + i) = (int*)malloc(bSize * sizeof(int));
    }

    for(i = 0; i < bSize; i++){
        for(j = 0; j < bSize; j++){
            *(*(result + i) + j) = 0;
        }
    }

    letter = 1;
    int x0 = 0, y0 = 0;
    bool foundAnyWord = false;

    //finding the first letter
    for(i = 0; i < bSize; i++){
        for(j = 0; j < bSize; j++){ 
            if(*(*(arr + i) + j) == *word){
                // printf("FOUND %c at (%d, %d).\n", *word, i, j);
                
                xOriginal = i;
                yOriginal = j;
                //call searcher to search for word starting from position of its first letter
                int wordFound = searcher(arr, word, xOriginal, yOriginal);
                if(wordFound){
                    *(*(result + i) + j) = 1;
                    counter = strlen(word);
                    foundAnyWord = true;
                }
                continue;
            }
        }
    }
    
    if(foundAnyWord){
        printf("\nWord found!\nPrinting the search path:\n");
        for(i = 0; i < bSize; i++){
            for(j = 0; j < bSize; j++){
            //- makes most recent print of to the left most area 
            // * makes width the same
            printf("%d\t", *(*(result + i) + j));
            }
            printf("\n");
        }
    } else {
        printf("Word not found.\n");
    }
}