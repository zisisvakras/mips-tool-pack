#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <time.h>
#include "game.h"
#include "riscv.h"

#define iso_range(x, i, j) (((x) >> (i)) & ((1U << ((j) - (i) + 1)) - 1))

// #define DEBUG
#ifdef DEBUG
#define dbg(x) printf((x));
#else
#define dbg(x)
#endif

// TODO work for every base
int mystrnum(char *s) {
    return atoi(s);
}

int regcmp(int reg, char *s) {
    for (char **n = regs[reg].name; *n ; ++n)
        if (!strcasecmp(*n, s)) return 0;
    return 1;
}

int main(int argc, char **argv) {
    parse_args(argc, argv);
    if (settings.all) instrc += HARD_COUNT;
    srand(time(NULL) + getpid());
    if (regcomp(&preg, preg_pat, REG_EXTENDED)) return 1;
    long questc = 1, score = 0;
    for ( ; questc <= settings.limit ; ++questc) { 
        int iidx = rand() % instrc, correct = 0;
        instr_t i = instrs[iidx];
        // if (i.type != F_INSTR) continue;
        int hex = i.opcode | (i.funct3 << 12) | (i.funct7 << 25);
        int rd  = (rand() % (regc - REG_SKIP) + REG_SKIP);
        int rs1 = (rand() % (regc - REG_SKIP) + REG_SKIP);
        int rs2 = (rand() % (regc - REG_SKIP) + REG_SKIP);
        int imm = rand(), r[3];
        // Setup better regs
        r[i_sets[i.type].rd] = rd;
        r[i_sets[i.type].rs1] = rs1;
        r[i_sets[i.type].rs2] = rs2;
        // Registers
        switch (i.type) {
            case R_INSTR:
            case I_INSTR:
            case L_INSTR:
            case SF_INSTR:
                hex |= (rd << 7);
            case S_INSTR:
            case SB_INSTR:
                hex |= (rs1 << 15);
                if (i.type == I_INSTR || i.type == L_INSTR)
                    break;
                hex |= (rs2 << 20);
                break;
            case U_INSTR:
            case UJ_INSTR:
                hex |= (rd << 7);
        }
        if (i.type == SF_INSTR)
            imm = rs2;
        if (i.type == F_INSTR) {
            r[0] = (rand() % 15) + 1;
            r[1] = (rand() % 15) + 1;
            hex |= (imm = (r[0] << 4) | r[1]) << 20;
        }
        if (i.type == I_INSTR || i.type == L_INSTR) {
            imm = (imm << 20) >> 20; // mask, extend
            hex |= (imm << 20);
        }
        if (i.type == U_INSTR) {
            imm = (imm << 12) >> 12; // mask, extend
            hex |= (imm << 12);
        }
        if (i.type == S_INSTR) {
            imm = (imm << 20) >> 20; // mask, extend
            hex |= ((imm & ~0x1f) << 20);
            hex |= ((imm & 0x1f) << 7);
        }
        if (i.type == SB_INSTR) { // fuck riscv
            imm = (imm << 21) >> 20; // mask, extend
            int imm1 = (iso_range(imm, 11, 11))
                     | (iso_range(imm, 1, 4) << 1);
            int imm2 = (iso_range(imm, 5, 10))
                     | (iso_range(imm, 12, 12) << 6);
            hex |= (imm2 << 25) | (imm1 << 7);
        }
        if (i.type == UJ_INSTR) {
            imm = (imm << 13) >> 12; // mask, extend
            int comb = (iso_range(imm, 12, 19))
                     | (iso_range(imm, 11, 11) << 8)
                     | (iso_range(imm, 1, 10) << 9)
                     | (iso_range(imm, 20, 20) << 19);
            hex |= (comb << 12);
        }
        // Print phase
        printf("Instruction hex is: %08x\n", hex);
        char *n0 = i.type == F_INSTR ? fence_f[r[0]] : regs[r[0]].name[settings.xnames];
        char *n1 = i.type == F_INSTR ? fence_f[r[1]] : regs[r[1]].name[settings.xnames];
        char *n2 = regs[r[2]].name[settings.xnames];
        if (settings.cheat) {
            printf("Here mr. cheater: ");
            printf(i_sets[i.type].fmt, i.name, n0, n1, n2, imm);
        }
        printf("Please input your guess: ");
        char guess[4096], *args[4];
        if (scanf(" %4095[^\n]", guess) != 1) break;
        /* Check validity */
        char *q = guess;
        if (regexec(&preg, q, 0, NULL, 0)) goto next;
        if (strncasecmp(q, i.name, strlen(i.name))) goto next;
        q += strlen(i.name);
        /* Check for proper format */
        if (!isspace(*q) && i.type != E_INSTR) goto next; // redundant?
        args[0] = strtok(q, " \t,");
        for (int i = 1 ; i < 4 ; ++i)
            args[i] = strtok(NULL, " \t,");
        int ntok = -1;
        while (args[++ntok]);
        if (i_sets[i.type].req_args != ntok) goto next;

        /* Barrier macro */
        #define barrier(x) do{if(i_sets[i.type].req_args==(x))goto correct;}while(0);

        barrier(0);

        /* First arg */
        dbg("2\n");
        if (i.type != F_INSTR) {
            if (regcmp(r[0], args[0])) goto next;
        } else if (strcasecmp(n0, args[0])) goto next;

        barrier(1);

        /* Second arg */
        dbg("3\n");
        char off_s[10], reg_s[10], trail[10];
        switch (i.type) {
            case S_INSTR:
            case L_INSTR:
                if (sscanf(args[1], "%9[^(](%9[^)]%2s", off_s, reg_s, trail) != 3) 
                    goto next;
                if (strcmp(trail, ")")) goto next;
                if (mystrnum(off_s) != imm) goto next;
                args[1] = reg_s;
            case R_INSTR:
            case SF_INSTR:
            case I_INSTR:
            case SB_INSTR:
                if (regcmp(r[1], args[1])) goto next;
                break;
            case U_INSTR:
            case UJ_INSTR:
                if (mystrnum(args[1]) != imm) goto next;
                break;
            case F_INSTR:
                if (strcasecmp(n1, args[1])) goto next;
        }

        barrier(2);

        /* Third arg */
        dbg("4\n");
        if (i.type == R_INSTR) {
            if (regcmp(r[2], args[2])) goto next;
        } else if (mystrnum(args[2]) != imm) goto next;

        correct:;
        correct = 1;
        ++score;
        next:;
        printf("%s, ", correct ? "Correct" : "Wrong");
        printf("my instruction was: ");
        printf(i_sets[i.type].fmt, i.name, n0, n1, n2, imm);
        printf("Your score is: %ld / %ld (%.2f%%)\n\n", score, questc, (100.0 * score) / questc);
    }
    printf("\nThanks for playing\n");
    if (--questc)
        printf("Your final score is: %ld / %ld (%.2f%%)\n", score, questc, (100.0 * score) / questc);
}