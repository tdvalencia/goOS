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

    pusha
    mov cx, 0
 
    hex_loop:
        cmp cx, 4
        je end

        mov ax, dx
        and ax, 0x000f
        add al, 0x30
        cmp al, 0x39
        jle set_val
        add al, 7

    set_val:
        mov bx, HEX_OUT + 5
        sub bx, cx
        mov [bx], al
        ror dx, 4

        add cx, 1
        jmp hex_loop

    end:
        mov bx, HEX_OUT
        call print_string

        popa
        ret

HEX_OUT: db '0x0000', 0