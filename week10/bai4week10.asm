.eqv MONITOR_SCREEN 0x10010000
.eqv YELLOW 0x00FFFF00
.eqv WHITE 0x00FFFFFF
.text
	li $k0, MONITOR_SCREEN
	li $s0, 2
	li $t0, -1 # Khoi tao j
For1: addi $t0, $t0, 1
	beq $t0, 8, Exit
	li $t1, -1 # Khoi tao i
For2: addi $t1, $t1, 1
	beq $t1, 8, EndFor2
	div $t0, $s0
	mfhi $t2
	div $t1, $s0
	mfhi $t3
	bne $t2, 0, Next
	bne $t3, 0, Paint2
	j Paint1
Next:
	beq $t3, 0, Paint2
Paint1:
	sll $s1, $t0, 3
	add $s1, $s1, $t1
	sll $s1, $s1, 2
	add $s2, $s1, $k0
	li $t4, YELLOW
	sw $t4, 0($s2)
	j For2
Paint2:
	sll $s1, $t0, 3
	add $s1, $s1, $t1
	sll $s1, $s1, 2
	add $s2, $s1, $k0
	li $t4, WHITE
	sw $t4, 0($s2)
	j For2
EndFor2:
	j For1
Exit: li $v0, 10
	syscall