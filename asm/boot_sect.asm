; Read sectors form the boot disk using disk_read
[org 0x7c00]
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call switch_to_pm

    jmp $

%include "asm/16bit/print_funcs.asm"
%include "asm/32bit/gdt.asm"
%include "asm/32bit/print.asm"
%include "asm/32bit/switch.asm"

[bits 32]
BEGIN_PM: ; after switch we get here
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    
    jmp $

MSG_REAL_MODE db 'Started in 16-bit real mode',0
MSG_PROT_MODE db 'Loaded 32-bit protected mode',0

; bootsector
times 510 - ($-$$) db 0
dw 0xaa55
