section .bss
    result resd 0x8
    number resd 0x8

segment .text

global _start

_start:
    MOV EAX, 0X3
    MOV EBX, 0X0
    MOV ECX, number
    MOV EDX, 0xA
    INT 0X80

    CALL string_to_int
    MOV EDX, EBX
    XOR EBX, EBX
    MOV EBX, 1
    CALL dec
    CALL print
    CALL exit

dec:
    CMP EDX, 0x1
    JE succes
    IMUL EBX, EDX
    SUB EDX, 0x1
    JMP dec
    ret
    
exit:
    MOV EAX, 0x1
    XOR EBX, EBX
    INT 0x80

succes:
    MOV [result], EBX
    ret

print:
    MOV EAX, 0x4
    MOV EBX, 0x1
    MOV ECX, result
    MOV EDX, 0xA
    INT 0x80
    JMP exit
     
string_to_int:
    MOV ESI, number
prox_digit:
    MOV AL, byte[ESI]
    INC ESI
    CMP AL, 48
    JL .fim
    CMP AL, 57
    JG .fim
    SUB AL, 48
    IMUL EBX, 10
    ADD EBX, EAX
    JMP prox_digit
.fim:
    ret
