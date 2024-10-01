.data
array: .space 100     # Array to store elements
size_prompt: .asciiz "Enter the size of the array: "
elem_prompt: .asciiz "Enter element: "
pos_sum_msg: .asciiz "Sum of positive numbers: "
even_sum_msg: .asciiz "Sum of even numbers: "
break: .asciiz "\n"
newline: .asciiz "\n"

.text

main:
        # Prompt for array size
        li $v0, 4
        la $a0, size_prompt
        syscall
    
        # Read array size
        li $v0, 5
        syscall
        move $t0, $v0        # $t0 contains array size
    
        # Read array elements
        la $t1, array        # Load address of array
        li $t2, 0            # Initialize loop counter
    
loop_read_element:
        # Prompt for element
        li $v0, 4
        la $a0, elem_prompt
        syscall
        
        # Read element
        li $v0, 5
        syscall
        sw $v0, ($t1)       # Store element in array
        
        addi $t1, $t1, 4    # Move to next array element
        addi $t2, $t2, 1    # Increment loop counter
        
        # Check if all elements are entered
        bne $t2, $t0, loop_read_element
        
        # Calculate sum of positive numbers and sum of even numbers
        li $t3, 0            # Sum of positive numbers
        li $t4, 0            # Sum of even numbers
        la $t1, array        # Reset array pointer
        li $t2, 0            # Reset loop counter
    
loop_calc_sum:
        lw $t5, ($t1)      # Load element from array
        
        # Check if positive
        blez $t5, not_positive
        add $t3, $t3, $t5  # Add to positive sum
        
not_positive:
        # Check if even
        andi $t6, $t5, 1   # Check if LSB is 1
        beq $t6, $zero, even
        j next_iteration
        
even:
        add $t4, $t4, $t5  # Add to even sum
        
next_iteration:
        addi $t1, $t1, 4    # Move to next array element
        addi $t2, $t2, 1    # Increment loop counter
        
        # Check if end of array
        blt $t2, $t0, loop_calc_sum
        
        # Print sum of positive numbers
        li $v0, 4
        la $a0, pos_sum_msg
        syscall
    
        li $v0, 1
        move $a0, $t3
        syscall
    
        li $v0, 4
        la $a0, break
        syscall
    
        # Print sum of even numbers
        li $v0, 4
        la $a0, even_sum_msg
        syscall
    
        li $v0, 1
        move $a0, $t4
        syscall
    
        # Exit
        li $v0, 10
        syscall