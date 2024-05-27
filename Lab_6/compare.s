    .data
#2. Declare a new variable/label (n) and set it to 25.
n:    .word 25

#3. Insert instructions to declare the following strings:
str1: .asciiz "Less than\n"
str2: .asciiz "Less than or equal to\n"
str3: .asciiz "Greater than\n"
str4: .asciiz "Greater than or equal to\n"

#4. Insert instructions to read in an integer from users. Search from the Internet on how to use syscall to do it.
input_prompt: .asciiz "Enter an integer: "
    .text
    .globl main

#5. Insert code so the program will compare if the user input is less than n. If it is, output “Less than”.
main:
    # Print input prompt
    li $v0, 4
    la $a0, input_prompt
    syscall

    # Read integer from user
    li $v0, 5
    syscall
    move $t0, $v0 # Save user input in $t0

    # Load n from memory
    lw $t1, n

    # Compare if user input is less than n
    slt $t2, $t0, $t1
    beq $t2, $zero, check_greater_equal

    # Print "Less than"
    li $v0, 4
    la $a0, str1
    syscall
    j exit

#6. Insert code so the program will compare if the user input is greater than or equal to n. If it is, output “Greater than or equal to”.
check_greater_equal:
    # Compare if user input is greater than or equal to n
    slt $t2, $t1, $t0
    beq $t2, $zero, check_greater

    # Print "Greater than or equal to"
    li $v0, 4
    la $a0, str4
    syscall
    j exit

#7. Now comment out your code from steps 5 and 6. Insert code so the program will compare if the user input is greater than n. If it is, output “Greater than”.
check_greater:
    # Compare if user input is greater than n
    slt $t2, $t1, $t0
    bne $t2, $zero, print_greater

#8. Insert code so the program will compare if the user input is less than or equal to n. If it is, output “Less than or equal to”.
    # Print "Less than or equal to"
    li $v0, 4
    la $a0, str2
    syscall
    j exit

print_greater:
    # Print "Greater than"
    li $v0, 4
    la $a0, str3
    syscall

exit:
    # Exit program
    li $v0, 10
    syscall