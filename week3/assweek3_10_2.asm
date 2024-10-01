.eqv HEADING 0xffff8010
.eqv MOVING 0xffff8050
.eqv LEAVETRACK 0xffff8020
.eqv WHEREX 0xffff8030
.eqv WHEREY 0xffff8040

.text
main:
    addi $a0, $zero, 90
    jal ROTATE
    jal GO
    addi $v0, $zero, 32   # Keep running by sleeping for 1000 ms
    li $a0, 15000
    syscall

    addi $a0, $zero, 180
    jal ROTATE
    jal GO
    addi $v0, $zero, 32   # Keep running by sleeping for 1000 ms
    li $a0, 7000
    syscall

sleep1:
    addi $a0, $zero, 162
    jal ROTATE
    jal GO
    jal UNTRACK         # Keep old track
    jal TRACK           # Draw new track line
    addi $v0, $zero, 32   # Keep running by sleeping for 1000 ms
    li $a0, 7000
    syscall

sleep2:
    addi $a0, $zero, 306
    jal ROTATE
    jal GO
    jal UNTRACK         # Keep old track
    jal TRACK           # Draw new track line
    addi $v0, $zero, 32   # Keep running by sleeping for 1000 ms
    li $a0, 7000
    syscall

sleep3:
    addi $a0, $zero, 90
    jal ROTATE
    jal GO
    jal UNTRACK         # Keep old track
    jal TRACK           # Draw new track line
    addi $v0, $zero, 32   # Keep running by sleeping for 1000 ms
    li $a0, 7000
    syscall

sleep4:
    addi $a0, $zero, 234
    jal ROTATE
    jal GO
    jal UNTRACK         # Keep old track
    jal TRACK           # Draw new track line
    addi $v0, $zero, 32   # Keep running by sleeping for 1000 ms
    li $a0, 7000
    syscall

sleep5:
    addi $a0, $zero, 18
    jal ROTATE
    jal GO
    jal UNTRACK         # Keep old track
    jal TRACK           # Draw new track line
    addi $v0, $zero, 32   # Keep running by sleeping for 1000 ms
    li $a0, 7000
    syscall

end_main:
    jal UNTRACK         # Keep old track
    addi $a0, $zero, 90
    jal ROTATE
    jal GO
    addi $v0, $zero, 32   # Keep running by sleeping for 1000 ms
    li $a0, 3000
    syscall

    jal STOP

    li $v0, 10
    syscall

GO:
    li $at, MOVING        # Change MOVING port
    addi $k0, $zero, 1    # to logic 1
    sb $k0, 0($at)        # to start running
    jr $ra

ROTATE:
    li $at, HEADING       # Change HEADING port
    sw $a0, 0($at)        # to rotate the robot
    jr $ra

STOP:
    li $at, MOVING        # Change MOVING port to 0
    sb $zero, 0($at)      # to stop
    jr $ra

TRACK:
    li $at, LEAVETRACK    # Change LEAVETRACK port
    addi $k0, $zero, 1    # to logic 1
    sb $k0, 0($at)        # to start tracking
    jr $ra

UNTRACK:
    li $at, LEAVETRACK    # Change LEAVETRACK port to 0
    sb $zero, 0($at)      # to stop drawing tail
    jr $ra