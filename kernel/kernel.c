#include "../cpu/timer.h"
#include "../cpu/isr.h"
#include "../drivers/keyboard.h"
#include "../drivers/screen.h"

void _start() {
    isr_install();

    asm volatile("sti");
	clear_screen();
    // init_timer(50);
    init_keyboard();
}
