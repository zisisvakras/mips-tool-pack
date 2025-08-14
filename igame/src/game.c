#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
#include "game.h"

game_settings settings;

int parse_args(int argc, char **argv) {
    static struct option long_options[] = {
        {"cheat", no_argument, &settings.cheat, 1}, // 'c'
        {"all",   no_argument, &settings.all,   1}, // 'a'
        {0, 0, 0, 0}
    };
    int c;
    while (1) {
        c = getopt_long(argc, argv, "ca", long_options, NULL);
        if (c == -1) break;
        switch (c) {
            case 0: // longopt
                break;
            case 'c':
                settings.cheat = 1;
                break;
            case 'a':
                settings.all = 1;
                break;
            case '?':
                fprintf(stderr, "Unknown option %s\n", argv[optind]);
                exit(1);   
            default:
                fprintf(stderr, "getopt returned 0x%x\n", c);
                exit(1);
        }
    }
}