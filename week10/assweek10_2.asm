.eqv HEADING    0xffff8010  
.eqv MOVING     0xffff8050    
.eqv LEAVETRACK 0xffff8020 
.eqv WHEREX     0xffff8030 
.eqv WHEREY     0xffff8040
 
.text 
main:  
    addi $a0, $zero, 90 
    jal ROTATE  
    jal GO  
    addi $v0, $zero, 32    # Keep running by sleeping in 1000 ms          
    li $a0, 15000                  
    syscall           
    addi $a0, $zero, 180 
    jal ROTATE  
    jal GO 
    addi $v0, $zero, 32    # Keep running by sleeping in 1000 ms          
    li $a0, 7000                  
    syscall
 
    # Mio sleep la 1 doan, ve hay khong tuy nguoi lap trinh
 
    # sleep1:
    addi $a0, $zero, 150 
    jal ROTATE  
    jal GO  
    jal UNTRACK         # keep old track  
    jal TRACK           # and draw new track line  
    addi $v0, $zero, 32    # Keep running by sleeping in 1000 ms          
    li $a0, 7000                  
    syscall
 
    # sleep2:
    addi $a0, $zero, 270 
    jal ROTATE  
    jal GO  
    jal UNTRACK         # keep old track  
    jal TRACK           # and draw new track line  
    addi $v0, $zero, 32    # Keep running by sleeping in 1000 ms          
    li $a0, 7000                  
    syscall
 
    # sleep3:
    addi $a0, $zero, 30 
    jal ROTATE  
    jal GO  
    jal UNTRACK         # keep old track  
    jal TRACK           # and draw new track line  
    addi $v0, $zero, 32    # Keep running by sleeping in 1000 ms          
    li $a0, 7000                  
    syscall  
 
end_main: 
    jal UNTRACK         # keep old track  
    addi $a0, $zero, 90 
    jal ROTATE  
    jal GO  
    addi $v0, $zero, 32    # Keep running by sleeping in 1000 ms          
    li $a0, 3000                  
    syscall 
    jal STOP 
    li $v0, 10 
    syscall
 
GO:      
    li $t0, MOVING     # change MOVING port          
    addi $t1, $zero, 1    # to logic 1,          
    sb $t1, 0($t0)     # to start running          
    jr $ra  
 
ROTATE:  
    li $t0, HEADING    # change HEADING port          
    sw $a0, 0($t0)     # to rotate robot          
    jr $ra  
 
STOP:    
    li $t0, MOVING     # change MOVING port to 0          
    addi $t1, $zero, 0    # to stop          
    sb $t1, 0($t0)
    jr $ra
 
TRACK:   
    li $t0, LEAVETRACK # change LEAVETRACK port          
    addi $t1, $zero, 1    # to logic 1,          
    sb $t1, 0($t0)     # to start tracking          
    jr $ra
 
UNTRACK: 
    li $t0, LEAVETRACK # change LEAVETRACK port to 0          
    addi $t1, $zero, 0    # to stop drawing tail          
    sb $t1, 0($t0)
    jr $ra
