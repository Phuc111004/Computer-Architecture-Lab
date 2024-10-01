.data
s1: .space 64   # Allocate space for string 1
s2: .space 64   # Allocate space for string 2

.text

main:
    # Prompt user to enter the first string
    li $v0, 4
    la $a0, prompt1
    syscall

    # Read the first string from the user
    li $v0, 8
    la $a0, s1
    li $a1, 64   # Maximum number of characters to read
    syscall

    # Prompt user to enter the second string
    li $v0, 4
    la $a0, prompt2
    syscall

    # Read the second string from the user
    li $v0, 8
    la $a0, s2
    li $a1, 64   # Maximum number of characters to read
    syscall

    # Call function to compare strings
    la $a0, s1
    la $a1, s2
    jal compare_strings

    # Print the result
    beq $v0, 1, equal_strings
    li $v0, 4
    la $a0, not_equal_msg
    syscall
    j end_program

equal_strings:
    li $v0, 4
    la $a0, equal_msg
    syscall

end_program:
    # Exit program
    li $v0, 10
    syscall

# Function to compare strings
# $a0: Address of s1
# $a1: Address of s2
# Returns: 1 if strings are equal, 0 otherwise
compare_strings:
    li $t0, 0          # Initialize counter to 0

loop:
    lb $t1, ($a0)      # Load byte from s1
    lb $t2, ($a1)      # Load byte from s2

    # Convert characters to lowercase (if they are letters)
    andi $t3, $t1, 0xDF    # Convert s1 character to uppercase
    andi $t4, $t2, 0xDF    # Convert s2 character to uppercase

    beq $t3, $t4, check_null    # Compare uppercase characters

    # If characters are not equal, return 0
    li $v0, 0
    jr $ra

check_null:
    beq $t1, $zero, equal    # If end of s1 is reached, check if s2 is also at its end

    addi $a0, $a0, 1     # Move to next character in s1
    addi $a1, $a1, 1     # Move to next character in s2
    j loop

equal:
    # If both strings end at the same time, they are equal
    li $v0, 1
    jr $ra

.data
prompt1: .asciiz "Enter the first string: "
prompt2: .asciiz "Enter the second string: "
equal_msg: .asciiz "The strings are equal.\n"
not_equal_msg: .asciiz "The strings are not equal.\n"