	.text
		la $t0, array
		lw $t4, oddOReven
		
		li $v0, 4 		#Printing a message for user
		la $a0, string1
		syscall
		
		li $v0, 5 		#Determines the size of the array that the user wants
		syscall 
		add $t1, $zero, $v0 	#size value that will be used in functions
		add $t2, $zero, $t1	#size value that will be constant for checking purposes
		
		li $v0, 4 		#Printing a message for user
		la $a0, string2
		syscall
		
enter:		li $v0, 5 		#The user enters the desired array elements one by one
		syscall
		add $t3, $v0, $zero
		sw $t3, 0($t0)
		addi $t0, $t0, 4
		addi $t1, $t1, -1
		bne $t1, $zero, enter
		
menu:		la $t0, array
		move $t1, $t2
		move $t3, $zero 	#These lines clears the registers after the options processed
		move $t5, $zero
		move $t6, $zero
		move $t7, $zero
		move $t8, $zero
		li $v0, 4 		#Printing a message for user
		la $a0, string3
		syscall
		li $v0, 4 		#Printing a message for user
		la $a0, string4
		syscall
		li $v0, 4 		#Printing a message for user
		la $a0, string5
		syscall
		li $v0, 4 		#Printing a message for user
		la $a0, string6
		syscall
choosing:	li $v0, 5 
		syscall
		beq $v0, 1, option1
		beq $v0, 2, option2
		beq $v0, 3, option3
		beq $v0, 4, option4
		b choosing		#Does nothing if the user enters another number
		
option1:	li $v0, 4 		#Printing a message for user
		la $a0, string7
		syscall
		li $v0, 5 
		syscall
		
loop1:		lw $t6, 0($t0)
		addi $t0, $t0, 4
		addi $t1, $t1, -1
		bgt $t6, $v0, increment
		bne $t1, $zero, loop1
		b result1
		
increment:	add $t3, $t3, $t6
		bne $t1, $zero, loop1
		
result1:	li $v0, 4 		#Printing a message for user
		la $a0, string8
		syscall
		li $v0, 1
		add $a0, $t3, $zero
		syscall
		b menu
		
option2:	lw $t6, 0($t0)
		addi $t0, $t0, 4
		addi $t1, $t1, -1
		div $t6, $t4
		mfhi $t5
		beq $t5, 1, odd
		beq $t5, 0, even
		
even:		add $t7, $t7, $t6
		bne $t1, $zero, option2
		b result2
		
odd:		add $t8, $t8, $t6
		bne $t1, $zero, option2
		b result2
		
result2:	li $v0, 4 		#Printing a message for user
		la $a0, string9
		syscall
		li $v0, 1
		add $a0, $t7, $zero
		syscall
		
		li $v0, 4 		#Printing a message for user
		la $a0, string10
		syscall
		li $v0, 1
		add $a0, $t8, $zero
		syscall
		b menu
		
option3:	li $v0, 4 		#Printing a message for user
		la $a0, string7
		syscall
		li $v0, 5 
		syscall
		
loop2:		lw $t6, 0($t0)
		addi $t0, $t0, 4
		addi $t1, $t1, -1
		div $t6, $v0
		mfhi $t5
		beq $t5, $zero, addthem
		bne $t1, $zero, loop2
		b result3
		
addthem:	addi $t7, $t7, 1
		bne $t1, $zero, loop2
		
result3:	li $v0, 4 		#Printing a message for user
		la $a0, string11
		syscall
		li $v0, 1
		add $a0, $t7, $zero
		syscall
		b menu

option4:	li $v0, 10
		syscall
		
		
	.data
array: 		.space 400
oddOReven:	.word 2
string1: 	.asciiz "Enter the number of elements: "
string2: 	.asciiz "\nEnter the elements one by one: \n"
string3:	.asciiz "\nEnter 1 to find summation of numbers stored in the array which is greater than an input number"
string4:	.asciiz "\nEnter 2 to find summation of even and odd numbers and display them"
string5:	.asciiz "\nEnter 3 to display the number of occurrences of the array elements divisible by a certain input number"
string6:	.asciiz "\nEnter 4 to exit the program\n"
string7:	.asciiz "\nEnter the input number: \n"
string8:	.asciiz "The result of the calculated sum is: \n"
string9:	.asciiz "\nThe result of the calculated sum of even numbers is: "
string10:	.asciiz "\nThe result of the calculated sum of odd numbers is: "
string11:	.asciiz "\nThe number of occurences of the values divisible by the input is: "