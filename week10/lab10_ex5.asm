.eqv HEADING 0xffff8010       # Integer: An angle between 0 and 359 
                              # 0 : North (up) 
                              # 90: East (right) 
                              # 180: South (down) 
                              # 270: West (left) 
.eqv MOVING 0xffff8050        # Boolean (0 or non-0):
                              # whether or not to move
.eqv LEAVETRACK 0xffff8020    # Boolean (0 or non-0): 
                              # whether or not to leave a track 
.eqv KEY_CODE 0xFFFF0004      # ASCII code from keyboard, 1 byte 
.eqv KEY_READY 0xFFFF0000     # = 1 if has a new keycode ? 
                              # Auto clear after lw 
.eqv DISPLAY_CODE 0xFFFF000C  # ASCII code to show, 1 byte 
.eqv DISPLAY_READY 0xFFFF0008 # = 1 if the display has already to do 
                              # Auto clear after sw 

main:
   li $k0, KEY_CODE 
   li $k1, KEY_READY 
 
   li $s0, DISPLAY_CODE 
   li $s1, DISPLAY_READY 
   
   addi $v1, $zero, 0                    # $v1 to check whether the bot is moving or not
   addi $a0, $zero, 90
   jal  ROTATE
   nop
   
loop:       nop 
 
WaitForKey: lw  $t1, 0($k1)              # $t1 = [$k1] = KEY_READY 
            nop 
            beq $t1, $zero, WaitForKey   # if $t1 == 0 then Polling 
            nop 
            #------------------------------------------------------------------------------
ReadKey:    lw  $t0, 0($k0)              # $t0 = [$k0] = KEY_CODE 
            nop 
            #------------------------------------------------------------------------------ 
WaitForDis: lw  $t2, 0($s1)              # $t2 = [$s1] = DISPLAY_READY 
            nop 
            beq $t2, $zero, WaitForDis   # if $t2 == 0 then Polling 
            nop 
            #------------------------------------------------------------------------------
Encrypt:    addi $t0, $t0, 0

   beq  $t0, 65, DRAWA
   beq  $t0, 97, DRAWA
   
   beq  $t0, 83, DRAWS
   beq  $t0, 115, DRAWS
   
   beq  $t0, 68, DRAWD
   beq  $t0, 100, DRAWD
   
   beq  $t0, 87, DRAWW
   beq  $t0  119, DRAWW
   
   beq  $t0, 32, MOVE_OR_STOP 

   
ShowKey:    sw   $t0, 0($s0)             # show key 
            nop
            #------------------------------------------------------------------------------ 
            j    loop  

DRAWA:
   jal  UNTRACK
   nop
   jal  TRACK
   nop
   addi $a0, $zero, 270     # Marsbot goes to the left side
   jal  ROTATE
   nop
   j    ShowKey

DRAWS:
   jal  UNTRACK
   nop
   jal  TRACK
   nop
   addi $a0, $zero, 180    # Marsbot moves down
   jal  ROTATE
   nop
   j    ShowKey

DRAWD:
   jal  UNTRACK
   nop   
   jal  TRACK
   nop
   addi $a0, $zero, 90     # Marsbot goes to the right side
   jal  ROTATE
   nop
   j    ShowKey

DRAWW:
   jal  UNTRACK
   nop
   jal  TRACK
   nop
   addi $a0, $zero, 0      # Marsbot moves up
   jal  ROTATE
   nop
   j    ShowKey

MOVE_OR_STOP:
   beq  $v1, $zero, MOVE   # if $v1 == 0 then MOVE
   nop
   jal  STOP               # else STOP
   nop
   j    ShowKey
MOVE: jal GO
      nop
      
   j  ShowKey
   
endmain:

#Exit the program
   li $v0, 10
   syscall
   
#----------------------------------------------------------- 
# GO procedure, to start running 
# param[in] none 
#----------------------------------------------------------- 
GO:   li   $at, MOVING      # change MOVING port 
      addi $v1, $zero, 1    # to logic 1, 
      sb   $v1, 0($at)      # to start running 
      nop 
      jr   $ra 
      nop 
#----------------------------------------------------------- 
# STOP procedure, to stop running 
# param[in] none 
#----------------------------------------------------------- 
STOP: li   $at, MOVING      # change MOVING port to 0 
      addi $v1, $zero, 0    # to logic 0,
      sb   $v1, 0($at)      # to stop running
      nop 
      jr   $ra 
      nop 
#----------------------------------------------------------- 
# TRACK procedure, to start drawing line 
# param[in] none 
#----------------------------------------------------------- 
TRACK: li $at, LEAVETRACK  # change LEAVETRACK port 
       addi $a2, $zero, 1  # to logic 1, 
       sb $a2, 0($at)      # to start tracking 
       nop 
       jr $ra 
       nop 
#----------------------------------------------------------- 
# UNTRACK procedure, to stop drawing line 
# param[in] none 
#----------------------------------------------------------- 
UNTRACK:li $at, LEAVETRACK # change LEAVETRACK port to 0 
        sb $zero, 0($at)   # to stop drawing tail 
        nop 
        jr $ra 
        nop 
#----------------------------------------------------------- 
# ROTATE procedure, to rotate the robot 
# param[in] $a0, An angle between 0 and 359 
# 0 : North (up) 
# 90: East (right) 
# 180: South (down) 
# 270: West (left) 
#----------------------------------------------------------- 
ROTATE: li $at, HEADING    # change HEADING port 
        sw $a0, 0($at)     # to rotate robot 
        nop 
        jr $ra 
        nop 
