.text
.globl __start

.macro print_result (%str)
    la a0, %str
    jal PrintResult

.end_macro

__start:
    flw fs0, x, t0
    flw fs1, y, t0
    flw fs2, zer0, t0
    flw fs3, infp, t0
    flw fs4, infn, t0
    flw fs5, nan, t0

    # x - y
    fsub.s fa0, fs0, fs1
    print_result(x_plus_y)

    # x * y
    fmul.s fa0, fs0, fs1
    print_result(x_mul_y)

    # y / 0
    fdiv.s fa0, fs1, fs2
    print_result(y_div_z)

    # 0 / 0
    fdiv.s fa0, fs2, fs2
    print_result(z_div_z)

    # +inf / -inf
    fdiv.s fa0, fs3, fs4
    print_result(infp_div_infn)

    # +inf + (-inf)
    fadd.s fa0, fs3, fs4
    print_result(infp_plus_infn)

    # x + NaN
    fadd.s fa0, fs0, fs5
    print_result(x_plus_nan)

    j Exit

PrintResult:
    li a7, 4
    ecall
    
    la a0, equals
    li a7, 4
    ecall
    
    li a7, 2
    ecall
    
    la a0, LF
    li a7, 4
    ecall
    
    jr ra

Exit:
    li  a7, 10
    ecall

.data

x:    .float  538.7678254692
y:    .float -351.2078147140
zer0: .float 0.0
infp: .word 0x7f800000 # positive infinity
infn: .word 0xff800000 # negative infinity
nan:  .word 0x7fffffff # NaN

.asciz
x_plus_y: "x − y"
x_mul_y: "x · y"
y_div_z: "y/0"
z_div_z: "0/0"
infp_div_infn: "(+∞)/(−∞)"
infp_plus_infn: "+∞ + (−∞)"
x_plus_nan: "x + (+NaN)"

equals: " = "
LF: "\n"
