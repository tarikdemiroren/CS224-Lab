	.text
		la $t1, array
		la $t2, reverseArr
		
		li $v0, 4 		#Printing a message for user
		la $a0, string1
		syscall
		
		li $v0, 5 		#Determines the size of the array that the user wants
		syscall 
		add $t0, $zero, $v0 	#size value that will be used in functions
		add $t4, $zero, $t0 	#constant value of the size
		
		li $v0, 4 		#Printing a message for user
		la $a0, string2
		syscall
		
enter:		li $v0, 5 		#The user enters the desired array elements one by one
		syscall
		add $t5, $v0, $zero
		sw $t5, 0($t1)
		addi $t1, $t1, 4
		addi $t0, $t0, -1
		bne $t0, $zero, enter
		
		la $t1, array
		move $t0, $t4
		
multiply:	addi $t1, $t1, 4 	#This lines of codes manipulies the address of the array
		addi $t0, $t0, -1 	#for reversing the elements
		bne $t0, $zero, multiply
		addi $t1, $t1, -4
		move $t0, $t4
		
reverse:	lw $t3, 0($t1) 		#reverses the array's elements
		sw $t3, 0($t2)
		addi $t1, $t1, -4
		addi $t2, $t2, 4
		addi $t0, $t0, -1
		bne $t0, $zero, reverse 
		
		move $t0, $t4
		la $t1, array
		la $t2, reverseArr
		
checking:	lw $t6, 0($t1)
		lw $t7, 0($t2)
		bne $t6, $t7, notPalindrome
		addi $t1, $t1, 4
		addi $t2, $t2, 4
		addi $t0, $t0, -1
		bne $t0, $zero, checking
		
palindrome:	li $v0, 4 		#Printing a message for user
		la $a0, string4
		syscall	
		li	$v0, 10
		syscall

notPalindrome:	li $v0, 4 		#Printing a message for user
		la $a0, string3
		syscall	
		li $v0, 10
		syscall
		
	.data
array:	 	.space 80
reverseArr:	.space 80
string1:	.asciiz "Enter the number of elements: "
string2:	.asciiz "\nEnter the elements one by one: \n"
string3:	.asciiz "Array entered is not a palindrome\n"
string4:	.asciiz "Array entered is a palindrome\n"