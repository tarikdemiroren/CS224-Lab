	##sub-programs:
	##	createLList: 	creates a linked list by user interaction and returns the address of the head in $v0
	##	duplicate:	duplicates a linked list. Expects an existing link list head in $a0. returns the address of the new linked list in $v0.
	##	printList:	prints the linked list whose address is indicated by $a0
	##	findMin:	finds the minimum number and its index in a linked list indicated by $a0, returns the number in $v0, the index in $v1
	##	strtdeleteNode:	in a linked list whose head is indicated by $a0, deletes a node whose index is indicated by $a1 and returns the new head
	##				in $a0.
	.text
main:		la	$a0, string2
		li	$v0, 4
		syscall

		li $v0, 5
		syscall
		
		sw 	$v0, size
		
		lw 	$a0, size
		jal 	createLList
		
		move 	$t1, $v0	#t1 contains the initial list
		
		move	$a0, $v0
		jal 	duplicate
		
		move	$t2, $v0	#t2 contains the duplicate list
		
		la	$a0, string3
		li	$v0, 4
		syscall
		
		move	$a0, $t2
		jal 	printList

		move 	$a0, $t1
		move 	$a1, $t2
		jal	beginSorting
		
		la	$a0, string4
		li	$v0, 4
		syscall
		
		move	$a0, $t1
		jal 	printList
		
		li 	$v0, 10
		syscall
		
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
		
				
		la	$a0, string5
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
		
duplicate:	addi	$sp, $sp, -36
		sw	$s7, 32($sp)
		sw	$s6, 28($sp)
		sw	$s5, 24($sp)
		sw	$s4, 20($sp)
		sw	$s0, 16($sp)
		sw	$s1, 12($sp)
		sw	$s2, 8($sp)
		sw	$s3, 4($sp)
		sw	$ra, 0($sp)
		
		move 	$s5, $a0	
		lw	$s6, 0($s5)
		lw	$s7, 4($s5)	
		
		lw 	$s0, size
		li 	$s1, 1
		
		li	$a0, 8
		li	$v0, 9
		syscall
		
		move	$s2, $v0
		move	$s3, $v0

		move 	$s4, $s7
		
		sw 	$s4, 4($s2)
		move	$s5, $s6
		
addNode2:	beq	$s1, $s0, duplicatedone
		addi	$s1, $s1, 1	
		li	$a0, 8 		
		li	$v0, 9
		syscall
		
		lw	$s6, 0($s5)
		lw	$s7, 4($s5)

		sw	$v0, 0($s2)

		move	$s2, $v0	

		move 	$s4, $s7
		move	$s5, $s6

		sw	$s4, 4($s2)	
		j	addNode2
		
duplicatedone:	sw	$zero, 0($s2)
		move	$v0, $s3

		lw	$s7, 32($sp)
		lw	$s6, 28($sp)
		lw	$s5, 24($sp)
		lw	$s4, 20($sp)
		lw	$s0, 16($sp)
		lw	$s1, 12($sp)
		lw	$s2, 8($sp)
		lw	$s3, 4($sp)
		lw	$ra, 0($sp)
		addi	$sp, $sp, 36
		jr 	$ra
		
findMin:	addi	$sp, $sp, -20
		sw	$s3, 16($sp)
		sw	$s0, 12($sp)
		sw	$s1, 8($sp)
		sw	$s2, 4($sp)
		sw	$ra, 0($sp)
		
		li	$s3, 0
		
		move	$s0, $a0
		li	$v0, 100000
		
loops:		beq	$s0, $zero, foundMin
		lw	$s1, 0($s0)
		lw	$s2, 4($s0)
		addi	$s3, $s3 , 1
		
		bgt	$s2, $v0, skip
		move	$v0, $s2
		move	$v1, $s3
		
skip:		move	$s0, $s1
		j	loops

foundMin:	lw	$s3, 16($sp)
		lw	$s0, 12($sp)
		lw	$s1, 8($sp)
		lw	$s2, 4($sp)
		lw	$ra, 0($sp)
		addi	$sp, $sp, 20
		jr $ra
		
strtdeleteNode:	#a0 head, a1 index||returns $a0 head
		addi	$sp, $sp, -20
		sw	$s3, 16($sp)
		sw	$s0, 12($sp)
		sw	$s1, 8($sp)
		sw	$s2, 4($sp)
		sw	$ra, 0($sp)
		li	$s3, 1
		move 	$s0, $a0
		beq	$t9, 1, donedltNode
		beq 	$a1, 1, dltHead
		
goToIndex:	lw 	$s1, 0($s0)
		move 	$s0, $s1
		addi	$s3, $s3, 1
		bne	$s3, $a1, goToIndex

		
dltNode:	lw 	$s1, 0($s0)
		beqz	$s1, delte
		lw 	$s1, 0($s0)
		lw	$s2, 12($s0)
		sw	$s2, 4($s0)
		move	$s0, $s1
		j	dltNode
		
delte:		sw	$zero, -8($s0)
		j	donedltNode
		
dltHead:	lw 	$s1, 0($s0)
		move	$a0, $s1
		j	donedltNode

donedltNode:	addi	$t9, $t9, -1
		lw	$s3, 16($sp)
		lw	$s0, 12($sp)
		lw	$s1, 8($sp)
		lw	$s2, 4($sp)
		lw	$ra, 0($sp)
		addi	$sp, $sp, 20
		jr $ra
		
beginSorting:	addi	$sp, $sp, -28
		sw	$s5, 24($sp)
		sw	$s4, 20($sp)
		sw	$s0, 16($sp)
		sw	$s1, 12($sp)
		sw	$s2, 8($sp)
		sw	$s3, 4($sp)
		sw	$ra, 0($sp)
		
		move 	$s0, $a0
		move	$s1, $a1 
		lw	$t9, size
		
commenceSort:	beq	$s0, $zero, sortEnded 

		lw	$s2, 0($s0)
		move	$a0, $s1
		jal	findMin
		move	$s4, $v0
		move 	$s5, $v1
		sw	$s4, 4($s0)
		move	$a1, $s5
		move	$a0, $s1
		jal	strtdeleteNode
		move	$s1, $a0
		move	$s0, $s2
		j commenceSort
		
sortEnded:	lw	$s5, 24($sp)
		lw	$s4, 20($sp)
		lw	$s0, 16($sp)
		lw	$s1, 12($sp)
		lw	$s2, 8($sp)
		lw	$s3, 4($sp)
		lw	$ra, 0($sp)
		addi	$sp, $sp, 28
		jr $ra
		
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
string2:	.asciiz "Enter the size of the linked list you want to create: "
string3:	.asciiz "\nInitial list: "
string4:	.asciiz "\nList after sorting is done: "
string5:	.asciiz "Enter the numbers one-by-one: "
blank:		.asciiz " "
