	.text
main:		la	$a0, string1
		li	$v0, 4
		syscall
		
		li 	$v0, 5
		syscall
		
		sw 	$v0, size
		lw 	$a0, size
		jal 	createLList
		move	$t0, $v0
		
		la	$a0, string2
		li	$v0, 4
		syscall
		
		move	$a0, $t0
		jal	printList
		
		la	$a0, string3
		li	$v0, 4
		syscall
		
		move	$a0, $t0
		jal	printRec
		
exit:		li	$v0, 10
		syscall
		
printRec:	addi	$sp, $sp, -16
		sw	$s0, 12($sp)
		sw	$s1, 8($sp)
		sw	$s2, 4($sp)
		sw	$ra, 0($sp)
		
		beqz	$a0, endPrintRec
		move 	$s0, $a0
		lw	$s1, 0($s0)
		lw	$s2, 4($s0)
		move	$a0, $s1
		
		jal printRec
		
		li 	$v0, 1
		move	$a0, $s2
		syscall
		la	$a0, blank
		li 	$v0, 4
		syscall
		
endPrintRec:	lw	$s0, 12($sp)
		lw	$s1, 8($sp)
		lw	$s2, 4($sp)
		lw	$ra, 0($sp)
		addi	$sp, $sp, 16
		jr	$ra
		
createLList:	addi	$sp, $sp, -24
		sw	$s0, 20($sp)
		sw	$s1, 16($sp)
		sw	$s2, 12($sp)
		sw	$s3, 8($sp)
		sw	$s4, 4($sp)
		sw	$ra, 0($sp)
		
		move 	$s0, $a0
		li 	$s1, 1
		
		li	$a0, 8
		li	$v0, 9
		syscall
		
		move	$s2, $v0
		move	$s3, $v0
		
		la	$a0, string4
		li	$v0, 4
		syscall
		
		li 	$v0, 5
		syscall
		move 	$s4, $v0
		
		sw 	$s4, 4($s2)
		
addNode:	beq	$s1, $s0, allDone
		addi	$s1, $s1, 1	
		li	$a0, 8 		
		li	$v0, 9
		syscall

		sw	$v0, 0($s2)

		move	$s2, $v0	

		li 	$v0, 5
		syscall
		move 	$s4, $v0

		sw	$s4, 4($s2)	
		j	addNode
allDone:
		sw	$zero, 0($s2)
		move	$v0, $s3	

		lw	$ra, 0($sp)
		lw	$s4, 4($sp)
		lw	$s3, 8($sp)
		lw	$s2, 12($sp)
		lw	$s1, 16($sp)
		lw	$s0, 20($sp)
		addi	$sp, $sp, 24
		
		jr	$ra
		
printList:	addi	$sp, $sp, -20
		sw	$s0, 16($sp)
		sw	$s1, 12($sp)
		sw	$s2, 8($sp)
		sw	$s3, 4($sp)
		sw	$ra, 0($sp)
		
		move 	$s0, $a0
printNextNode:
		beq	$s0, $zero, printedAll

		lw	$s1, 0($s0)
		lw	$s2, 4($s0)
		
		move	$a0, $s2
		li	$v0, 1		
		syscall	
		
		la	$a0, blank
		li 	$v0, 4
		syscall

		move	$s0, $s1
		j	printNextNode
printedAll:
		lw	$ra, 0($sp)
		lw	$s3, 4($sp)
		lw	$s2, 8($sp)
		lw	$s1, 12($sp)
		lw	$s0, 16($sp)
		addi	$sp, $sp, 20
		jr	$ra
	.data
size:		.word
string1:	.asciiz "Enter the size of the linked list you want to create: "
string2:	.asciiz "\nPrinting the linked list: "
string3:	.asciiz "\nPrinting the linked list backwards: "
string4:	.asciiz "Enter the numbers one-by-one: "
blank:		.asciiz " "