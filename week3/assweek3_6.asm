.data
A: .word 1,-11,3,-4,5,6,7,-9,-5,10
.text
addi $s3, $zero, 10 #tao so phan tu cua mang
addi $s4, $zero, 1 #tao buoc nhay
la $s2, A #Truy nhap thanh ghi $s2 vao dia chi A
addi $s5, $zero, 0 #gt = 0
addi $s6, $zero, 0 #dia chi = 0
addi $s1, $zero, 0 #i = 0
loop:
slt $t2, $s1, $s3 # $t2 = i < n? 1 : 0
beq $t2, $zero, endloop
add $t1,$s1,$s1 #$t1=2*$s1
add $t1,$t1,$t1 #$t1=4*$s1
add $t1,$t1,$s2 #$t1 store the address of A[i]
lw $t0,0($t1) #load value of A[i] in$t0
slt $t4, $t0, $zero #Kiem tra tri tuyet doi
beq $t4, $zero, duong
sub $t0,$zero,$t0 #Thuc hien khi A[i] la so am
duong:
slt $t5, $s5, $t0 #$s5 chua gia tri max
beq $t5, $zero, sai #Neu |a[i]| <= max thi nhay qua nhan “sai”
add $s5,$zero,$t0 #max = |a[i||
add $s6,$zero,$s1 #Cap nhat vi tri moi
j cont
sai:
addi $s5, $s5, 0
addi $s6, $s6, 0
j cont
cont:
add $s1,$s1,$s4 #i=i+step
j loop #goto loop
endloop: