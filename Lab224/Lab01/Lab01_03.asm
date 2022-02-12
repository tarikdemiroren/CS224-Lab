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
		beq $t1, $zero, error

		li $v0, 4 		#Printing a message for user
		la $a0, string3
		syscall
		
		li $v0, 5
		syscall
		add $t2, $zero, $v0	# t2 will contain c
		
		sub $t2, $t2, $t1	# t2 will now contain(c-b)
		beq $t2, $zero, error
		
		div $t0, $t1
		mflo $t3
		div $t3, $t2
		mfhi $t0
		
		
		
		li $v0, 4 		#Printing a message for user
		la $a0, string4
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall
		j end
		
error:		li $v0, 4 		#Printing a message for user
		la $a0, string5
		syscall
		
end:		li $v0, 10		#bye bye
		syscall
		
	.data
string1: .asciiz "Enter the number a: "
string2: .asciiz "Enter the number b: "
string3: .asciiz "Enter the number c: "
string4: .asciiz "The result of the given equation is: "
string5: .asciiz "Error: Divide by '0' detected!!! "
