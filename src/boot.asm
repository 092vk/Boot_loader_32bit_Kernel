[BITS 16]           ;Set the mode to 16bit
[ORG 0x7c00]        ;Set the origin address to 0x7c00 , typical for boot loaders


start:
    cli             ;Clear interrupts, disabling all maskable interrupts            
    mov ax, 0x00    ;Load immediate value 0x00 into register AX(accumulator register)
    mov ds, ax      ;Set data segment register to 0x00
    mov es, ax      ;Set extraa segment register to 0x00
    mov ss, ax      ;Set stack segment to 0x00
    mov sp, 0x7c00  ;Set stack pointer to 0x7c00 , top of the bootloader segment
    mov si, msg     ;load the address of msg into source index SI register
    sti             ;Enable the interrupts which were disabled

print:
    lodsb         ; Load byte at DS:SI into AL register and increment SI
    cmp al, 0     ; Compare the value in AL with 0 (null terminator)
    je done       ; Jump to 'done' label if zero (end of string)
    mov ah, 0x0E  ; Set AH register to 0x0E (BIOS teletype output function)
    int 0x10      ; Call BIOS interrupt 0x10 for teletype output
    jmp print     ; Jump back to 'print' label to process next character

done:
    cli
    hlt

msg: db 'Hello World!', 0 ; Define the message 'Hello World!' followed by a null terminator

times 510 - ($ - $$) db 0 ; Fill the rest of the boot sector with zeros up to 510 bytes

dw 0xAA55        ; Boot sector signature, required to make the disk bootable