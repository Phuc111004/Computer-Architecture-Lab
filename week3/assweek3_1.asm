.data 
I: .word 3
J: .word 2
.text
la $t8, I
la $t9, J
lw $s1, 0($t8)
lw $s2, 0($t9)
addi $t1, $zero, 4 #x=4
addi $t2, $zero, 3 #y=4
addi $t3, $zero, 2 #z=4
start:
slt $t0,$s2,$s1 # j<i, thanh ghi $s2 chua gia tri j, thanh ghi $s1 chua gia tri i
bne $t0,$zero,else # branch to else if j<i
addi $t1,$t1,1 # then part: x=x+1
addi $t3,$zero,1 # z=1
j endif # skip “else” 
else:
addi $t2,$t2,-1 # y=y-1
add $t3,$t3,$t3 # z=2*z
endif:


