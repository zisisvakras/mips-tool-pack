.data 
	str: .space 21
	str1: .asciiz " \n"
	str2: .asciiz "  \n"
	str3: .asciiz "   \n"
	str4: .asciiz "    \n"
	str5: .asciiz "     \n"
.text
	.globl main
	
main:
# read_string
la $a0, str
li $a1, 20
li $v0, 8
syscall
# print_string
li $v0, 4
syscall
# printing strings
# 1
move $s0, $a0
lb $s1, 0($s0)
sb $s1, str1 + 0
la $a0, str1
syscall
# 2
lb $s1, 1($s0)
sb $s1, str2 + 1
la $a0, str2
syscall
# 3
lb $s1, 2($s0)
sb $s1, str3 + 2
la $a0, str3
syscall
# 4
lb $s1, 3($s0)
sb $s1, str4 + 3
la $a0, str4
syscall
# 5
lb $s1, 4($s0)
sb $s1, str5 + 4
la $a0, str5
syscall

# exit
li $v0, 10
syscall
