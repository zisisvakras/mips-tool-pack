#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <regex.h>
#include <limits.h>
#include <errno.h>
#include "game.h"

#define iso_range(x, i, j) (((x) >> (i)) & ((1U << ((j) - (i) + 1)) - 1))

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

/* Source information for each instruction */
typedef struct instr_src_t {
    char *name;
    itype type;
    int opcode;
    int funct3;
    int funct7;
} instr_src_t;

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
instr_src_t instrs_src[] = {
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


    /* Not present in easy mode */
    #define HARD_COUNT 7;
    {"jalr",    L_INSTR,  0x67, 0x0, 0},
    {"jal",     UJ_INSTR, 0x6f, 0,   0},
    {"auipc",   U_INSTR,  0x17, 0,   0},
    {"fence",   F_INSTR,  0x0f, 0x0, 0},
    {"fence.i", E_INSTR,  0x0000100f, 0, 0},
    {"ecall",   E_INSTR,  0x00000073, 0, 0},
    {"ebreak",  E_INSTR,  0x00100073, 0, 0}
    // The world is not ready for this
    // {"csrrw",   I_INSTR,  0x73, 0x1, 0},
    // {"csrrs",   I_INSTR,  0x73, 0x2, 0},
    // {"csrrc",   I_INSTR,  0x73, 0x3, 0},
    // {"csrrwi",  I_INSTR,  0x73, 0x5, 0},
    // {"csrrsi",  I_INSTR,  0x73, 0x6, 0},
    // {"csrrci",  I_INSTR,  0x73, 0x7, 0},
};

#define TOTAL_INSTRUCTIONS (sizeof(instrs_src) / sizeof(instr_src_t))

int instrc = TOTAL_INSTRUCTIONS - HARD_COUNT;
int regc = sizeof(regs) / sizeof(reg_t);

/* Instruction settings */
typedef struct i_set_t {
    int req_args; /* Required arguments */
    /* Register mapping for easier validation */
    int rd;
    int rs1;
    int rs2;
    /* Immediate size */
    size_t immsz;
    /* Print format (mnem, r0, r1, r2, imm) */
    char *fmt;
} i_set_t;

i_set_t i_sets[] = {
    [R_INSTR]  = {3, 0, 1, 2,  0, "%1$s %2$s, %3$s, %4$s"},
    [I_INSTR]  = {3, 0, 1, 2, 12, "%1$s %2$s, %3$s, %5$d"},
    [SF_INSTR] = {3, 0, 1, 2,  6, "%1$s %2$s, %3$s, %5$d"},
    [L_INSTR]  = {2, 0, 1, 2, 12, "%1$s %2$s, %5$d(%3$s)"},
    [S_INSTR]  = {2, 2, 1, 0, 12, "%1$s %2$s, %5$d(%3$s)"},
    [SB_INSTR] = {3, 2, 0, 1, 13, "%1$s %2$s, %3$s, %5$d"},
    [U_INSTR]  = {2, 0, 1, 2, 20, "%1$s %2$s, %5$d"},
    [UJ_INSTR] = {2, 0, 1, 2, 21, "%1$s %2$s, %5$d"},

    // whatever
    [F_INSTR]  = {2, 0, 1, 2,  0, "%1$s %2$s, %3$s"},
    [E_INSTR]  = {0, 0, 1, 2,  0, "%1$s"}
};

/* fence flags */
char *fence_f[] = {
    NULL, "w",   "r",   "rw",
    "o",  "ow",  "or",  "orw",
    "i",  "iw",  "ir",  "irw",
    "io", "iow", "ior", "iorw"
};

/* Mass validate input using posix regex */
regex_t preg;
char *preg_pat =
    "("
    "^[a-zA-Z.]+[ \t]+[-a-zA-Z0-9]+(,[ \t]*[-a-zA-Z0-9()]+){1,2}[ \t]*$" // 2 or more args
    ")|("
    "^[a-zA-Z.]+[ \t]*$" // 0 args
    ")";


struct instr_t {
    instr_src_t *src; // Template
    int hex; // Actual hex of instr
    int r[3]; // According to mappings
    int imm; // Always masked and extended
    /* Print shit */
    char *n0;
    char *n1;
    char *n2;
};

/* Internal shit */

static int regcmp(int reg, char *s) {
    for (char **n = regs[reg].name; *n ; ++n)
        if (!strcasecmp(*n, s)) return 0;
    return 1;
}

static int mystrnum(char *s, size_t immsz) {
	int base = 10;
    errno = 0;
    immsz = 32 - immsz; // We only use the rest

    if (*s) {
        switch (s[1]) {
            case 'x':
            case 'X':
            base += 8;
            // fall through
            case 'o':
            case 'O':
            base += 6;
            // fall through
            case 'b':
            case 'B':
            base -= 8;
	        s += 2;
        }
    }

    int res = strtol(s, NULL, base);
    /* We wont check if input is the correct sz f this */
	return (res << immsz) >> immsz;
}


static instr_t __random(size_t idx) {
    if (idx == -1ULL) idx = rand() % instrc;
    instr_src_t isrc = instrs_src[idx];
    instr_t i = calloc(1, sizeof(*i));
    i->src = &instrs_src[idx];
    i->hex = isrc.opcode | (isrc.funct3 << 12) | (isrc.funct7 << 25);
    i->imm = rand();
    /* Initialize regs */
    int rd  = (rand() % (regc - REG_SKIP) + REG_SKIP);
    int rs1 = (rand() % (regc - REG_SKIP) + REG_SKIP);
    int rs2 = (rand() % (regc - REG_SKIP) + REG_SKIP);
    i->r[i_sets[isrc.type].rd] = rd;
    i->r[i_sets[isrc.type].rs1] = rs1;
    i->r[i_sets[isrc.type].rs2] = rs2;
    /* Registers */
    switch (isrc.type) {
        case R_INSTR:
        case I_INSTR:
        case L_INSTR:
        case SF_INSTR:
            i->hex |= (rd << 7);
            // fall through
        case S_INSTR:
        case SB_INSTR:
            i->hex |= (rs1 << 15);
            if (isrc.type == I_INSTR || isrc.type == L_INSTR)
                break;
            i->hex |= (rs2 << 20);
            break;
        case U_INSTR:
        case UJ_INSTR:
            i->hex |= (rd << 7);
            break;
        default: break;
    }
    int mask = 32 - i_sets[isrc.type].immsz;
    i->imm = (i->imm << mask) >> mask;
    if (isrc.type == SF_INSTR)
        i->imm = rs2;
    if (isrc.type == F_INSTR) {
        i->r[0] = (rand() % 15) + 1;
        i->r[1] = (rand() % 15) + 1;
        i->imm  = (i->r[0] << 4) | i->r[1];
        i->hex |= i->imm << 20;
    }
    if (isrc.type == I_INSTR || isrc.type == L_INSTR || isrc.type == U_INSTR) {
        i->hex |= (i->imm << mask);
    }
    if (isrc.type == S_INSTR) {
        i->hex |= ((i->imm & ~0x1f) << 20);
        i->hex |= ((i->imm & 0x1f) << 7);
    }
    if (isrc.type == SB_INSTR) { // fuck riscv
        i->imm &= ~1;
        int imm1 = (iso_range(i->imm, 11, 11))
                 | (iso_range(i->imm, 1, 4) << 1);
        int imm2 = (iso_range(i->imm, 5, 10))
                 | (iso_range(i->imm, 12, 12) << 6);
        i->hex |= (imm2 << 25) | (imm1 << 7);
    }
    if (isrc.type == UJ_INSTR) {
        i->imm &= ~1;
        int comb = (iso_range(i->imm, 12, 19))
                 | (iso_range(i->imm, 11, 11) << 8)
                 | (iso_range(i->imm,  1, 10) << 9)
                 | (iso_range(i->imm, 20, 20) << 19);
        i->hex |= (comb << 12);
    }

    /* Fix the print shit */
    if (isrc.type == F_INSTR) {
        i->n0 = fence_f[i->r[0]];
        i->n1 = fence_f[i->r[1]];
    } else {
        i->n0 = regs[i->r[0]].name[settings.xnames];
        i->n1 = regs[i->r[1]].name[settings.xnames];
    }
    i->n2 = regs[i->r[2]].name[settings.xnames];
    return i;
}

/* External shit */

int arch_init(void) {
    if (settings.all) instrc += HARD_COUNT;
    return regcomp(&preg, preg_pat, REG_EXTENDED);
}

instr_t seq_random_instr() {
    static size_t seq_sz;
    static size_t left[TOTAL_INSTRUCTIONS];

    if (seq_sz == 0) {
        seq_sz = instrc;
        for (size_t i = 0 ; i < seq_sz ; ++i)
            left[i] = i;
    }

    size_t seq_idx = rand() % seq_sz;
    size_t idx = left[seq_idx];
    if (seq_idx != --seq_sz)
        left[seq_idx] = left[seq_sz];

    return __random(idx);
}

instr_t random_instr() {
    return __random(-1ULL);
}

/**
 *  Returns 0 if string is not valid, 1 for success
 *  FIXME?? Irreversably corrupts input string
 */
int validate_instr(instr_t i, char *s) {
    itype type = i->src->type;
    char *iname = i->src->name;
    if (regexec(&preg, s, 0, NULL, 0)) return 0;
    if (strncasecmp(s, iname, strlen(iname))) return 0;
    s += strlen(iname);
    /* Separate args */
    char *args[4];
    args[0] = strtok(s, " \t,");
    for (int i = 1 ; i < 4 ; ++i)
        args[i] = strtok(NULL, " \t,");
    int ntok = -1;
    while (args[++ntok]);
    if (i_sets[type].req_args != ntok) return 0;

    if(i_sets[type].req_args == 0) return 1;

    /* First arg */
    if (type != F_INSTR) {
        if (regcmp(i->r[0], args[0])) return 0;
    } else if (strcasecmp(i->n0, args[0])) return 0;

    if(i_sets[type].req_args == 1) return 1;

    /* Second arg */
    char off_s[10], reg_s[10], trail[10];
    int immsz = i_sets[type].immsz;
    switch (type) {
        case S_INSTR:
        case L_INSTR:
            if (sscanf(args[1], "%9[^(](%9[^)]%2s", off_s, reg_s, trail) != 3)
                return 0;
            if (strcmp(trail, ")")) return 0;
            if (mystrnum(off_s, immsz) != i->imm || errno) return 0;
            args[1] = reg_s;
            // fall through
        case R_INSTR:
        case SF_INSTR:
        case I_INSTR:
        case SB_INSTR:
            if (regcmp(i->r[1], args[1])) return 0;
            break;
        case U_INSTR:
        case UJ_INSTR:
            if (mystrnum(args[1], immsz) != i->imm || errno) return 0;
            break;
        case F_INSTR:
            if (strcasecmp(i->n1, args[1])) return 0;
        default: break;
    }

    if(i_sets[type].req_args == 2) return 1;

    /* Third arg */
    if (type == R_INSTR) {
        if (regcmp(i->r[2], args[2])) return 0;
    } else if (mystrnum(args[2], immsz) != i->imm || errno) return 0;

    return 1;
}


/**
 *  Returns 0 if string is not valid, 1 for success
 *  FIXME?? Irreversably corrupts input string
 */
int validate_hex(instr_t i, char *s) {
    return (s = strtok(s, " \t"))
        && !strtok(NULL, " \t")
        && ((int)strtol(s, NULL, 16)) == i->hex;
}

void print_hex(instr_t i) {
    printf("0x%08x", i->hex);
}

void free_instr(instr_t i) {
    free(i);
}

void print_instr(instr_t i) {
    printf(i_sets[i->src->type].fmt, i->src->name,
                 i->n0, i->n1, i->n2, i->imm);
}

void arch_destroy(void) {
    regfree(&preg);
}

struct arch_t arch_riscv = {
    "riscv",
    &arch_init,
    &random_instr,
    &seq_random_instr,
    &validate_instr,
    &validate_hex,
    &print_hex,
    &print_instr,
    &free_instr,
    &arch_destroy
};
