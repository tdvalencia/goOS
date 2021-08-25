; Read sectors form the boot disk using disk_read
[org 0x7c00]
    mov bp, 0x8000
    mov sp, bp

    mov bx, 0x9000
    mov dh, 2
    ; mov dl, [BOOT_DRIVE]
    call disk_load

    mov dx, [0x9000]
    call print_hex

    mov dx, [0x9000 + 512]
    call print_hex

    jmp $

%include "asm/lib/print_funcs.asm"
%include "asm/disk_load.asm"

; Padding and magic BIOS number
times 510 - ($-$$) db 0
dw 0xaa55

; We know BIOS will load boot sector,
; so we add a few more sectors to code
; to see if they are loaded
times 256 dw 0xdada
times 256 dw 0xface