#include "ports.h"
#include "screen.h"

void clear_screen() {
    int length = MAX_COLS * MAX_ROWS;
    char *screen = (char *) VIDEO_ADDRESS;

    for (int i = 0; i < length; i++) {
        screen[i*2] = ' ';
        screen[i*2+1] = WHITE_ON_BLACK;
    }
}