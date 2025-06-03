    .text
    .globl __start
__start:
    li s0, 20                   # number of terms to compute
    li s1, 0                    # index of current term
    la s2, fib_results
main_loop:
    mv a0, s1                   # compute fib(s1)
    jal fib_rec
    sw a1, 0(s2)                # store result in fib_results[s1]
    addi s2, s2, 4              # increment pointer to next result
    addi s1, s1, 1              # increment index
    bne s0, s1, main_loop       # loop until all terms are computed

exit:
    li a7, 10
    ecall

################################################################################

# int fib_rec(int n)
fib_rec:
    beqz a0, fib_rec_case_0
    li t0, 1
    beq a0, t0, fib_rec_case_1
  
    # The RISC-V manual says that we should try arranging code
    # such that the most common path is not reached via branching.
    # Some implementations might yield better performance this way.
  fib_rec_case_recursive:
    addi sp, sp, -12
    sw ra, 8(sp) # return address
    sw a0, 4(sp) # n
    #      0(sp) # fib(n-1) + fib(n-2) sum

    # Compute fib(n-1)
    addi a0, a0, -1
    jal fib_rec
    sw a1, 0(sp)
    
    # Compute fib(n-2)
    lw a0, 4(sp)
    addi a0, a0, -2
    jal fib_rec
    
    # Compute fib(n-1) + fib(n-2)
    lw a0, 0(sp)
    add a1, a0, a1

    lw ra, 8(sp)
    addi sp, sp, 12
    jr ra

  fib_rec_case_0:
    xor a1, a1, a1
    jr ra
    
  fib_rec_case_1:
    li a1, 1
    jr ra  

################################################################################

    .data
fib_results:   .space 160   # space for first 40 terms of fib sequence
