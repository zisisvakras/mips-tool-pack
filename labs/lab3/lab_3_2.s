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
    
loop:
    xor $t2, $s0, $s1
    andi $t2, 1     # mask to keep only least significant bit
    
    beq $t2, $zero, prepare_for_next_iteration    # if same bit continue loop
    addi $t1, 1     # if diffrent bit, increment counter    

prepare_for_next_iteration:
    srl $s0, $s0, 1
    srl $s1, $s1, 1
    addi $t0, $t0, -1
    bne $t0, $zero, loop     # while countdown isnt 0 loop
end_of_loop:
    
# print hamming distance
    li $v0, 1
    move	$a0, $t1
    syscall
    
exit:
    li $v0, 10
    syscall