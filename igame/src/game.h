#ifndef GAME_H_
#define GAME_H_

typedef struct game_settings {
    int cheat;
    int all;
    int xnames;
    long limit;
} game_settings;

extern game_settings settings;

int parse_args(int argc, char **argv);

#endif