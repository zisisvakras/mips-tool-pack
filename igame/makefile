
all: riscv

HEADER_FILES := src/game.h
SRC_FILES := src/game.c src/main.c src/riscv.c

CFLAGS := -g3 -Wall -Wextra -Werror

riscv: ${SRC_FILES} ${HEADER_FILES}
	gcc ${CFLAGS} ${SRC_FILES} -o igame

val: riscv
	valgrind --leak-check=full ./igame -c