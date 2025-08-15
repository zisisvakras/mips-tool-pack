#include <stdio.h>
#include "game.h"

int main(int argc, char **argv) {
    game_init(argc, argv);
    long questc = 1, score = 0;
    for ( ; questc <= settings.limit ; ++questc) { 
        instr_t i = arch->rand();
        printf("Instruction hex is: ");
        arch->hex(i);
        printf("\n");
        if (settings.cheat) {
            printf("Here mr. cheater: ");
            arch->print(i);
            printf("\n");
        }
        printf("Please input your guess: ");
        char guess[4096];
        if (scanf(" %4095[^\n]", guess) != 1) break;
        /* Check validity */
        int correct = arch->validate(i, guess) == 0;
        score += correct;
        printf("%s, ", correct ? "Correct" : "Wrong");
        printf("my instruction was: ");
        arch->print(i);
        printf("\n");
        printf("Your score is: %ld / %ld (%.2f%%)\n\n", score, questc, (100.0 * score) / questc);
    }
    printf("\nThanks for playing\n");
    if (--questc)
        printf("Your final score is: %ld / %ld (%.2f%%)\n", score, questc, (100.0 * score) / questc);
    game_destroy();
}