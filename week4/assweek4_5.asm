.text
addi $s0, $zero, 30 #Dua so bi nhan vao thanh ghi $s0
addi $s1, $zero, 2048 
addi $t0, $zero, 1 #Cai dat thanh $t0 co gia tri 1
loop:
beq $s1, $t0, exit #Neu $s1 (So nhan) chi con gia tri la 1 thi ket thuc vong lap
sll $s0, $s0, 1 #Tang gia tri thanh ghi $s0 len 2 lan
srl $s1, $s1, 1 #Giam gia tri thanh ghi $s1 di 2 lan
j loop		#Lap lai
exit:
add $t9, $zero, $s0 #Luu ket qua vao thanh ghi $t9
