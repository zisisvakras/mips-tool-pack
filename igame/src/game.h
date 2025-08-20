#ifndef GAME_H_
#define GAME_H_

typedef struct game_settings {
    int cheat;
    int all;
    int xnames;
    int seq;
    int rev;
    long limit;
} game_settings;

extern game_settings settings;

/* Rock defined in each arch */
typedef struct instr_t *instr_t;

struct arch_t {
    const char* name;

    /* Initialize arch, should be done on game start */
    int (*init)(void);

    /**
     *  Produce a random instruction using rand,
     *  this needs to be destroyed using free func
     */
    instr_t (*rand)(void);

    /**
     *  Produce a random instruction using rand,
     *  different instructions will be given till all
     *  instructions have been randomly given,
     *  this needs to be destroyed using free func
     */
    instr_t (*rand_seq)(void);

    /**
     *  Validate a string if it fits the instruction
     */
    int (*validate)(instr_t, char *);

    /**
     *  Validate a string if it fits the instruction hex
     */
    int (*validate_hex)(instr_t, char *);

    /* Print the instruction hex */
    void (*hex)(instr_t);

    /* Print the instruction in one line */
    void (*print)(instr_t);

    /* Free an instruction */
    void (*free)(instr_t);

    /* Destroy the arch */
    void (*destroy)(void);
};

extern struct arch_t *arch;

int game_init(int argc, char **argv);
void game_destroy(void);

#endif