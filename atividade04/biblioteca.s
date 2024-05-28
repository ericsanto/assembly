segment .data
    LF        EQU 0xA
    NULL      EQU 0xD
    SYS_CALL  EQU 0x80

    ;EAX
    SYS_EXIT  EQU 0x1
    SYS_READ  EQU 0x3
    SYS_WRITE EQU 0x4

    ;EBX
    RET_EXIT EQU 0x0
    STD_IN   EQU 0x0
    STD_OUT  EQU 0x1

    SIZE_BUFFER EQU 0XA

segment .bss
    BUFFER resb 0x1

segment .text



print_display:
    call lengthString
    MOV EAX, SYS_WRITE
    MOV EBX, STD_OUT
    INT SYS_CALL
    ret

lengthString:
    MOV EDX, ECX
prox_caractere:
    CMP byte[EDX], NULL
    jz finish
    INC EDX
    JMP prox_caractere

finish:
    SUB EDX, ECX
    ret
    
    
    