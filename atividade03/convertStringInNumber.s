%include "/home/ericj/assembly/biblioteca.inc"

section .bss
    string resb 4
    buffer resb 4

section .text

global _start

_start:
    MOV EAX, SYS_READ
    MOV EBX, STD_IN
    MOV ECX, buffer
    MOV EDX, 4
    INT SYS_CALL

    MOV EAX, [buffer]
    SUB EAX, '0'
    MOV [string], EAX

    MOV EAX, SYS_WRITE
    MOV EBX, STD_OUT
    MOV ECX, string
    MOV EDX, 4
    INT SYS_CALL

exit:
    MOV EAX, SYS_EXIT
    MOV EBX, RET_EXIT
    INT SYS_CALL


