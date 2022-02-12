	.text
start:		la	$a0, start
		la	$a1, done
		jal 	program
		move	$t2, $v0
		move	$t3, $v1
		la	$a0, string2
		li	$v0, 4
		syscall
		move	$a0, $t2
		li	$v0, 1
		syscall
		
		la	$a0, string1
		li	$v0, 4
		syscall
		move	$a0, $t3
		li	$v0, 1
		syscall
		
		addi	$t4, $t4, 1
		addi	$t4, $t4, 1
		addi	$t4, $t4, 1
		addi	$t4, $t4, 1
		add	$t4, $t4, $t4
		
		j try
try:		
		
		j done
	
program:	addi	$sp, $sp, -20
		sw	$s3, 16($sp)
		sw	$s2, 12($sp)
		sw	$s1, 8($sp)
		sw	$s0, 4($sp)
		sw	$ra, 0($sp)
		
		move	$s0, $a0
		move	$s1, $a1

loop:		bgt	$s0, $s1, endprog
		lw	$s3, 0($s0)
		sra 	$s2, $s3, 26
		beqz	$s2, incR
		
		beq	$s2, 3, endl
		beq	$s2, 2, endl
		
incI:		addi	$v1, $v1, 1
		j 	endl
incR:		addi	$v0, $v0, 1

endl:		addi	$s0, $s0, 4
		j loop
		
endprog:	lw	$s3, 16($sp)
		lw	$s2, 12($sp)
		lw	$s1, 8($sp)
		lw	$s0, 4($sp)
		lw	$ra, 0($sp)
		addi	$sp, $sp, 20
		jr	$ra

done:		li	$v0, 10
		syscall
	
	.data
string1: .asciiz 	"\nCount of I type instructions: "
string2: .asciiz	"\nCount of R type instructions: "