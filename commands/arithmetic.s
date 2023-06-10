# Demonstrates the usage of the most common arithmetic and logical commands in MIPS assembly language.


# Arithmetic commands

add $t0, $t1, $t2 # $t0 = $t1 + $t2
addi $t0, $t1, 100 # $t0 = $t1 + 100
addu $t0, $t1, $t2 # $t0 = $t1 + $t2  # Doesnt throw overflow exception
addiu $t0, $t1, 100 # $t0 = $t1 + 100 # Doesnt throw overflow exception

sub $t0, $t1, $t2 # $t0 = $t1 - $t2
subu $t0, $t1, $t2 # $t0 = $t1 - $t2 # Unsigned subtraction

mult $t0, $t1 # $t0 = $t0 * $t1 # Result is stored in $LO and $HI
multu $t0, $t1 # $t0 = $t0 * $t1 # Unsigned multiplication # Result is stored in $LO and $HI

mul $t0, $t1, $t2 # $t0 = $t1 * $t2 # Result is stored in $t0 if it fits in 32 bits (pseudo-instruction)

div $t0, $t1 # $t0 = $t0 / $t1 # Result is stored in $LO and $HI
# LO = $t0 / $t1 (integer division)
# HI = $t0 % $t1 (remainder)
divu $t0, $t1 # $t0 = $t0 / $t1 # Unsigned division # Result is stored in $LO and $HI

mfhi $t0 # $t0 = $HI # Move from $HI
mflo $t0 # $t0 = $LO # Move from $LO


# Logical commands

and $t0, $t1, $t2 # $t0 = $t1 & $t2
andi $t0, $t1, 100 # $t0 = $t1 & 100

or $t0, $t1, $t2 # $t0 = $t1 | $t2
ori $t0, $t1, 100 # $t0 = $t1 | 100

xor $t0, $t1, $t2 # $t0 = $t1 ^ $t2
xori $t0, $t1, 100 # $t0 = $t1 ^ 100

nor $t0, $t1, $t2 # $t0 = ~($t1 | $t2)

# Shift commands (see on shifts.s as well)

sll $t0, $t1, 2 # $t0 = $t1 << 2 # Shift left logical
srl $t0, $t1, 2 # $t0 = $t1 >> 2 # Shift right logical
sra $t0, $t1, 2 # $t0 = $t1 >> 2 # Shift right arithmetic

sllv $t0, $t1, $t2 # $t0 = $t1 << $t2 # Shift left logical variable
srlv $t0, $t1, $t2 # $t0 = $t1 >> $t2 # Shift right logical variable
srav $t0, $t1, $t2 # $t0 = $t1 >> $t2 # Shift right arithmetic variable

## CONSTANTS

# max_int_32_signed = 2^31 - 1 = 2147483647 = 2.147483647e+9 (*10^9) (10 digits)
# max_int_32_unsigned = 2^32 - 1 = 4294967295 = 4.294967295e+9 (*10^9) (10 digits)

# max_int_16_signed = 2^15 - 1 = 32767 
# max_int_16_unsigned = 2^16 - 1 = 65535



## ASCII table

# '0' = 48
# ...
# '9' = 57

# 'A' = 65
# ...
# 'Z' = 90

# 'a' = 97
# ...
# 'z' = 122

# ' ' = 32
# '\n' = 10
# '\0' = 0

## ASCII to INTeger

# $t0 = $t1 - '0'
# addi $t0, $t1, -48

# REGISTERS

# $zero = $0 = 0

# $v0-$v1 = $2-$3 = values for results and expression evaluation
# $a0-$a3 = $4-$7 = arguments

# $t0-$t7 = $8-$15 = temporaries
# $t8-$t9 = $24-$25 = temporaries
# $s0-$s7 = $16-$23 = saved

# $sp = $29 = stack pointer
# $ra = $31 = return address
