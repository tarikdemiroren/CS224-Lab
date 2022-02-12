	.text
main:		la	$a0, string1
		li	$v0, 4
		syscall
		 
		li 	$v0, 5
		syscall
		move	$t0, $v0
		beqz	$t0, exit
		
		li 	$v0, 5
		syscall
		move	$t1, $v0
		beqz	$t1, exit

		move	$v0, $zero
		move	$a0, $t0
		move	$a1, $t1
		jal division
		move	$t2, $v0
		
		la	$a0, string2
		li	$v0, 4
		syscall
		
		li	$v0, 1
		move	$a0, $t2
		syscall
		
		j main
		
exit:		li 	$v0, 10
		syscall
		
division:	addi	$sp, $sp, -16
		sw	$s2, 12($sp)
		sw	$s1, 8($sp)
		sw	$s0, 4($sp)
		sw	$ra, 0($sp)
		
		move	$s1, $a0
		sub	$s0, $s1, $a1
		move	$a0, $s0
		bltz	$s0, endDiv
		
		jal division
		addi $v0, $v0, 1
endDiv:		
		lw	$s2, 12($sp)
		lw	$s1, 8($sp)
		lw	$s0, 4($sp)
		lw	$ra, 0($sp)
		addi	$sp, $sp, 16
		jr	$ra
	
	.data
string1: .asciiz	"\nEnter the numbers(Enter 0 to escape the program): "
string2: .asciiz	"The result is: "
