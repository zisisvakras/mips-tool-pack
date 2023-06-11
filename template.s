#  MESSAGES
.data
    ReadInt: .asciiz "Insert an integer :"
    ReadFloating: .asciiz "Insert a float :"
    ReadDoubleNum: .asciiz "Insert a double :"
    ReadStringCharacters: .asciiz "Insert a string :"
    Result: .asciiz "The result is :"
    Final: .asciiz "The final <type> is: "
    Difference: .asciiz "The difference is :"
    Quotient: .asciiz "The Quotient is :"
    Remainder: .asciiz "The Remainder is :"
    Factorial: .asciiz "The factorial of the number "
    General_Start: .asciiz "The "
    Power: .asciiz " th power of the number "
    General_End: .asciiz " is: "
    StringMessage: .asciiz "The final string is: "
    Converted1: .asciiz "The converted float is: "
    Converted2: .asciiz " from: "
    ProgramEnd: .asciiz "\nEND OF PROGRAM\n"
    ErrorMessages: .asciiz "The character is not a number\n"
    EqualMessage: .asciiz "The strings are equal"
    NotEqualMessage: .asciiz "The strings are not equal"
    wronginput: .asciiz "Wrong Input!"

.text
.globl main

main:
    j exit


###
#  A collection of syscalls in mips-assembly
### 

#  Prints integer given in $a0
print_int:
    li $v0, 1
    syscall
    jr $ra

#  Prints float given in $f12
#  Use "mov.s $f12, $???" to move float to reg
print_float:
    li $v0, 2
    syscall
    jr $ra

#  Prints double given in $f12
#  Use "mov.d $f12, $???" to move double to reg
#  Remember that double uses 2 registers (pair of even-odd)
print_double:
    li $v0, 3
    syscall
    jr $ra

#  Prints string given in $a0
#  Use "la $a0, label" to specify string address
print_string:
    li $v0, 4
    syscall
    jr $ra

#  Read integer from input
#  Integer will be in $v0
read_int:
    li $v0, 5
    syscall
    jr $ra

#  Read float from input
#  Float will be in $f0
read_float:
    li $v0, 6
    syscall
    jr $ra

#  Read double from input
#  Double will be in $f0 (and $f1)
#  Remember that double uses 2 registers (pair of even-odd)
read_double:
    li $v0, 7
    syscall
    jr $ra

#  Read string from input
#  $a0 will be buffer address and $a1 the length (including the space made for \0)
#  Remember that u can allocate space for a buffer in .data with .space (len)
read_string:
    li $v0, 8
    syscall
    jr $ra

# Exits the program
exit:
    li $v0, 10
    syscall

#  Prints char given in $a0
print_char:
    li $v0, 11
    syscall
    jr $ra

#  Read char from input
#  Char will be in $v0
read_char:
    li $v0, 12
    syscall
    jr $ra

#  Prints new line, overwrites $a0
print_endl:
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra

#  Returns the digit length 
#  input: $a0, digits: $v0
#  overwrites $a0, $v0, $v1
digit_count:
    li $v0, 0
    li $v1, 10
    digit_count_loop:
    div $a0, $v1
    mflo $a0
    addi $v0, $v0, 1
    bne $a0, $zero, digit_count_loop
    jr $ra

#  Returns $a0! in $v0
factorial:
    addi $sp, $sp, -4    # make space in stack
    sw $t0, 0($sp)
    move $v0, $a0
	move $t0, $a0
    bne $v0, $zero, factorialloop
    li $v0, 1            # case of 0!
    j factorialexit
    factorialloop:
    addi $t0, $t0, -1
    beq $t0, $zero, factorialexit
    mult $v0, $t0
    mflo $v0
    j factorialloop
    factorialexit:
    lw $t0, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# $a0 + $a1 = $v0
# OVF_flag = $v1
ovf_add:
    addu $v0, $a1, $a0 # sum
    xor  $v1, $v0, $a0 # w0 ^ sum
    xor  $v0, $v0, $a1 # w1 ^ sum
    # calculate ovf in $v1
    and  $v1, $v1, $v0
    addu $v0, $a1, $a0 # redo sum
    jr $ra

#  Returns $a0^$a1 in $v0
pow:
    addi $sp, $sp, -4    # make space in stack
    sw $t0, 0($sp)
    move $v0, $a0
	move $t0, $a1
    bne $v0, $zero, next
    li $v0, 0            # 0^a
    j powexit
    next:
    bne $t0, $zero, powloop
    li $v0, 1            # a^0
    j powexit
    powloop:
    addi $t0, $t0, -1
    beq $t0, $zero, powexit
    mult $v0, $a0
    mflo $v0
    j powloop
    powexit:
    lw $t0, 0($sp)
    addi $sp, $sp, 4
    jr $ra

#  Compares strings in $a0 and $a1
#  Returns 1 if equal or 0 if not in $v0
streq:
    addi $sp, $sp, -16   # make space in stack
    sw $t0, 12($sp)      # keep t0, t1, t2, t3 in stack
    sw $t1, 8($sp)
    sw $t2, 4($sp)
    sw $t3, 0($sp)
    add $t2, $a0, $zero # load byte 0 from the string in t2 (it will be our counter)
    add $t3, $a1, $zero # respectively for t3
    streqloop:
    lb $t0, 0($t2)
    lb $t1, 0($t3)
    bne $t0, $t1, streqexitno
    beq $t0, $zero, streqexityes
    addi $t2, $t2, 1
    addi $t3, $t3, 1
    j streqloop

    streqexitno:
    li $v0, 0
    j streqexit

    streqexityes:
    li $v0, 1
    j streqexit

    streqexit:
    lw $t0, 12($sp)      # restore t0, t1, t2, t3 from stack
    lw $t1, 8($sp)
    lw $t2, 4($sp)
    lw $t3, 0($sp)
    addi $sp, $sp, 16
    jr $ra

#  Compares strings in $a0 and $a1
#  Returns 1 if not equal or 0 if they are, in $v0
strneq:
    addi $sp, $sp, -16   # make space in stack
    sw $t0, 12($sp)      # keep t0, t1, t2, t3 in stack
    sw $t1, 8($sp)
    sw $t2, 4($sp)
    sw $t3, 0($sp)
    add $t2, $a0, $zero # load byte 0 from the string in t2 (it will be our counter)
    add $t3, $a1, $zero # respectively for t3
    strneqloop:
    lb $t0, 0($t2)
    lb $t1, 0($t3)
    bne $t0, $t1, strneqexitno
    beq $t0, $zero, strneqexityes
    addi $t2, $t2, 1
    addi $t3, $t3, 1
    j strneqloop

    strneqexitno:
    li $v0, 1
    j strneqexit

    strneqexityes:
    li $v0, 0
    j strneqexit

    strneqexit:
    lw $t0, 12($sp)      # restore t0, t1, t2, t3 from stack
    lw $t1, 8($sp)
    lw $t2, 4($sp)
    lw $t3, 0($sp)
    addi $sp, $sp, 16
    jr $ra

#  Calculate the length of string in $a0
#  Returns length in $v0 (without \0)
strlen:
    addi $sp, $sp, -4    # make space in stack
    sw $t0, 0($sp)       # keep t0 in stack
    addi $v0, $a0, -1
strlenloop:
    lb $t0, 1($v0)
    addi $v0, $v0, 1
    bne $t0, $zero, strlenloop
    sub $v0, $v0, $a0    # prepare return value
    lw $t0, 0($sp)       # restore t0 from stack
    addi $sp, $sp, 4
    jr $ra

# print LSB bits of a number in hex
# $a0: the number $a1: digit count (give 8 for all)
print_hex:
    addi $sp, $sp, -8
    sw  $t0, 0($sp)
    sw  $a1, 4($sp)
    sll $a1, $a1, 2
    add $t0, $a0, $zero

print_hex_loop:
    addi $a1, $a1, -4
    srlv $a0, $t0, $a1
    andi $a0, $a0, 15
    slti $v0, $a0, 10
    bne $v0, $zero, print_hex_num
    li $v0, 11
    addi $a0, $a0, 55
print_hex_num:
    syscall
    bne $a1, $zero, print_hex_loop

    add $a0, $t0, $zero
    lw  $a1, 4($sp)
    lw  $t0, 0($sp)
    jr $ra

# print LSB bits of a number in octal
# $a0: the number $a1: digit count (give 11 for all)
print_oct:
    addi $sp, $sp, -8
    sw  $t0, 0($sp)
    sw  $a1, 4($sp)
    li $t0, 3
    mul $a1, $a1, $t0
    add $t0, $a0, $zero

  print_oct_loop:
    addi $a1, $a1, -3
    srlv $a0, $t0, $a1
    andi $a0, $a0, 7
    li $v0, 1
    syscall
    bne $a1, $zero, print_oct_loop

    add $a0, $t0, $zero
    lw  $a1, 4($sp)
    lw  $t0, 0($sp)
    jr $ra

# print LSB bits of a number in binary
# $a0: the number $a1: digit count (give 32 for all)
print_bin:
    addi $sp, $sp, -8
    sw  $t0, 0($sp)
    sw  $a1, 4($sp)
    add $t0, $a0, $zero

  print_bin_loop:
    addi $a1, $a1, -1
    srlv $a0, $t0, $a1
    andi $a0, $a0, 1
    li $v0, 1
    syscall
    bne $a1, $zero, print_bin_loop

    add $a0, $t0, $zero
    lw  $a1, 4($sp)
    lw  $t0, 0($sp)
    jr $ra

# print an number in a given base
# $a0: base 
# $a1: the number to print
# returns $v0: the number of chars printed
print_val:
    addi $sp, $sp, -52  # 4 regs + 33byte string + alignment
    sw  $t0, 0($sp)     # save used regs to the stack
    sw  $t1, 4($sp)
    sw  $t2, 8($sp)
    sw  $a1, 12($sp)

    addi $t2, $sp, 51   # initialize and
    sb $zero, 0($t2)    # null terminate the string

print_val_loop:
    addi $t2, $t2, -1   # fill string in reverse
    divu $a1, $a0
    mfhi $t0
    mflo $a1
    addi $t0, $t0, 48   # add '0' to get the ascii
    slti $t1, $t0, 58   # if result is past 9
    bne $t1, $zero, print_val_num
    addi $t0, $t0, 7    # add an other 7 to get to 'A'
print_val_num:
    addi $v0, $v0, 1    # character counter
    sb $t0, 0($t2)      # store the character in the string
    bne $a1, $zero, print_val_loop
    
    add $t0, $a0, $zero # save regs before syscall
    add $t1, $v0, $zero
    li $v0, 4           # print string
    add $a0, $t2, $zero
    syscall  
    add $a0, $t0, $zero # restore saved regs
    add $v0, $t1, $zero
    lw  $a1, 12($sp)    # pop the stack
    lw  $t2, 8($sp)
    lw  $t1, 4($sp)
    lw  $t0, 0($sp)
    addi $sp, $sp, 52
    jr $ra

# repeateadly reads characters, converts it to desired base and puts result in $v0

# will contain the hex value in $v0, expects characters in CAPS
read_hex:
    addi $sp, $sp, -8
    sw  $ra, 0($sp)
    sw  $s0, 4($sp)
    add $s0, $zero, $zero
read_hex_loop:
    li $v0, 12
    syscall
    addi $v0, $v0, -48
    bltz $v0, read_hex_end
    slti $a0, $v0, 10
    bne $a0, $zero, read_hex_val
    addi $v0, $v0, -17
    bltz $v0, read_hex_end
    addi $v0, $v0, 10
    slti $a0, $v0, 16
    bne $a0, $zero, read_hex_val
read_hex_end:
    add $v0, $s0, $zero
    lw  $s0, 4($sp)
    lw  $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
read_hex_val:
    sll $s0, $s0, 4
    or $s0, $s0, $v0
    j read_hex_loop

# will contain the octal value in $v0, expects characters in CAPS
read_oct:
    addi $sp, $sp, -8
    sw  $ra, 0($sp)
    sw  $s0, 4($sp)
    add $s0, $zero, $zero
read_oct_loop:
    li $v0, 12
    syscall
    addi $v0, $v0, -48
    bltz $v0, read_oct_end
    slti $a0, $v0, 8
    bne $a0, $zero, read_oct_val
read_oct_end:
    add $v0, $s0, $zero
    lw  $s0, 4($sp)
    lw  $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
read_oct_val:
    sll $s0, $s0, 3
    or $s0, $s0, $v0
    j read_oct_loop


# will contain the binary value in $v0
read_bin:
    addi $sp, $sp, -8
    sw  $ra, 0($sp)
    sw  $s0, 4($sp)
    add $s0, $zero, $zero
read_bin_loop:
    li $v0, 12
    syscall
    addi $v0, $v0, -48
    bltz $v0, read_bin_end
    slti $a0, $v0, 2
    bne $a0, $zero, read_bin_val
read_bin_end:
    add $v0, $s0, $zero
    lw  $s0, 4($sp)
    lw  $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
read_bin_val:
    sll $s0, $s0, 1
    or $s0, $s0, $v0
    j read_bin_loop

# $a0: number base (2..16)
# $v0: output, $v1: failed flag
# Characters should be in capital, stops at the first non complian char
read_num:
    li $v1, 0
    addi $sp, $sp, -12
    sw  $a0, 0($sp)
    sw  $s0, 4($sp)
    sw  $s1, 8($sp)
    add $s0, $zero, $zero
    add $s1, $zero, $a0
read_num_loop:
    li $v0, 12
    syscall
    addi $v0, $v0, -15
    bltz $v0, read_num_end
    addi $v0, $v0, -33
    bltz $v0, read_num_error
    slti $a0, $v0, 10
    bne $a0, $zero, read_num_check
    addi $v0, $v0, -17
    bltz $v0, read_num_error
    addi $v0, $v0, 10
    slt $a0, $v0, $s1
read_num_check:
    bne $a0, $zero, read_num_val
read_num_error:
    li $v1, 1
read_num_end:
    add $v0, $s0, $zero
    add $a0, $s1, $zero
    lw  $s1, 8($sp)
    lw  $s0, 4($sp)
    lw  $a0, 0($sp)
    addi $sp, $sp, 12
    jr $ra
read_num_val:
    mul $s0, $s0, $s1
    add $s0, $s0, $v0
    j read_num_loop

# $a0: number base (2..16), $a1: the string
# $v0: output, $v1: failed flag
# Characters should be in capital, stops at the first non complian char
str_num:
    li $v1, 0
    addi $sp, $sp, -16
    sw  $a0, 0($sp)
    sw  $s0, 4($sp)
    sw  $s1, 8($sp)
    sw  $a1, 12($sp)
    add $s0, $zero, $zero
    add $s1, $zero, $a0
str_num_loop:
    lb $v0, 0($a1)
    addi $a1, $a1, 1
    addi $v0, $v0, -15
    bltz $v0, str_num_end
    addi $v0, $v0, -33
    bltz $v0, str_num_error
    slti $a0, $v0, 10
    bne $a0, $zero, str_num_check
    addi $v0, $v0, -17
    bltz $v0, str_num_error
    addi $v0, $v0, 10
    slt $a0, $v0, $s1
str_num_check:
    bne $a0, $zero, str_num_val
str_num_error:
    li $v1, 1
str_num_end:
    add $v0, $s0, $zero
    lw  $a1, 12($sp)
    lw  $s1, 8($sp)
    lw  $s0, 4($sp)
    lw  $a0, 0($sp)
    addi $sp, $sp, 16
    jr $ra
str_num_val:
    mul $s0, $s0, $s1
    add $s0, $s0, $v0
    j str_num_loop
