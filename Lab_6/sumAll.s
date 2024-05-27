#Pseudocode:
#Initialize even_sum and odd_sum to 0

#Loop:
    #Prompt the user to enter a number
    #Read the input number from the user
    
    #If the input number is 0, exit the loop
    
    #If the input number is even:
        #Add the input number to even_sum
    
    #If the input number is odd:
        #Add the input number to odd_sum
    
#End Loop

#Print the sum of even numbers (even_sum)
#Print the sum of odd numbers (odd_sum)


    .data
prompt: .asciiz "Please enter a number: "
even_msg: .asciiz "Sum of even numbers is: "
odd_msg: .asciiz "Sum of odd numbers is: "
newline: .asciiz "\n"

    .text
    .globl main

#Initialize even_sum and odd_sum to 0
main:
    li $t0, 0 # even_sum
    li $t1, 0 # odd_sum

#Loop:
loop: 
    #Prompt the user to enter a number
    li $v0, 4
    la $a0, prompt
    syscall

    #Read the input number from the user
    li $v0, 5
    syscall
    move $t2, $v0 # Save user input in $t2

    #If the input number is 0, exit the loop
    beq $t2, $zero, print_result
    
    #If the input number is even:
    sll $t3, $t2, 31  # Shift left by 31 bits
    srl $t3, $t3, 31  # Shift right by 31 bits (sign extension)
    beq $t3, $zero, check_odd
    
    #Add the input number to even_sum
    add $t0, $t0, $t2
    j loop

# If the input number is odd:
check_odd:
    # Check if the input number is odd
    sub $t3, $zero, $t2  # Negative number if odd
    beq $t3, $zero, loop  # Jump back to loop if even
    
    # Add the input number to odd_sum
    add $t1, $t1, $t2
    j loop 
    
add_odd:
    # Add the input number to odd_sum
    add $t1, $t1, $t2
    j loop 

print_result:
# Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    # Print the sum of even numbers
    li $v0, 4
    la $a0, even_msg
    syscall
    
    move $a0, $t0
    li $v0, 1
    syscall
    
    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Print the sum of odd numbers
    li $v0, 4
    la $a0, odd_msg
    syscall
    
    move $a0, $t1
    li $v0, 1
    syscall
    
    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Exit the program
    li $v0, 10
    syscall
