.data
x:	.word 2
y:	.word 4
z:	.word 6

str:	 .asciiz "p + q: "
newLine: .asciiz "\n"

.text
MAIN:
#main(): x ? $s0, y ? $s1, z ? $s2
	la $t0, x
	lw $s0, 0($t0)		#s0 = x
	la $t1, y
	lw $s1, 0($t1)		#s1 = y
	la $t2, z
	lw $s2, 0($t2)		#s0 = z
	
#z = x + y + z + foo(x, y, z);
#Prepare to call sum(x)
	move $a0, $s0	#Set a0 as input argument for FOO
	move $a1, $s1	#Set a1 as input argument for FOO
	move $a2, $s2	#Set a2 as input argument for FOO	
	
	jal FOO

#z = x + y + z + foo(x, y, z);
	add $a2, $s0, $s1
	add $a2, $a2, $s2
	add $a2, $a2, $v0
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4
   	la $a0, newLine
    	syscall
    
    	li $v0, 10
	j END

FOO:
 #foo(): p ? $s0, q ? $s1
 #foo(): m ? $a0, n ? $a1, o ? $a2
	addiu $sp, $sp -24
	sw $s0, 0($sp)         #Backup $s0
    	sw $s1, 4($sp)         #Backup $s1
    	sw $s2, 8($sp)         #Backup $s1
    	sw $ra, 12($sp)        #Backup $ra
    	sw $a0, 16($sp)
    	sw $a1, 20($sp)
    	sw $a2, 24($sp)
    	
#int p = bar(m + o, n + o, m + n);
	move $t3, $a0
	move $t4, $a1
	move $t5, $a2
	
	add $a0, $t3, $t5 #m + o
	add $a1, $t4, $t5 #n + o
	add $a2, $t3, $t4 #m + n
	
	jal BAR
	move $s0, $v0
	
#int q = bar(m - o, n - m, n + n);
    	lw $a0, 16($sp)
    	lw $a1, 20($sp)
    	lw $a2, 24($sp)

	sub $a0, $t3, $t5 #m - o
	sub $a1, $t4, $t3 #n - m
	add $a2, $t4, $t4 #n + n
	
	jal BAR
	move $s1, $v0
	
	add $v0, $s0, $s1
	
#print
	lw $s0, 0($sp)         # Backup $s0
    	lw $s1, 4($sp)         # Backup $s1
    	lw $s2, 8($sp)         # Backup $s2
    	lw $ra, 12($sp)         # Backup $ra
	addiu $sp, $sp 24
	
	li $v0, 4		
	la $a0, str
	syscall	
	
	add $t0, $s0, $s1
	li $v0, 1		
	move $a0, $t0
	syscall	
	
	li $v0, 4		
	la $a0, newLine 
	syscall	

	add $v1, $t0, $zero
	jr $ra
	
BAR:	
#return (b - a) << (c);
	sub $v0, $a1, $a0
	sllv $v0, $v0, $a2

	jr $ra
	
END:
	li $v0, 10
	syscall
