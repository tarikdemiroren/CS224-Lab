.text
	#Tarýk Demirören 21902258
	la $a0, stringWarning
	li $v0, 4
	syscall
main:	la $a0, string1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	jal choice
	j main
	
exit:	li $v0, 10
	syscall
	
choice:	addi 	$sp, $sp, -4
	sw 	$ra, 0($sp)
	beq 	$v0, 1, Opt1
	beq 	$v0, 2, Opt2 #after this line t0 contains size, t2 contains the address of the array
	beq 	$v0, 3, Opt3
	beq 	$v0, 4, Opt4
	beq 	$v0, 5, Opt5
	beq 	$v0, 6, exit
return:	lw 	$ra, 0($sp)
	addi 	$sp, $sp, 4
	jr 	$ra
	
Opt1:	la 	$a0, string2
	li 	$v0, 4
	syscall
	li 	$v0, 5
	syscall
	move 	$t0, $v0
	j 	return

Opt2:	mult	$t0, $t0
	mflo	$t1
	li	$v0, 9
	move 	$a0, $t1
	syscall
	move 	$t2, $v0
	move 	$t5, $zero
	move 	$t3, $t2
init:	beq 	$t5, $t1, end
	addi 	$t5, $t5, 1
	sw 	$t5, 0($t3)
	addi 	$t3, $t3, 4
	j init
end:	j return
	
Opt3:	move 	$t4, $t2
	la 	$a0, string3
	li 	$v0, 4
	syscall
	li 	$v0, 5
	syscall
	move	$t1, $v0 #t1 row
	li 	$v0, 5
	syscall
	move	$t3, $v0 #t3 column
	

goRow:	beq	$t1, 1, goCol
	mul 	$t5, $t0, 4  
	add	$t4, $t4, $t5
	addi	$t1, $t1, -1
	j goRow
goCol:	beq 	$t3, 1, doneCol
	addi	$t4, $t4, 4
	addi	$t3, $t3, -1
	j goCol
doneCol:
	la 	$a0, string4
	li 	$v0, 4
	syscall
	lw	$a0, 0($t4)
	li	$v0, 1
	syscall
	j return
	
Opt4:	move 	$t4, $t2
	move	$t3, $zero
	move	$t1, $zero
	move	$t7, $t0
	la 	$a0, string5
	li 	$v0, 4
	syscall
start:	beq	$t7, 0, doone
	jal 	calcsum
	move	$a0, $t1
	li	$v0, 1
	syscall
	la 	$a0, blank
	li 	$v0, 4
	syscall
	addi	$t7, $t7, -1
	j start

doone:	j return
calcsum:
	move	$t1, $zero
	move 	$t5, $t0
loop:	beq	$t5, 0, donecalc
	lw	$t3, 0($t4)
	add	$t1, $t1, $t3
	addi	$t4, $t4, 4
	addi	$t5, $t5, -1
	j loop
donecalc: 	jr $ra

Opt5:	move 	$t4, $t2
	move	$t8, $t2
	move	$t3, $zero
	move	$t1, $zero
	move	$t7, $t0
	la 	$a0, string6
	li 	$v0, 4
	syscall
	
loop3:	beq	$t7, 0, dooone
	jal 	calcCol
	move	$a0, $t1
	li	$v0, 1
	syscall
	la 	$a0, blank
	li 	$v0, 4
	syscall
	addi	$t7, $t7, -1
	addi	$t8, $t8, 4
	move	$t4, $t8
	j loop3
dooone: j return

calcCol:	move	$t1, $zero
		move 	$t5, $t0
		mul	$t6, $t0, 4
loop2:		beq	$t5, 0, donecalccol
		lw	$t3, 0($t4)
		add	$t1, $t1, $t3
		add	$t4, $t4, $t6
		addi	$t5, $t5, -1
		j loop2
donecalccol: 	jr $ra
	
.data
stringWarning: .asciiz "!!!DO NOT PRESS ANY OTHER MENU OPTION BEFORE PRESSING 1 AND 2 SUBSEQUENTLY!!!"
string1: .asciiz "\nOpt 1: Entering the size\nOpt 2: Creating the container\nOpt 3: Retrieving an element\nOpt 4: Sum of Rows\nOpt 5: Sum of Cols\nOpt 6: Quit\nYour choice: "
string2: .asciiz "Enter the matrix size in terms of its dimensions: "
string3: .asciiz "Enter the coordinates: "
string4: .asciiz "The value is: "
string5: .asciiz "Sum of the individual rows: "
string6: .asciiz "Sum of the individual columns: "
blank: .asciiz " "
