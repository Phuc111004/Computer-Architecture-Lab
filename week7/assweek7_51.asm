.data
   # Initialize the list of 8 elements 
   elements:  .word 5, 69, -33, 6, 12, 8, 45, 7
 
.text
main:
   # Initialize variables
   li $t0, -2147483648   # Largest value (minimum possible value)
   li $t1, 2147483647    # Smallest value (maximum possible value)
   li $t2, 0             # Index of largest value
   li $t3, 0             # Index of smallest value
 
   # Loop through the list of elements
   li $t4, 0            # Initialize loop counter
   la $a3,elements      # Pointer to the head of the list
loop:
   beq $t4, 8, done      # Exit loop when all elements processed
 
   # Load the current element from the list
   lw $t5, 0($a3)
 
   # Compare with largest value
   bgt $t5, $t0, update_largest
   j compare_smallest
 
update_largest:
   move $t0, $t5         # Update largest value
   move $t2, $t4         # Update index of largest value
   j compare_smallest
 
compare_smallest:
   blt $t5, $t1, update_smallest
   addi $t4, $t4, 1
   addi $a3, $a3, +4
   j loop
 
update_smallest:
   move $t1, $t5         # Update smallest value
   move $t3, $t4         # Update index of smallest value
 
   # Increment loop counter
   addi $t4, $t4, 1
   # Update pointer
   addi $a3, $a3, +4
   j loop
 
done:
   li $v0, 4
   la $a0, largest_str
   syscall
 
   li $v0, 1
   move $a0, $t0         # Largest value
   syscall
  
   li $v0, 4
   la $a0, comma
   syscall
 
   li $v0, 1
   move $a0, $t2         # Index of largest value
   syscall
 
   li $v0, 4
   la $a0, newline
   syscall
  
   li $v0, 4
   la $a0, smallest_str
   syscall
 
   li $v0, 1
   move $a0, $t1         # Smallest value
   syscall
  
   li $v0, 4
   la $a0, comma
   syscall
 
   li $v0, 1
   move $a0, $t3         # Index of smallest value
   syscall
 
   # Exit program
   li $v0, 10
   syscall
 
.data
newline:    .asciiz "\n"
largest_str: .asciiz "Largest: "
smallest_str: .asciiz "Smallest: "
comma: .asciiz ", "
