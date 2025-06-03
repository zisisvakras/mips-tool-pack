.text
.globl __start

__start:    
    la t0, WORDS
    lw a0, 0(t0)
    lw a1, 4(t0)
    
    call HammingDistance
    call PrintInt
    call Exit
    
HammingDistance:
    xor t0, a0, a1
    xor t1, t1, t1 # hamming distance
  loop:
    beqz t0, done
    
    andi t2, t0, 1
    add t1, t1, t2
    srli t0, t0, 1
    j loop
    
  done:
    mv a0, t1
    jr ra

PrintInt:
    li a7, 1
    ecall
    jr ra
    
Exit:
    li a7, 10
    ecall

.data

WORDS: .word 202, 210

