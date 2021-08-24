;
; Print functions
;

print_string:
    mov ah, 0x0e        ; int=0x10 && ah=0x0e -> BIOS tele-type output
    write:
        mov al, [bx]    ; gets first character of string
        int 0x10        ; print character in al
        
        inc bx          ; moves to next character in string

        cmp al, 0       ; checks if string has ended
        jne write       ; if not loop again
    ret

print_hex:

    HEX_OUT: db '0x0000', 0
    mov cx, 2
 
    ; TODO: manipulate chars at HEX_OUT to reflect dx
    ; passing 0x1fb6
    ; AND and SHR kw prob help with dealing with the bits

    char_loop:
        and dx, 0xf

        cmp dl, 0xa
        jl set_val
        add dl, 7
        add [HEX_OUT+cx], byte dl

        mov bx, HEX_OUT
        call print_string
        ret

    set_val:
        add [HEX_OUT+cx], byte dl
        inc cx
        shr dx, 1
