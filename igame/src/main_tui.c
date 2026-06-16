#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ncurses.h>
#include "game.h"

#define INPUT_SIZE 256

void draw_main(WINDOW *win, long total, long correct, long streak, long best, 
               int hex, const char *input, int cheat, int rev, const char *answer) {
    werase(win);
    box(win, 0, 0);
    
    float pct = total > 0 ? (100.0 * correct) / total : 0.0;
    mvwprintw(win, 2, 2, "Score: %ld/%ld  Accuracy: %.1f%%  Streak: %ld  Best: %ld",
              correct, total, pct, streak, best);
    
    mvwprintw(win, 4, 2, "----------------------------------------");
    
    if (!rev) {
        wattron(win, A_BOLD | COLOR_PAIR(3));
        mvwprintw(win, 6, 2, "Hex: 0x%08X", hex);
        wattroff(win, A_BOLD | COLOR_PAIR(3));
    } else {
        wattron(win, A_BOLD | COLOR_PAIR(3));
        mvwprintw(win, 6, 10, "(display instruction)");
        wattroff(win, A_BOLD | COLOR_PAIR(3));
    }
    
    mvwprintw(win, 8, 2, "----------------------------------------");
    
    if (cheat) {
        wattron(win, COLOR_PAIR(4));
        if (!rev) {
            mvwprintw(win, 10, 2, "Cheat: %s", answer);
        } else {
            mvwprintw(win, 10, 2, "Cheat: 0x%08X", hex);
        }
        wattroff(win, COLOR_PAIR(4));
    }
    
    mvwprintw(win, 12, 2, "> %s_", input);
    
    wattron(win, COLOR_PAIR(2));
    mvwprintw(win, LINES - 3, 2, "[H] Help [R] Restart [Q] Quit");
    wattroff(win, COLOR_PAIR(2));
    
    wrefresh(win);
}

void draw_help(WINDOW *win) {
    werase(win);
    box(win, 0, 0);
    
    wattron(win, COLOR_PAIR(1) | A_BOLD);
    mvwprintw(win, 1, 14, " HELP ");
    wattroff(win, COLOR_PAIR(1) | A_BOLD);
    
    mvwprintw(win, 3, 2, "↑/↓    Navigate/Select");
    mvwprintw(win, 4, 2, "Enter  Submit answer");
    mvwprintw(win, 5, 2, "R      Restart game");
    mvwprintw(win, 6, 2, "H      Toggle help");
    mvwprintw(win, 7, 2, "Q      Quit game");
    
    wattron(win, COLOR_PAIR(2));
    mvwprintw(win, 9, 2, "Press any key to close...");
    wattroff(win, COLOR_PAIR(2));
    
    wrefresh(win);
}

void draw_result(WINDOW *win, int correct, const char *ans) {
    werase(win);
    box(win, 0, 0);
    
    if (correct) {
        wattron(win, COLOR_PAIR(2) | A_BOLD);
        mvwprintw(win, 2, 18, "CORRECT!");
        wattroff(win, COLOR_PAIR(2) | A_BOLD);
    } else {
        wattron(win, COLOR_PAIR(5) | A_BOLD);
        mvwprintw(win, 2, 18, "WRONG!");
        wattroff(win, COLOR_PAIR(5) | A_BOLD);
    }
    
    mvwprintw(win, 4, 2, "Answer: %s", ans);
    
    wattron(win, COLOR_PAIR(1));
    mvwprintw(win, 6, 2, "Press SPACE to continue...");
    wattroff(win, COLOR_PAIR(1));
    
    wrefresh(win);
}

void draw_gameover(WINDOW *win, long total, long correct, long best) {
    werase(win);
    box(win, 0, 0);
    
    float pct = total > 0 ? (100.0 * correct) / total : 0.0;
    
    wattron(win, COLOR_PAIR(1) | A_BOLD);
    mvwprintw(win, 2, 12, "===== GAME OVER =====");
    wattroff(win, COLOR_PAIR(1) | A_BOLD);
    
    mvwprintw(win, 4, 2, "Score: %ld / %ld", correct, total);
    mvwprintw(win, 5, 2, "Accuracy: %.1f%%", pct);
    mvwprintw(win, 6, 2, "Best Streak: %ld", best);
    
    const char *rating;
    if (pct >= 90) rating = "★★★★★";
    else if (pct >= 70) rating = "★★★★☆";
    else if (pct >= 50) rating = "★★★☆☆";
    else if (pct >= 30) rating = "★★☆☆☆";
    else rating = "★☆☆☆☆";
    
    wattron(win, COLOR_PAIR(2) | A_BOLD);
    mvwprintw(win, 8, 18, "%s", rating);
    wattroff(win, COLOR_PAIR(2) | A_BOLD);
    
    wattron(win, COLOR_PAIR(1));
    mvwprintw(win, 10, 2, "[R] Play Again  [Q] Quit");
    wattroff(win, COLOR_PAIR(1));
    
    wrefresh(win);
}

int main(int argc, char **argv) {
    game_init(argc, argv);
    
    initscr();
    start_color();
    init_pair(1, COLOR_CYAN, COLOR_BLACK);
    init_pair(2, COLOR_GREEN, COLOR_BLACK);
    init_pair(3, COLOR_YELLOW, COLOR_BLACK);
    init_pair(4, COLOR_MAGENTA, COLOR_BLACK);
    init_pair(5, COLOR_RED, COLOR_BLACK);
    
    curs_set(1);
    noecho();
    cbreak();
    keypad(stdscr, TRUE);
    
    long total = 0, correct = 0, streak = 0, best = 0;
    char input[INPUT_SIZE] = "";
    int input_pos = 0;
    int show_help = 0;
    int gameover = 0;
    int waiting_result = 0;
    int cur_hex = 0;
    int cleaned_up = 0;
    char answer[INPUT_SIZE] = "";
    
    instr_t instr = (!settings.seq) ? arch->rand() : arch->rand_seq();
    cur_hex = arch->get_hex(instr);
    arch->get_str(instr, answer, INPUT_SIZE);
    
    WINDOW *help_win = NULL;
    WINDOW *result_win = NULL;
    WINDOW *gameover_win = NULL;
    
    while (1) {
        if (!show_help && !waiting_result && !gameover) {
            draw_main(stdscr, total, correct, streak, best, cur_hex, input, 
                      settings.cheat, settings.rev, answer);
        }
        
        int ch = getch();
        
        if (show_help) {
            if (help_win) {
                delwin(help_win);
                help_win = NULL;
            }
            show_help = 0;
            if (ch == 'h' || ch == 'H' || ch == KEY_F(1)) {
                show_help = 1;
                help_win = newwin(12, 40, (LINES - 12) / 2, (COLS - 40) / 2);
                draw_help(help_win);
            }
            continue;
        }
        
        if (waiting_result) {
            if (ch == ' ' || ch == '\n' || ch == KEY_ENTER) {
                delwin(result_win);
                result_win = NULL;
                waiting_result = 0;
                
                if (total >= settings.limit) {
                    gameover = 1;
                    gameover_win = newwin(14, 40, (LINES - 14) / 2, (COLS - 40) / 2);
                    draw_gameover(gameover_win, total, correct, best);
                } else {
                    instr = (!settings.seq) ? arch->rand() : arch->rand_seq();
                    cur_hex = arch->get_hex(instr);
                    arch->get_str(instr, answer, INPUT_SIZE);
                    input[0] = '\0';
                    input_pos = 0;
                }
            }
            continue;
        }
        
        if (gameover) {
            if (ch == 'r' || ch == 'R') {
                total = correct = streak = best = 0;
                input[0] = '\0';
                input_pos = 0;
                gameover = 0;
                delwin(gameover_win);
                gameover_win = NULL;
                instr = (!settings.seq) ? arch->rand() : arch->rand_seq();
                cur_hex = arch->get_hex(instr);
                arch->get_str(instr, answer, INPUT_SIZE);
            } else if (ch == 'q' || ch == 'Q') {
                break;
            }
            continue;
        }
        
        switch (ch) {
            case 'h':
            case 'H':
            case KEY_F(1):
                show_help = 1;
                help_win = newwin(12, 40, (LINES - 12) / 2, (COLS - 40) / 2);
                draw_help(help_win);
                break;
            
            case 'r':
            case 'R':
                total = correct = streak = 0;
                input[0] = '\0';
                input_pos = 0;
                instr = (!settings.seq) ? arch->rand() : arch->rand_seq();
                cur_hex = arch->get_hex(instr);
                arch->get_str(instr, answer, INPUT_SIZE);
                break;
            
            case 'q':
            case 'Q':
                goto quit;
            
            case '\n':
            case KEY_ENTER:
                if (input_pos > 0) {
                    total++;
                    char guess[INPUT_SIZE];
                    strncpy(guess, input, INPUT_SIZE - 1);
                    guess[INPUT_SIZE - 1] = '\0';
                    
                    int is_correct = settings.rev ? 
                        arch->validate_hex(instr, guess) : 
                        arch->validate(instr, guess);
                    
                    if (is_correct) {
                        correct++;
                        streak++;
                        if (streak > best) best = streak;
                    } else {
                        streak = 0;
                    }
                    
                    char ans[INPUT_SIZE] = "";
                    arch->get_str(instr, ans, INPUT_SIZE);
                    
                    waiting_result = 1;
                    result_win = newwin(10, 40, (LINES - 10) / 2, (COLS - 40) / 2);
                    draw_result(result_win, is_correct, ans);
                }
                break;
            
            case KEY_BACKSPACE:
            case 127:
            case 8:
                if (input_pos > 0) {
                    input[--input_pos] = '\0';
                }
                break;
            
            case KEY_RESIZE:
                break;
            
            default:
                if (input_pos < INPUT_SIZE - 1 && ch >= 32 && ch <= 126) {
                    input[input_pos++] = ch;
                    input[input_pos] = '\0';
                }
                break;
        }
    }
    
quit:
    if (cleaned_up) return 0;
    cleaned_up = 1;
    
    if (help_win) delwin(help_win);
    if (result_win) delwin(result_win);
    if (gameover_win) delwin(gameover_win);
    
    endwin();
    game_destroy();
    
    printf("\nThanks for playing!\n");
    if (total > 0) {
        printf("Final Score: %ld / %ld (%.1f%%)\n", 
               correct, total, (100.0 * correct) / total);
    }
    
    return 0;
}
