# Switch case with break
# again... this isnt really a switch case, more like if else statements...

.data 
    divisible_by_2:  .asciiz "\nDivisible by 2"
    divisible_by_5:  .asciiz "\nDivisible by 5"
    divisible_by_10: .asciiz "\nDivisible by 10"
    not_divisible:   .asciiz "\nNumber not divisible by 2, 5, nor 10" 
      
.text
    .globl __start
    
__start:
    
    li $v0, 5      
    syscall     # read int

    move $s0, $v0   # save int in s0
    
    li $v0, 1
    move $a0, $s0
    syscall         # print int
    
div_by_2:
    rem $t0, $s0, 2
    bne $t0, $zero, div_by_5    # if not divisible by 2, check 5
    
    li $v0, 4   # print string
    la $a0, divisible_by_2
    syscall
    
    la $t1, exit    # "break", go to the end
    jr $t1
    
div_by_5:
    rem $t0, $s0, 5
    bne $t0, $zero, div_by_10    # if not divisible by 5, check 10
        
    li $v0, 4   # print string
    la $a0, divisible_by_5
    syscall
    
    la $t1, exit    # "break", go to the end
    jr $t1
    
div_by_10:
    rem $t0, $s0, 10
    bne $t0, $zero, not_div    # if not divisible by 10, go to not_div
      
    li $v0, 4   # print string
    la $a0, divisible_by_10
    syscall
 
    la $t1, exit    # "break", go to the end
    jr $t1
    
 not_div:
    bne $t1, $zero, exit    # if counter is 0 go to exit
    
    li $v0, 4   # print string
    la $a0, not_divisible
    syscall
 
 exit:   
    li $v0, 10
    syscall