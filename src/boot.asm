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
    lodsb           ;Load the byte as DS:SI into AL register and increment SI

done:
    cli
    hlt

