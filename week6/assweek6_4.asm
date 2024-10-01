.data
A: .word 3, -4, 2, 12, 8, 44, 60, 6, -11, 100
Aend: .word
.text
la $a0, A
la $a1, Aend
li $s0, 0 # count = 0 (count la bien dem phan tu)
li $s1, 0 # key = 0
li $s2, 0 # j = 0
li $s3, 1 # i = 1
DemPhanTu: 
beq $a1, $a0, Loop # So sanh dia chi hien tai trong a1 voi dia chi co so cua mang A
addi $a1, $a1, -4 # Dia chi a1 giam de den tung dia chi cua tung phan tu trong mang
addi $s0, $s0, 1 # So luong phan tu tang thêm 1
j DemPhanTu
Loop: beq $s3, $s0, Exit # Neu i = So luong phan tu có trong mang thì thoát
sll $t0, $s3, 2 # Tính Offset cua dia chi A[i]
add $s4, $a0, $t0 # Tính dia chi cua A[i]
lw $s1, 0($s4) # Load giá tri A[i] = key
addi $s2, $s3, -1 # j = i - 1
While: slt $t1, $s2, $zero # Neu j >= 0 thì t1 = 0
sll $t0, $s2, 2 # Tính offset cua dia chi A[j]
add $s5, $a0, $t0 # Tính dia chi cua A[j]
lw $t3, 0($s5) # Load giá tri A[j] = thanh ghi t3
sle $t4, $t3, $s1 # Neu key >= t3 thì t4 = 0
add $t1, $t1, $t4
bne $t1, $zero, loop_continue # Neu t1 = 0 thì dung while
addi $s5, $s5, 4 # Tính dia chi cua A[j+1]
sw $t3, 0($s5) # Ghi giá tri A[j] vào A[j+1]
addi $s2, $s2, -1 # j = j - 1
j While
loop_continue:
addi $s5, $s5, 4 # Tính địa chỉ của A[j+1]
sw $s1, 0($s5) # Ghi giá trị key vào A[j+1]
addi $s3, $s3, 1 # i++
j Loop
Exit: li $v0, 10
syscall