#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <getopt.h>
#include <limits.h>
#include <unistd.h>
#include <time.h>
#include "game.h"

#define DEFAULT_BACKEND "riscv"

game_settings settings;
extern struct arch_t arch_riscv;

static struct arch_t *_backends[] = {
    &arch_riscv,
    NULL
};

struct arch_t *arch;

void help_text(char *s);

int game_init(int argc, char **argv) {
    // Setup proper rand
    srand(time(NULL) + getpid());

    // Command arguments
    settings.xnames = 1;
    settings.limit = LONG_MAX;
    static struct option long_options[] = {
        {"cheat",   no_argument, &settings.cheat,  1}, // 'c'
        {"all",     no_argument, &settings.all,    1}, // 'a'
        {"xnames",  no_argument, &settings.xnames, 0}, // 'x'
        {"seq",     no_argument, &settings.seq,    1}, // 's'
        {"reverse", no_argument, &settings.rev,    1}, // 'r'
        {"limit",   required_argument, 0,          0}, // 'l'

        {"help",   no_argument, 0, 0}, // 'h'
        {0, 0, 0, 0}
    };
    int c, longidx;
    // opterr = 0;
    while (1) {
        c = getopt_long(argc, argv, "caxsrl:h", long_options, &longidx);
        if (c == -1) break;
        switch (c) {
            case 0: // longopt
                if (!strcmp("help", long_options[longidx].name))
                    help_text(argv[0]);
                else if (!strcmp("limit", long_options[longidx].name))
                    settings.limit = strtol(optarg, NULL, 10);
                break;
            case 'l':
                settings.limit = strtol(optarg, NULL, 10);
                break;
            case 'c':
                settings.cheat = 1;
                break;
            case 'a':
                settings.all = 1;
                break;
            case 's':
                settings.seq = 1;
                break;
            case 'r':
                settings.rev = 1;
                break;
            case 'x':
                settings.xnames = 0;
                break;
            case 'h':
                help_text(argv[0]);
                break;
            case '?':
                fprintf(stderr, "Try \'%s --help\' for more information\n", argv[0]);
                exit(1);
            default:
                fprintf(stderr, "getopt returned 0x%x\n", c);
                exit(1);
        }
    }
    if (optind != argc) {
        fprintf(stderr, "Invalid arguments\n");
        fprintf(stderr, "Try \'%s --help\' for more information\n", argv[0]);
        exit(1);
    }

    // TODO add some logic to choosing an arch
    arch = _backends[0];
    arch->init();
    return 0;
}

void game_destroy(void) {
    arch->destroy();
}

void help_text(char *s) {
    printf("Usage: %s [OPTION]...\n\n"
    "Mandatory arguments to long options are mandatory for short options too.\n"
    "Options:\n"
    "    -a, --all      Include all instructions from the reference sheet\n"
    "    -c, --cheat    Answers before questions, mr. cheater....\n"
    "    -h, --help     Displays this text\n"
    "    -x, --xnames   Use the x?? names for registers\n"
    "    -s, --seq      Do not repeat instructions\n"
    "    -r, --reverse  Play the reverse game\n"
    "    -l, --limit=N  Limit the game to N iterations\n"
    "\n", s
    );
    exit(0);
}