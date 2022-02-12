	.text
main:		li $v0, 4
		la $a0, string1
		syscall
		
		li $v0, 5
		syscall
		
		move $s0, $v0 	# now s0 contains the array size
		
		li $v0, 9
		mul $s1, $s0, 4
		move $a0, $s1
		syscall
		
		move $a1, $v0 	# a1 contains the memory of the allocated space
		
		li $v0, 4
		la $a0, string2
		syscall
		
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $a1, 4($sp)
		
loop1:		li $v0, 5
		syscall
		sw $v0, 0($a1)
		addi $a1, $a1, 4
		addi $s0, $s0, -1
		bnez $s0, loop1
		
		lw $a1, 4($sp)
		lw $s0, 0($sp)
		addi $sp, $sp, 8 
		
		jal monitor
		
		li $v0, 10		#exits the program
		syscall
		
monitor:	li $v0, 4
		la $a0, string3
		syscall
		li $v0, 5
		syscall
		beq $v0, 1, opt1
		beq $v0, 2, opt2
		beq $v0, 3, opt3
		beq $v0, 4, opt4
		beq $v0, 5, opt5
		j monitor
opt1:		jal reinitialising
		j monitor
opt2:		jal bubbleSort
		j monitor
opt3:		jal medianMax
		j monitor
opt4:		jal print
		j monitor
opt5:		jal exit

reinitialising:	addi $sp, $sp, -4
		sw $ra, 0($sp)
		li $v0, 4		#start of array re-initialising
		la $a0, string2
		syscall
		
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $a1, 4($sp)
		
addToArray:	li $v0, 5
		syscall
		sw $v0, 0($a1)
		addi $a1, $a1, 4
		addi $s0, $s0, -1
		bnez $s0, addToArray
		
		lw $a1, 4($sp)
		lw $s0, 0($sp)
		addi $sp, $sp, 8
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra		#end of array re-initialising
		
bubbleSort:	addi $sp, $sp, -4
		sw $ra, 0($sp)

		bge $s0, 2, skip2	#checking the usability of the sort
		li $v0, 4
		la $a0, string5
		syscall
		j monitor

skip2:		addi $sp, $sp, -20	#start of bubble sort
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		sw $s2, 8($sp)
		sw $s3, 12($sp)
		sw $a1, 16($sp)
		
		move $s3, $s0
		
loop2:		lw $s1, 0($a1)
		lw $s2, 4($a1)
		ble $s1, $s2, skip
		sw $s1, 4($a1)
		sw $s2, 0($a1)
skip:		addi $a1, $a1, 4
		addi $s0, $s0, -1
		bne $s0, 1, loop2
inc:		lw $a1, 16($sp)
		addi $s3, $s3, -1
		move $s0, $s3
		bne $s3, 1, loop2
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $a1, 16($sp)
		addi $sp, $sp, 20 	# end of bubble sort
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
medianMax:	addi $sp, $sp, -4
		sw $ra, 0($sp)

		addi $sp, $sp, -12	#start of find median and max function
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		sw $a1, 8($sp)

		srl $s0, $s0, 1
		addi $s0, $s0, 1
		
loopMed:	lw $a2, 0($a1)
		addi $s0, $s0, -1
		addi $a1, $a1, 4
		bnez $s0, loopMed
		
		lw $a1, 8($sp)
		lw $s0, 0($sp)
		
loopMax:	lw $a3, 0($a1)
		addi $s0, $s0, -1
		addi $a1, $a1, 4
		bnez $s0, loopMax
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $a1, 8($sp)
		addi $sp, $sp, 12
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra		#end of the find median and max function

exit:		li $v0, 10		#exits the program
		syscall

print:		addi $sp, $sp, -4
		sw $ra, 0($sp)

					#prints the array one-by-one and 				
printingMedMax:	li $v0, 4		#shows the median and max values
		la $a0, string6
		syscall
		
		li $v0, 1
		move $a0, $a2
		syscall
		
		li $v0, 4
		la $a0, blank
		syscall
		
		li $v0, 1
		move $a0, $a3
		syscall
		
printArray:	addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $a1, 4($sp)
				
		li $v0, 4
		la $a0, string4
		syscall
		
loop3:		li $v0, 1
		lw $a0, 0($a1)
		syscall
		addi $a1, $a1, 4
		addi $s0, $s0, -1
		li $v0, 4
		la $a0, blank
		syscall
		bnez $s0, loop3
		
		lw $a1, 4($sp)
		lw $s0, 0($sp)
		addi $sp, $sp, 8 
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	.data
string1: 	.asciiz "\nEnter the number of elements: "
string2: 	.asciiz "\nEnter the elements one-by-one: "
string3:	.asciiz "\nEnter 1 to reinitialise the array elements\nEnter 2 to sort the array\nEnter 3 to calculate the median and the max value\nEnter 4 see the results\nEnter 5 to exit: "
string4: 	.asciiz "\nPrinting the array: "
blank: 	.asciiz " "
string5: 	.asciiz "\nCannot use bubble sort on a 1 sized array(actually cannot use any sort on a 1 sized array lol) "
string6: 	.asciiz "\nMedian and the Max value in order: "