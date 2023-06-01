#   int fib(int n) {
#       if (n < 2) return n;
#       return fib(n - 1) + fib(n - 2);
#   }

.text
.globl main

main:
    li $a0, 10          # fib(n)
    jal fib
    move $a0, $v0       # print_int
    li $v0, 1 
    syscall
    li $v0, 10          # exit
    syscall

fib:
    slti $t0, $a0, 2    # if (n < 2) return n;
    beq $t0, $zero, fibrec
    move $v0, $a0       # return result
    jr $ra
fibrec:
    addi $sp, $sp, -8   # make space in stack
    sw $ra, 4($sp)      # keep ra and current n
    sw $a0, 0($sp)
    addi $a0, $a0, -1   # fib(n - 1)
    jal fib
    lw $a0, 0($sp) 
    addi $a0, $a0, -2   # fib(n - 2)
    sw $v0, 0($sp)      # save result of fib(n - 1) in the
                        # useless now space $a0 had
    jal fib
    lw $t0, 0($sp)
    add $v0, $t0, $v0   # add both results and return
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra