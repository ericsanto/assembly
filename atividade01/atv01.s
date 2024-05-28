segment .data

    ;EAX
    SYS_EXIT equ 0x1
    SYS_READ equ 0x3
    SYS_WRITE equ 0x4

    ;EBX
    STD_OUT equ 0X1
    STD_IN equ 0x0
    RET_EXIT equ 0x0

section .data
    message db "ESCREVA SEU NOME: "
    size_message equ $- message
    welcome db "Seja bem-vindo, "
    size_of_welcome equ $- welcome

section .bss
    name resb 1

section .text

global _start

_start:
    MOV EAX, SYS_WRITE
    MOV EBX, STD_OUT
    MOV ECX, message
    MOV EDX, size_message
    INT 0x80

    MOV EAX, SYS_READ
    MOV EBX, STD_IN
    MOV ECX, name
    MOV EDX, 0xF
    INT 0x80

    MOV EAX, SYS_WRITE
    MOV EBX, STD_OUT
    MOV ECX, welcome
    MOV EDX, size_of_welcome
    INT 0x80

    MOV EAX, SYS_WRITE
    MOV EBX, STD_OUT
    MOV ECX, name
    MOV EDX, 0XF
    INT 0x80

exit:
    MOV EAX, SYS_EXIT
    MOV EBX, RET_EXIT
    INT 0x80
