# just reads and prints a float

.text
 .globl __start
__start:
li $v0, 6
syscall
mov.s $f12, $f0
li $v0, 2
syscall

li $v0,10 # exit
syscall


 .data
n: .word 25
endl: .asciiz "\n" 
