%include "/home/ericj/assembly/biblioteca.inc"

segment .data
    msgInputUser db 0xA, "Digite um número para saber sua paridade", 0xA, 0
    sizeInput equ $- msgInputUser
    even db "O número é par", 0xA, 0
    sizeMsgEven equ $- even
    odd_number db "O número é ímpar", 0xA, 0
    sizeMsgOdd equ $- odd_number
   

segment .bss
    numberUser resb 3
    result resb 3

segment .text

global _start

_start:

print_msgInputUser:
    ; Bloco de código responsável pela exibição da mensagem
    MOV EAX, 0x4
    MOV EBX, 0x1
    MOV ECX, msgInputUser
    MOV EDX, sizeInput
    INT 0x80

input:
    ; Entrada do usuário
    MOV EAX, 0x3
    MOV EBX, 0x0
    MOV ECX, numberUser
    MOV EDX, 0xA
    INT 0x80

convert_string_to_int:
    ; Transformar string em inteiro
    MOV ESI, numberUser
    XOR EAX, EAX
    XOR EBX, EBX

next_digit:
    MOV AL, [ESI]
    CMP AL, 10        ; Verifica se existe um espaço em branco
    JE convert_done

    SUB AL, '0'
    IMUL EBX, 10
    ADD EBX, EAX
    INC ESI
    JMP next_digit 
    

convert_done: 
    MOV [result], EBX
    INT 0x80

even_or_odd:
    MOV EAX, [result]
    XOR EDX, EDX
    MOV EBX, 2
    DIV EBX                          ; EBX será o divisor e automaticamente, EBX é o dividendo

    CMP EDX, 0                       ; O resto da divisão sempre será em EDX
    JE print_even


odd:

    MOV EAX, 0x4
    MOV EBX, 0x1
    MOV ECX, odd_number
    MOV EDX, sizeMsgOdd
    INT 0x80
    JMP exit


print_even:
    MOV EAX, 0x4
    MOV EBX, 0x1
    MOV ECX, even
    MOV EDX, sizeMsgEven
    INT 0x80
    JMP exit
    


exit:
    MOV EAX, 0x1
    XOR EBX, EBX
    INT 0x80



