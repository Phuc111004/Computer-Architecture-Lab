#Laboratory Exercise 5, Assignment 1
.data
message: .asciiz "Cong nghe thong tin Viet Nhat"
.text
li $v0, 4 # $v0 = 4
la $a0, message # Dia chi cua test duoc ghi vao $a0
syscall 