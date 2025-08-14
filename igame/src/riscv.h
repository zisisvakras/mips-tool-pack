#ifndef RISCV_H_
#define RISCV_H_

#include <stddef.h>

typedef enum itype {
    R_INSTR,
    I_INSTR,
    SF_INSTR, // madeup, its shift
    L_INSTR,  // madeup, its load
    E_INSTR,  // madeup, its only opcode
    F_INSTR,  // fence shit
    S_INSTR,
    SB_INSTR,
    U_INSTR,
    UJ_INSTR
} itype;

typedef struct instr_t { 
    char *name;
    itype type;
    int opcode;
    int funct3;
    int funct7;
} instr_t;

#define REG_MAX_ALIAS 3
#define REG_SKIP 5

typedef struct reg_t {
    char *name[REG_MAX_ALIAS + 1];
} reg_t;

reg_t regs[] = {
    {{"x0",  "zero"}},
    {{"x1",  "ra"}},
    {{"x2",  "sp"}},
    {{"x3",  "gp"}},
    {{"x4",  "tp"}},
    {{"x5",  "t0"}},
    {{"x6",  "t1"}},
    {{"x7",  "t2"}},
    {{"x8",  "s0",  "fp"}},
    {{"x9",  "s1"}},
    {{"x10", "a0"}},
    {{"x11", "a1"}},
    {{"x12", "a2"}},
    {{"x13", "a3"}},
    {{"x14", "a4"}},
    {{"x15", "a5"}},
    {{"x16", "a6"}},
    {{"x17", "a7"}},
    {{"x18", "s2"}},
    {{"x19", "s3"}},
    {{"x20", "s4"}},
    {{"x21", "s5"}},
    {{"x22", "s6"}},
    {{"x23", "s7"}},
    {{"x24", "s8"}},
    {{"x25", "s9"}},
    {{"x26", "s10"}},
    {{"x27", "s11"}},
    {{"x28", "t3"}},
    {{"x29", "t4"}},
    {{"x30", "t5"}},
    {{"x31", "t6"}}
};

// https://github.com/zisisvakras/mips-tool-pack/blob/main/reference-sheet.pdf
instr_t instrs[] = {
    {"lb",      L_INSTR,  0x03, 0x0, 0},
    {"lh",      L_INSTR,  0x03, 0x1, 0},
    {"lw",      L_INSTR,  0x03, 0x2, 0},

    {"lbu",     L_INSTR,  0x03, 0x4, 0},
    {"lhu",     L_INSTR,  0x03, 0x5, 0},

    {"addi",    I_INSTR,  0x13, 0x0, 0},
    {"slli",    SF_INSTR, 0x13, 0x1, 0x000},
    {"slti",    I_INSTR,  0x13, 0x2, 0},
    {"sltiu",   I_INSTR,  0x13, 0x3, 0},
    {"xori",    I_INSTR,  0x13, 0x4, 0},
    {"srli",    SF_INSTR, 0x13, 0x5, 0x000},
    {"srai",    SF_INSTR, 0x13, 0x5, 0x020},
    {"ori",     I_INSTR,  0x13, 0x6, 0},
    {"andi",    I_INSTR,  0x13, 0x7, 0},

    {"sb",      S_INSTR,  0x23, 0x0, 0},
    {"sh",      S_INSTR,  0x23, 0x1, 0},
    {"sw",      S_INSTR,  0x23, 0x2, 0},

    {"add",     R_INSTR,  0x33, 0x0, 0x000},
    {"sub",     R_INSTR,  0x33, 0x0, 0x020},
    {"sll",     R_INSTR,  0x33, 0x1, 0x000},
    {"slt",     R_INSTR,  0x33, 0x2, 0x000},
    {"sltu",    R_INSTR,  0x33, 0x3, 0x000},
    {"xor",     R_INSTR,  0x33, 0x4, 0x000},
    {"srl",     R_INSTR,  0x33, 0x5, 0x000},
    {"sra",     R_INSTR,  0x33, 0x5, 0x020},
    {"or",      R_INSTR,  0x33, 0x6, 0x000},
    {"and",     R_INSTR,  0x33, 0x7, 0x000},
    {"lui",     U_INSTR,  0x37, 0,   0},

    {"beq",     SB_INSTR, 0x63, 0x0, 0},
    {"bne",     SB_INSTR, 0x63, 0x1, 0},
    {"blt",     SB_INSTR, 0x63, 0x4, 0},
    {"bge",     SB_INSTR, 0x63, 0x5, 0},
    {"bltu",    SB_INSTR, 0x63, 0x6, 0},
    {"bgeu",    SB_INSTR, 0x63, 0x7, 0},
    {"jalr",    L_INSTR,  0x67, 0x0, 0},
    {"jal",     UJ_INSTR, 0x6f, 0,   0},


    {"auipc",   U_INSTR,  0x17, 0,   0},
    {"fence",   F_INSTR,  0x0f, 0x0, 0},

    // The world is not ready for this
    // {"CSRRW",   I_INSTR,  0x73, 0x1, 0},
    // {"CSRRS",   I_INSTR,  0x73, 0x2, 0},
    // {"CSRRC",   I_INSTR,  0x73, 0x3, 0},
    // {"CSRRWI",  I_INSTR,  0x73, 0x5, 0},
    // {"CSRRSI",  I_INSTR,  0x73, 0x6, 0},
    // {"CSRRCI",  I_INSTR,  0x73, 0x7, 0},

    {"fence.i", E_INSTR,  0x0000100f, 0, 0},
    {"ecall",   E_INSTR,  0x00000073, 0, 0},
    {"ebreak",  E_INSTR,  0x00100073, 0 ,0}
};

int instrc = sizeof(instrs) / sizeof(instr_t);
int regc = sizeof(regs) / sizeof(reg_t);

/* Instruction settings */
typedef struct i_set_t {
    int req_args; /* Required arguments */
    /* Register mapping for easier validation */
    int rd;
    int rs1;
    int rs2;
    /* Print format (mnem, r0, r1, r2, imm) */
    char *fmt;
} i_set_t;

i_set_t i_sets[] = {
    [R_INSTR]  = {3, 0, 1, 2, "%1$s %2$s, %3$s, %4$s\n"},
    [I_INSTR]  = {3, 0, 1, 2, "%1$s %2$s, %3$s, %5$d\n"},
    [SF_INSTR] = {3, 0, 1, 2, "%1$s %2$s, %3$s, %5$d\n"},
    [L_INSTR]  = {2, 0, 1, 2, "%1$s %2$s, %5$d(%3$s)\n"},
    [S_INSTR]  = {2, 2, 1, 0, "%1$s %2$s, %5$d(%3$s)\n"},
    [SB_INSTR] = {3, 2, 0, 1, "%1$s %2$s, %3$s, %5$d\n"},
    [U_INSTR]  = {2, 0, 1, 2, "%1$s %2$s, %5$d\n"},
    [UJ_INSTR] = {2, 0, 1, 2, "%1$s %2$s, %5$d\n"},

    // whatever
    [F_INSTR]  = {2, 0, 1, 2, "%1$s %2$s, %3$s\n"},
    [E_INSTR]  = {0, 0, 1, 2, "%1$s\n"}
};

/* fence flags */
char *fence_f[] = {
    NULL, "w",   "r",   "rw",
    "o",  "ow",  "or",  "orw",
    "i",  "iw",  "ir",  "irw",
    "io", "iow", "ior", "iorw"
};


/* Mass validate input using posix regex */
#include <regex.h>
regex_t preg;
char *preg_pat = 
    "("
    "^[a-zA-Z.]+[ \t]+[-a-zA-Z0-9]+(,[ \t]*[-a-zA-Z0-9()]+){1,2}[ \t]*$" // 2 or more args
    ")|("
    "^[a-zA-Z.]+[ \t]*$" // 0 args
    ")";

#endif // RISCV_H_