		#All the functions used here is identical to the functions at the file generateSortedLinkList.asm except for the 
		#	duplicateRec function which duplicates the linked list in a recursive fashion. It accepts the head of to be duplicated 
		#	linked list in register $a1. And returns the head of new linked list in $v0.	
	.text
main:		la	$a0, string1
		li	$v0, 4
		syscall

		li 	$v0, 5
		syscall
		
		sw 	$v0, size
		
		lw 	$a0, size
		jal 	createLList
		
		move	$t1, $v0
		
		move	$a0, $t1
		jal 	printList
		
		move	$a1, $t1
		jal duplicateRec
		move	$t2, $v0
		
		move	$a0, $t2
		jal 	printList
		
		li	$v0, 10
		syscall

duplicateRec:	addi	$sp, $sp, -16
		sw	$s2, 12($sp)
		sw	$s1, 8($sp)
		sw	$s0, 4($sp)
		sw	$ra, 0($sp)
		
		move	$v0, $zero
		beqz	$a1, endDup
		
		li	$a0, 8	
		li	$v0, 9
		syscall
		
		move	$s2, $v0
		
		lw 	$s0, 4($a1)
		lw	$s1, 0($a1)
		move	$a1, $s1
		
		jal 	duplicateRec
		
		sw	$s0, 4($s2)
		sw	$v0, 0($s2)
		move	$v0, $s2
		
endDup:		lw	$s2, 12($sp)
		lw	$s1, 8($sp)
		lw	$s0, 4($sp)
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
		
		la	$a0, string2
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
string1:	.asciiz "Enter the size of the list you want to create: "
string2:	.asciiz "Enter the numbers one-by-one: "
blank:		.asciiz " "
