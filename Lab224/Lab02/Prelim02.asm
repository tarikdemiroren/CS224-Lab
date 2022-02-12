	.text
main:		li $v0, 4
		la $a0, message1
		syscall
		
		li $v0, 5
		syscall
		
		beq $v0, 0, exit
		
		jal swapping
		
		j main
		
exit:		li $v0, 10
		syscall
		
		
swapping:	move $t3, $zero
		addi $t7, $zero, 16
		move $s1, $v0
		
		li $v0, 4
		la $a0, message3
		syscall

		li $v0, 34
		move $a0, $s1
		syscall
		
loop:		mul $t6, $t3, 8
		div $s1, $t7
		mfhi $t0
		srl $s1, $s1, 4
		div $s1, $t7
		mfhi $t1
		srl $s1, $s1, 4
		add $t2, $t2, $t0
		sll $t2, $t2, 4
		add $t2, $t2, $t1
		move $t4, $t5
		add $t5, $zero, $t2
		sllv $t5, $t5, $t6
		add $t5, $t5, $t4
		move $t2, $zero
		
		addi $t3, $t3, 1
		bne $t3, 4, loop
		
		li $v0, 4
		la $a0, message2
		syscall
		
		li $v0, 34
		move $a0, $t5
		syscall
		
		move $t5, $zero
		move $t4, $zero
		move $t3, $zero
		
		jr $ra
	
	.data
message1:.asciiz "\nEnter the number(0 to quit): "
message2:.asciiz "\nSwitched number: "
message3:.asciiz "\nHexadecimal of the number you entered: "