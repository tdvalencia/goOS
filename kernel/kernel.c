#include "../cpu/timer.h"
#include "../cpu/isr.h"
#include "../drivers/keyboard.h"

void _start() {
    isr_install();

    asm volatile("sti");
    // init_timer(50);
    init_keyboard();
}