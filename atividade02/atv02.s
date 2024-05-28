;COMPARAR VALORES A PARTIR DA ENTRADA DE USUÁRIOS

segment .data
    SYS_CALL equ 0x80
    LF equ 0xA

    ;EAX
    SYS_EXIT equ 0x1
    SYS_READ equ 0x3
    SYS_WRITE equ 0x4

    ;EBX
    RET_EXIT equ 0x0
    STD_IN equ 0x0
    STD_OUT equ 0x1

section .data
    message_input_first_number db "Digite um número: ",
    size_of_message_input_first_number equ $- message_input_first_number
    message_input_second_number db "Digite outro número: ",
    size_of_message_input_second_number equ $- message_input_second_number
    
    message_first_number_than_second_number db "O primeiro número digitado é maior que o segundo"
    size_of_message_first_number_than_second_number equ $- message_first_number_than_second_number
    message_second_number_than_first_number db "O segundo número digitado é maior que o primeiro"
    size_of_message_second_number_than_fist_number equ $- message_second_number_than_first_number

section .bss
    first_number resb 4
    second_number resb 4
    buffer resb 4

section .text

global _start

_start:
    MOV EAX, SYS_WRITE
    MOV EBX, STD_OUT
    MOV ECX, message_input_first_number
    MOV EDX, size_of_message_input_first_number
    INT SYS_CALL

    MOV EAX, SYS_READ
    MOV EBX, STD_IN
    MOV ECX, buffer
    MOV EDX, 4
    INT SYS_CALL

    ;CONVERTER O NÚMERO
    MOV EAX, [buffer]
    SUB EAX, '0'
    MOV [first_number], EAX

    MOV EAX, SYS_WRITE
    MOV EBX, STD_OUT
    MOV ECX, message_input_second_number
    MOV EDX, size_of_message_input_second_number
    INT SYS_CALL

    MOV EAX, SYS_READ
    MOV EBX, STD_IN
    MOV ECX, buffer
    MOV EDX, 4
    INT SYS_CALL

    MOV EAX, [buffer]
    SUB EAX, '0'
    MOV [second_number], EAX

    ;COMPARAR VALORES

    MOV EAX, DWORD[first_number]
    MOV EBX, DWORD[second_number]

    CMP EAX, EBX
    JL than

    MOV ECX, message_first_number_than_second_number
    MOV EDX, size_of_message_first_number_than_second_number
   
    JMP finnaly

than:
    MOV ECX, message_second_number_than_first_number
    MOV EDX, size_of_message_second_number_than_fist_number

finnaly:
    MOV EAX, SYS_WRITE
    MOV EBX, STD_IN
    INT SYS_CALL

exit:
    MOV EAX, SYS_EXIT
    MOV EBX, RET_EXIT
    INT SYS_CALL