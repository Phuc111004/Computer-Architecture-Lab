data
I: .word 3J: .word 3
.text
la $t8, I
la $t9, J
lw $s1, 0($t8)
lw $s2, 0($t9)
addi $t1, $zero, 5
addi $t2, $zero, 5
addi $t3, $zero, 5
addi $t4, $zero, 8 #m
addi $t5,$zero,7 #n
add $t6,$t4,$t5 #m+n
add $t7,$s1,$s2
start:
slt $t0,$t6,$t7
addi $s4,$zero,$1
bne $t0,$s4,else # branch to else if j<i
addi $t1,$t1,1 # then part: x=x+1
addi $t3,$zero,1 # z=1
j endif # skip “else” part
else:
addi $t2,$t2,-1 # begin else part: y=y-1
add $t3,$t3,$t3 # z=2*z
endif: