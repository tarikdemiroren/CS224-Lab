	.text
main:		li $v0, 4
		la $a0, string2
		syscall
		
		li $v0, 8
		la $a0, buffer
		lw $a1, max_length
		syscall
		
		jal switch
		
		move $t2, $zero
		move $t3, $zero
		
		b main
		
quit:		li $v0, 4
		la $a0, string1
		syscall
		
		li $v0, 10
		syscall
		
switch:		lw $t0, max_length
		addi $t0, $t0, -1
		
interpret:	lbu $t1, 0($a0)
		addi $a0, $a0, 1
		addi $t0, $t0, -1
		addi $t1, $t1, -48
		bge $t1, 8, quit
		blt $t1, 0, quit
		
		mul $t4, $t0, 3
		sllv $t1, $t1, $t4
		add $t3, $t3, $t1
		
		bnez $t0, interpret
		
print:		li $v0, 4
		la $a0, string3
		syscall
		
		move $a0, $t3
		li $v0, 1
		syscall
		
		jr $ra
		
	.data
string1:	.asciiz "\nError: Invalid octal number or Invalid number of bits!!!"
string2:	.asciiz "\nEnter an octal number (Enter your number using exactly 4 digits): "
string3:	.asciiz "\nInterpreted decimal number: "
max_length:	.word	5
buffer:		.space 16