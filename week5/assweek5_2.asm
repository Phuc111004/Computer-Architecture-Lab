#Laboratory Exercise 5, Assignment 2
.data
str1: .asciiz "The sum of "
str2: .asciiz " and "
str3: .asciiz " is "
.text
li $s0, 6 # number1 = 6
li $s1, 9 # number2 = 9
add $t0, $s0, $s1 # $t0 = Sum of 6 and 9
# Print string "str1"
li $v0, 4
la $a0, str1
syscall
# Print $s0
li $v0, 1
move $a0, $s0
syscall
# Print string "str2"
li $v0, 4
la $a0, str2
syscall
# Print $s1
li $v0, 1
move $a0, $s1
syscall# Print string "str3"
li $v0, 4
la $a0, str3
syscall
# Print $t0
li $v0, 1
move $a0, $t0
syscall
Exit: li $v0, 10
syscall