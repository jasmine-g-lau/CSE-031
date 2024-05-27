#partner: Erika Maquiling

.data 

orig: .space 100	# In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100

str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "Sorted scores (in descending order): "
str4: .asciiz "Enter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded down) with dropped scores removed: "
space: .asciiz " "
newline: .asciiz "\n"


.text 

# This is the main program.
# It first asks user to enter the number of assignments.
# It then asks user to input the scores, one at a time.
# It then calls selSort to perform selection sort.
# It then calls printArray twice to print out contents of the original and sorted scores.
# It then asks user to enter the number of (lowest) scores to drop.
# It then calls calcSum on the sorted array with the adjusted length (to account for dropped scores).
# It then prints out average score with the specified number of (lowest) scores dropped from the calculation.
main: 
	addi $sp, $sp -4
	sw $ra, 0($sp)
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	# Read the number of scores from user
	syscall
	move $s0, $v0	# $s0 = numScores
	move $t0, $0
	la $s1, orig	# $s1 = orig
	la $s2, sorted	# $s2 = sorted
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5	# Read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	
	move $a0, $s0
	jal selSort	# Call selSort to perform selection sort in original array
	
	li $v0, 4 
	la $a0, str2 
	syscall
	move $a0, $s1	# More efficient than la $a0, orig
	move $a1, $s0
	jal printArray	# Print original scores
	li $v0, 4 
	la $a0, str3 
	syscall 
	move $a0, $s2	# More efficient than la $a0, sorted
	jal printArray	# Print sorted scores
	
	li $v0, 4 
	la $a0, str4 
	syscall 
	li $v0, 5	# Read the number of (lowest) scores to drop
	syscall
	move $a1, $v0
	sub $a1, $s0, $a1	# numScores - drop
	#move $a0, $s2
	move $a0, $s1
	jal calcSum	# Call calcSum to RECURSIVELY compute the sum of scores that are not dropped
	
	# Your code here to compute average and print it
	move $t0, $v0
    	div $t0, $t0, $a1

    	li $v0, 4 
    	la $a0, str5
   	syscall 

    	li $v0, 1        # print integer
    	move $a0, $t0
    	syscall

    	lw $ra, 0($sp)
    	addi $sp, $sp 4
    	li $v0, 10 
    	syscall
    	
# printList takes in an array and its size as arguments. 
# It prints all the elements in one line with a newline at the end.   	
printArray:
	move $t0, $0    # reset $t0
    	addi $sp, $sp, 4
    	sw $ra, 0($sp)
    	addi $sp, $sp, -4    # save in current array pointer
    	sw $a0, 0($sp)

printLoop: 
	sll $t1, $t0, 2        # $t1 = i * 4
    	add $a0, $a0, $t1    # adding $t1 to array pointer

    	lw $t2, 0($a0)        # load in number at the address

    	li $v0, 1        # print integer
    	move $a0, $t2
    	syscall

    	li $v0, 4 
    	la $a0, space

    	syscall

    	lw $a0, 0($sp)

    	addi $t0, $t0, 1    # increments t0 (i) 
    	bne $t0, $a1, printLoop

    	li $v0, 4 
    	la $a0, newline

    	syscall 

    	addi $sp, $sp, 4    # pop stack 
    	lw $a0, 0($sp)

    	jr $ra
	
# selSort takes in the number of scores as argument. 
# It performs SELECTION sort in descending order and populates the sorted array
selSort:
	#a0 = numScores = len, $s1 = orig, $s2 = sorted
	#"prologue"
	addi $sp, $sp, -8
	sw $ra, 12($sp)
	
	addi $t0, $zero, 0 #i
	addi $t1, $zero, 0 #j
	addi $t2, $zero, 0 #temp
	 
	#t3, t4 keep s1, s2 same for the rest of the program
	addi $t3, $s1, 0
	addi $t4, $s2, 0
	
	li $t0, 0 #t0: int i = 0
	
	sortCopy:
		addi $t0, $t0, 1 #++i
	
		#orig[i] = sorted[i]
		lw $t5, 0($t3) #load t3 with orig[i]
		sw $t5, 0($t4) #store orig[i] into sorted[i]

		addi $t3, $t3, 4
  		addi $t4, $t4, 4
	
		blt $t0, $a0, sortCopy  #go to copy loop if i < len
	
		#if end of the forloop
		li $t0, 0 #t0: reset int i = 0
	
	sortOuter:
		#increment loop
	
		addi $t6, $t0, 0  #t6: maxIndex = i
		addi $t1, $t0, 1  #$t5: j = i + 1
	
		sortInner:
			#blt $t5, $a0, sortOuter #branch to innerloop if j  < len
			
			#offset = (j * 4 ) - 4
			addi $t4, $s2, 0
			mul $t7, $t1, 4
			#subi $t7, $t7, 4
			
			add $t4, $t7, $t4 #shift by offset
			lw $t7, 0($t4) #give at sorted[j]
			addi $t4, $s2, 0 #reset t4 to beginning of array
	
			#offset = (maxIndex * 4) - 4
			mul $t8, $t6, 4
			#subi $t8, $t8, 4
			
			add $t4, $t8, $t4 #shift by offset
			lw $t8, 0($t4) #$t8 = sorted[j]
			addi $t4, $s2, 0 #reset t4 to beginning of array
			
			blt $t7, $t8, skip 
			
			addi $t6, $t1, 0 #update maxIndex to j
			
			skip:
				#blt $t1, $a0, sortInner #if j < len, branch
				addi $t1, $t1, 1
				blt $t1, $a0, sortInner 
				
				mul $t7, $t6, 4
				#subi $t7, $t7, 4
				
				add $t4, $t7, $t4 #shift by offset
				lw $t2, 0($t4) #temp = sort max index
				
				addi $t9, $t4, 0
				addi $t4, $s2, 0
				
				mul $t8, $t0, 4
				#subi $t8, $t8, 4
				
				add $t4, $t8, $t4 #shift by offset
				lw $t6, 0($t4) 
				sw $t6, 0($t9)
				sw $t2, 0($t4)
				
				addi $t4, $s2, 0
				
			addi $t0, $t0, 1 #++i
			subi $t5, $a0, 1 #t5: len - 1
			blt $t0, $t5, sortOuter
			#blt $t5, $t0, sortOuter
			
			jr $ra
			#i and j dont have the correct values at the right time
	
# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:
	# Your implementation of calcSum here

    	addi $sp, $sp, -16
    	sw $ra, 0($sp)
    	sw $a0, 4($sp)
    	sw $a1, 8($sp)

    	bgt $a1, $0, greaterZero    # if arraySize < 0, t0 = 1
    	addi $v0, $0, 0        # puts 0 inside $v0 (return value)
    	j end_recur

greaterZero:

    	addi $a1, $a1, -1    # making the argument to call calcSum again len - 1

    	jal calcSum

    	addi $a1, $a1, 1    # resetting len

    	sw $v0, 12($sp)        # storing the return value

    	move $t0, $a1        # puts len inside 
    	addi $t0, $t0, -1    # stores len - 1 
    	sll $t0, $t0, 2     # multiply len - 1 by 4
    	add $t0, $a0, $t0    # add len to array pointer
    	lw $t2, 0($t0)        # load in number at array pointer 
    	add $v0, $v0, $t2    # add number to return value

end_recur: 

    	lw $ra, 0($sp)         # get back old return address
    	addi $sp, $sp, 16    # Pop stack frame 
    	jr $ra