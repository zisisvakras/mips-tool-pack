# calculate hamming distance of 2 words

.data
    w1: .word 0x0
    w2: .word 0xffffffff

.text
    .globl __start
    
__start:
    
    lw $s0, w1
    lw $s1, w2
    
    li $t0, 32  # countdown for how many bits weve checked
    li $t1, 0   # hamming distance counter
    
    xor $t2, $s0, $s1
loop:
    andi $t3, $t2, 1    
    add $t1, $t1, $t3
    srl $t2, $t2, 1
    bne $t2, $zero, loop     # while countdown isnt 0 loop
end_of_loop:
    
# print hamming distance
    li $v0, 1
    move	$a0, $t1
    syscall
    
exit:
    li $v0, 10
    syscall