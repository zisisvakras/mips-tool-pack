# IGAME - Instruction Game

## Overview
The `igame`, or `instruction game` was created with the purpose of helping DIT students prepare for their final exam for the course "Computer Architecture I". More specifically, with an exercise that provides the hex or binary form of a code and the student must find its RISC-V assembly form. This game does exactly that - generates a random assembly command and shows the player its hex form. The player must then decode it and type the command. There are a few game variations and settings that are explained in the **Usage** section.

## Build
To play the game, you need to download this repository. Then, move to the `igame` directory and build the game using `make`.

**Dependencies:**
- `ncurses` - Required for building the TUI version
  - Debian/Ubuntu: `sudo apt-get install libncurses-dev`
  - Fedora/RHEL: `sudo dnf install ncurses-devel`
  - macOS: `brew install ncurses`

### Build Options
- `make` or `make riscv` - Build the standard CLI version
- `make tui` - Build the TUI (Terminal User Interface) version with color and menus
- `make clean` - Clean build artifacts

## Usage - Standard CLI
The standard CLI game provides the following settings, by using specific flags:

|Flag| Functionality|
|----|----|
| -a, --all  |    Include all instructions from the reference sheet|
|-c, --cheat |  Answers before questions, mr. cheater.... |
|-h, --help  |  Displays this text|
|-x, --xnames |  Use the x?? names for registers|
|-s, --seq   |   Do not repeat instructions|
|-r, --reverse | Play the reverse game|
|-l, --limit=N | Limit the game to N iterations|

Numerical values can be given in decimal, hexadecimal, octal and binary form (the last three with their respective prefixes: `0x` or `0X`, `0o` or `0O`, `0b` or `0B`).

### Demo (CLI)
```sh
$ ./igame -c
Instruction is: 0x007c6533
Please input your guess: or a0, s8, t2
Correct, my instruction was: or a0, s8, t2
Your score is: 1 / 1 (100.00%)

Instruction is: 0x00a39533
Please input your guess: sll a0, t2, a1
Wrong, my instruction was: sll a0, t2, a0
Your score is: 1 / 2 (50.00%)

Instruction is: 0xdf86e963
Please input your guess: bltu a3, s8, -2574
Correct, my instruction was: bltu a3, s8, -2574
Your score is: 2 / 3 (66.66%)

Instruction is: 0xf503e393
Please input your guess: ori t2, t2, 0xf50
Correct, my instruction was: ori t2, t2, -176
Your score is: 3 / 4 (75.00%)
```

## Usage - TUI Version
The TUI (Terminal User Interface) version provides a rich, interactive experience with:
- Color-coded feedback (green for correct, red for wrong)
- Real-time statistics and streak tracking
- Help menu with keyboard shortcuts
- Game over screen with ratings

### Running TUI
```sh
./igame-tui [OPTIONS]
```

### TUI Controls
| Key | Action |
|-----|--------|
| ENTER | Submit your answer |
| R | Restart the game |
| H | Toggle help menu |
| Q | Quit the game |
| BACKSPACE | Delete last character |

### TUI Features
- **Score Tracking**: Shows current score, accuracy percentage, and streak
- **Color Coding**: Green for correct answers, red for wrong answers
- **Star Rating**: Get 5★ (90%+), 4★ (70%+), 3★ (50%+), 2★ (30%+), or 1★ below
- **Cheat Mode**: When enabled with `-c`, shows the answer briefly before you guess
- **Best Streak**: Tracks your longest consecutive correct answer streak

### TUI Demo
```
╔══════════════════════════════════════╗
║        RISC-V INSTRUCTION GAME       ║
╠══════════════════════════════════════╣
║  Score: 5 / 7                        ║
║  Accuracy: 71.4%                     ║
║  Streak: 2                           ║
║  Best: 3                             ║
╠══════════════════════════════════════╣
║                                      ║
║    Decode this instruction:          ║
║          0x00A29533                  ║
║                                      ║
║    > add a0, s2, a1_                 ║
║                                      ║
║    [H] Help  [R] Restart  [Q] Quit   ║
╚══════════════════════════════════════╝
```