
all: riscv tui

HEADER_FILES := src/game.h
SRC_FILES := src/game.c src/main.c src/riscv.c
TUI_SRC_FILES := src/game.c src/main_tui.c src/riscv.c

CFLAGS := -g3 -Wall -Wextra -Werror

riscv: ${SRC_FILES} ${HEADER_FILES}
	gcc ${CFLAGS} ${SRC_FILES} -o igame

tui: ${TUI_SRC_FILES} ${HEADER_FILES}
	gcc ${CFLAGS} ${TUI_SRC_FILES} -o igame-tui -lncurses -lpanel

val: riscv
	valgrind --leak-check=full ./igame -c

clean:
	rm -f igame igame-tui