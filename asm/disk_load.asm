
disk_load:
    pusha
    push dx         ; Store DX on stack so we know
                    ; how many sectors were request to be read,
                    ; even if it is altered in meantime
    mov ah, 0x02    ; BIOS read sector function call
    mov al, dh      ; Read DH sectors
    mov ch, 0x00    ; Select cylinder 0
    mov dh, 0x00    ; Select head 0
    mov cl, 0x02    ; Start reading from second sector (ie after boot sector)

    int 0x13        ; BIOS interrupt

    jc disk_error   ; Jump if error (error = carry flag set)

    pop dx          ; Restore dx from stack
    cmp al, dh      ; if AL (sectors read) != DH (sectors expected)
    jne disk_error  ;   display error message
    popa
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG db "Disk read error!",0