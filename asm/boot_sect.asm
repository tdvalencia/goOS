;
; Boot sector that prints a string
;
[org 0x7c00]                ; Tell assembler where code will be loaded

    mov bx, HELLO_MSG       ; using bx as function parameter
    call print_string       ; this allows us to specify address of string

    mov bx, GOODBYE_MSG
    call print_string

    mov dx, 0x1fb6
    call print_hex

    jmp $

%include "asm/print_funcs.asm"

; Data
HELLO_MSG:
    db 'Hello World!', 0

GOODBYE_MSG:
    db 'Goodbye!', 0

; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55