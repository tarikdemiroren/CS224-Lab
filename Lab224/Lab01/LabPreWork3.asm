	.text
		li $v0, 4 		#Printing a message for user
		la $a0, string1
		syscall
		
		li $v0, 5
		syscall
		add $t0, $zero, $v0	# t0 will contain a
		
		li $v0, 4 		#Printing a message for user
		la $a0, string2
		syscall
		
		li $v0, 5
		syscall
		add $t1, $zero, $v0	# t1 will contain b

		li $v0, 4 		#Printing a message for user
		la $a0, string3
		syscall
		
		li $v0, 5
		syscall
		add $t2, $zero, $v0	# t2 will contain c
		
		sub $t1, $t1, $t2	# t1 will contain the result of the substraction
		
		mul $t0, $t0, $t1	# t0 will contain the result of the multiplication
		ble $t0, 8, result
		
mod:		addi $t0, $t0, -8
		ble  $t0, 8, result
		b mod
		
adjust:		addi $t0, $t0, -8
		
result:		beq $t0, 8, adjust
		li $v0, 4 		#Printing a message for user
		la $a0, string4
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 10
		syscall
		
		
	.data
string1: .asciiz "Enter the number a: "
string2: .asciiz "Enter the number b: "
string3: .asciiz "Enter the number c: "
string4: .asciiz "The result is : "