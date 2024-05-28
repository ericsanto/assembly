%include "/home/ericj/assembly/atividade04/biblioteca.s"

section .data
    header db LF, "---------------", LF, "| CALCULADORA |", LF, "---------------", LF, NULL 
    title db LF, "Escolha uma das opções abaixo:", LF, NULL
    option1 db "1. Adição", LF, NULL
    option2 db "2. Subtração", LF, NULL
    option3 db "3. Multiplicação", LF, NULL
    option4 db "4. Divisão", LF, NULL
    msgAddNumber1 db LF, "Digite um número: ", LF, NULL
    msgAddNumber2 db LF, "Digite mais um número: ", LF, NULL
    msgSomar db LF, "Você escolheu a opção adicionar", LF, NULL
    msgError db LF, "Opção Inválida", LF, NULL

section .bss
    number1 resb 12
    number2 resb 12
    buffer resb 12
    option resb 12
    result resb 12

section .text

global _start

_start:

print_header:
    ;Printar Cabeçalho

    MOV EAX, 0x4
    MOV EBX, 0x1
    MOV ECX, header
    call lengthString
    INT 0x80


sum:

    ;Ler números
    MOV EAX, 0x3
    MOV EBX, 0x0
    MOV ECX, number1
    MOV EDX, 2
    INT 0x80

    MOV EAX, 0x3
    MOV EBX, 0x0
    MOV ECX, number2
    MOV EDX, 2
    INT 0x80

    ; Transformar number1 e number2 em inteiros
    MOV AL, [number1]
    SUB AL, '0'
    MOV BL, [number2]
    SUB BL, '0'

    ADD AL, BL
    MOV [result], AL

    MOVZX EAX, byte[result]
    CALL int_to_string

    ;Saída de resultado
    MOV EAX, 0x4
    MOV EBX, 0x1
    MOV ECX, buffer
    MOV EDX, 11
    INT 0x80

read_option:
    ;Ler opção
    MOV EAX, 0x3
    MOV EBX, 0x0
    MOV ECX, option
    MOV EDX, 11
    INT 0x80

    ;Transformar Opção em inteiro
    MOV AL, byte[option]
    SUB AL, '0'

    ;Comparar Opção
    MOV EAX, [option]
    CMP EAX, 1
    JE sum
    JMP exit



int_to_string:
    MOV ECX, buffer
    ADD EAX, '0'
    MOV [ECX], AL
    INC ECX
    TEST [ECX], NULL
    JE int_to_string
    

exit:
    MOV EAX, 0x1
    XOR EBX, EBX
    INT 0x80
