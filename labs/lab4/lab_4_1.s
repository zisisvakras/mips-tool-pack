  .text    
         .globl __start  
__start:       
 
# start of main program 
  li $a0,-10    # Initialize variables 
  li $a1,-30    # 
  li $a2,120    # 
  li $a3,200    # 
 
  jal MinMax
  move $t0,$v1
  move $t1,$v0
  la $a0,max     
  li $v0,4 
  syscall      # display "Max is :" 
  move $a0,$t0     
  li $v0,1 
  syscall      # display max 
  la $a0,endl    
  li $v0,4 
  syscall      # display end of line 
  la $a0,min     
  li $v0,4 
  syscall      # display "Min is :" 
  move $a0,$t1     
  li $v0,1 
  syscall      # display min 
  la $a0,endl    
  li $v0,4 
  syscall      # display end of line 
  li $v0,10     
  syscall      # exit  
# end of main program 

MinMax: 
    addi $sp, $sp , -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    blt $a0, $a1 , A1gret
    move $v1, $a0
    move $v0, $a1
    j done1
A1gret: 
    move $v1, $a1
    move $v0, $a0
done1:

    blt $a2, $a3 , A3gret
    move $s0, $a3
    move $s1, $a2
    j done2
A3gret: 
    move $s0, $a2
    move $s1, $a3
done2:


    blt $s0, $v0 , s0less
    j done3
s0less: 
    move $v0, $s0
done3:

    bgt $s1, $v1 , v1gret
    j done4
v1gret: 
    move $v1, $s1
done4:

    

    lw $s0, 0($sp)
    lw $s1, 4($sp)
    addi $sp, $sp , 8
    jr $ra
    .data 
max:    .asciiz "Max is : " 
min:    .asciiz "Min is : " 
endl:   .asciiz "\n" 