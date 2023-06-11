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
msg1: .asciiz "! is :"
endl: .asciiz "\n" 
