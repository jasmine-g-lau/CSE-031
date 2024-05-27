.data
#(input prompt to be displayed)
prompt: .asciiz "Please enter an integer: "  # Prompt message

.text
main: 	addi $sp, $sp, -4	# Moving stack pointer to make room for storing local variables (push the stack frame)
	
	#(display input prompt)
	li $v0, 4
	la $a0, prompt
	syscall
	
	#move $s1, $sp
	
	#(read user input)
	li $v0, 5
	syscall
	move $a0, $v0
		
	jal recursion	# Call recursion(x)
	
	#(print out returned value)
	move $a0, $v0
	li $v0, 1
	syscall
	
	j end		# Jump to end of program

# Implementing recursion
recursion: addi $sp, $sp, -12	# Push stack frame for local storage
	sw $ra, 0($sp)
	
	beq $a0, -1, negative_one
	ble $a0, -2, less_or_equal_negative_two
	
	addi $t0, $a0, -3    # m - 3
    	jal recursion        # recursion(m - 3)
    	add $t1, $v0, $a0    # Add return value of recursion(m - 3) and m
    	addi $a0, $a0, -2    # m - 2
    	jal recursion        # recursion(m - 2)
    	add $v0, $t1, $v0    # Add return value of recursion(m - 3) + m and return value of recursion(m - 2)

    	lw $ra, 0($sp)       # Restore return address
    	addi $sp, $sp, 12     # Deallocate space on stack
    	jr $ra               # Return to caller

negative_one:
    li $v0, 3            # Return 3
    j end_recur

less_or_equal_negative_two:
    li $v0, 1
    ble $a0, -2, end_recur
    li $v0, 2
    j end_recur

# End of recursion function	
end_recur:
	lw $ra, 0($sp)
	
	addi $sp, $sp, 12	# Pop stack frame 
	jr $ra

# Terminating the program
end:	addi $sp, $sp 4	# Moving stack pointer back (pop the stack frame)
	li $v0, 10 
	syscall
