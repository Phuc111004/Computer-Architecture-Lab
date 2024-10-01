.data 
	mang: .space 100
	message1: .asciiz "la so may man"
	message2: .asciiz "khong phai la so may man"
.text
	li $v0,5
	syscall
	move $s0,$v0 # s0 la N
	la $s1,mang #s1 la mang luu cac gia tri chu so
	move $s2,$s1 #s2 dung de luu mang nguoc lai
	li $t3,0 #t3 luu tong 1
	li $t4,0 #t4 luu tong 2
	j xuly
xuly:
	li $t0,10
	div $s0,$t0
	mfhi $t1 # luu phan du
	mflo $t2 #luu phan thuong
	sw $t1,0($s2)
	addi $s2,$s2,4
	addi $s0,$t2,0 # cap nhat gia tri N
	beq $s0,0,tinhtong
	j xuly

tinhtong:
	sub $s2,$s2,4
	bge $s1,$s2,sosanh
	lw $t5,0($s1) # lay cac phan tu ben trai
	lw $t6,0($s2) # lay cac phan tu ben phai
	add $t3,$t3,$t5 # tinh tong ben trai
	add $t4,$t4,$t6 # tinh tong ben phai
	addi $s1,$s1,4
	j tinhtong
sosanh:
	beq $t3,$t4,right
	j wrong
right:
	li $v0,4
	la $a0,message1
	syscall
	li $v0,10
	syscall
wrong:
	li $v0,4
	la $a0,message2
	syscall
	li $v0,10
	syscall