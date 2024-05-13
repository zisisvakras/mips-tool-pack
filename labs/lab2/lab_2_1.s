# Εncode a 32bit number using Grey encoding

# insert value at s0, manually from qtspim window,
# before running the program result is stored at s1

.text
.globl main

main:
    # Obtain the g_i bit sequence
    srl $t0, $s0, 1
    # Perform the encoding
    xor $s1, $s0, $t0
    # Exit
    li $v0, 10
    syscall
