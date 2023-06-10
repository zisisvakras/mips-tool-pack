.data
#almost_zero: .double 0.000000000000001 # 1e-15 # NOTE: TOO SLOW FOR SIMULATOR
almost_zero: .double 0.00000000001# 1e-11 

.text
.globl main

main:

li $s0, 1 # i

la $s1, almost_zero # 1e-15
l.d $f0, 0($s1)  


l.d $f2, 0($s1) # 0.0 sum

li.d $f20, 1.0 # 1.0
li.d $f22, 6.0 # 6.0


main_loop_pi:
    # current = f4
    # sum = f2
    mtc1 $s0, $f4 # i
    cvt.d.w $f4 $f4 

    mul.d $f4, $f4, $f4 # i^2
    div.d $f4, $f20, $f4 # 1/i^2

    add.d $f2, $f2, $f4 # sum += 1/i^2
    addi $s0, $s0, 1 # i++

c.lt.d $f4, $f0 # if 1/i^2 < 1e-15
bc1f main_loop_pi

mul.d $f2, $f2, $f22 
sqrt.d $f2, $f2

mov.d $f12, $f2

li $v0, 3
syscall




li $v0, 10
syscall
