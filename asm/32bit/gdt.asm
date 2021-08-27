; GDT
gdt_start:

gdt_null:   ; mandatory null descriptor
    dd 0x0  ; 'dd' means define double word (i.e. 4 bytes)
    dd 0x0

gdt_code:   ; code segment descriptor
    ; base = 0x0, limit = 0xfffff,
    ; 1st flags: (present)1 (privilege)00 (descriptor table)1 -> 1001b
    ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10011010b    ; 1st flags, type flags
    db 11001111b    ; 2nd flags, Limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

; GDT for data segment. base and length identical to code segment
; some flags changed. refer to os-dev.pdf
gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size (16 bits), always one less of its true size
    dd gdt_start ; address (32 bit)

; define dome constants for later use
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start