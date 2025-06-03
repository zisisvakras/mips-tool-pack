.text
.globl __start

__start:
    la s0, results

    la t0, x
    la t1, y

    lw t0, (t0)
    lw t1, (t1)

    mul a0, t0, t1
    jal .write_result
    
    mulh a0, t0, t1
    jal .write_result
    
    mulhsu a0, t0, t1
    jal .write_result
    
    mulhu a0, t0, t1
    jal .write_result

    j Exit

  .write_result:
    sw a0, (s0)
    addi s0, s0, 4
    jr ra

Exit:
    li a7, 10
    ecall

.data
x: .word 0x42010001
y: .word 0x0002000f

results:
mul:    .word 0
mulh:   .word 0
mulhu:  .word 0
mulhsu: .word 0
