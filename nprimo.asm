;hacer un programa que diga si un numero es primo o no

section .data
    msg_p db "El numero es primo", 0
    msg_np db "El numero no es primo", 0

section .bss
    num resd 1      ;  reserva 4 bytes para almacenar el número ingresado
    divisor resd 1  ; reserva 4 bytes para almacenar el divisor
section .text
    global _start
    %include "io.asm"

_start:
    call scan_num   ;llama a la funcion  scan_num de io.asm para escanear el numero desde la consola
    mov [num], eax   ;almacena el número que esta en eax en la variable num
    cmp eax, 2  ;compara el numero con 2
    jl nprimo   ;si es menor salta a nprimo
    je primo    ; si el número es 2, salta a primo
    test eax, 1     ; comprueba si es impar
    jz nprimo       ; si es par, salta a nprimo
    mov dword [divisor], 3      ; inicializa divisor en 3, para probar divisibilidad con impares

verificar_divisibilidad:
    mov ecx, [divisor] ; guarda el divisor en ecx
    mov eax, [num] ;mueve el numero guardado en num a eax
    cdq     ; extiende el signo de eax a ecx para hacer bien la división
    div ecx     ; hace eax/ecx y guarda el residuo en edx
    cmp edx, 0   ;compara el residuo con 0
    je nprimo       ; Si el residuo es 0, salta a nprimo
    add dword [divisor], 2      ; incrementar el divisor en 2 para verificar solo los números impares 
    mov eax, [divisor]      ; mueve el divisor a eax
    imul eax, eax       ; calcula la multiplicacion de divisor * divisor
    cmp eax, [num]      ;compara num con eax
    jle verificar_divisibilidad     ;si el divisor es menor o igual a num vuelve a verificar, sino sigue a la funcion primo.

primo:
    mov esi, msg_p      ;carga el msg_p a esi
    call print_str      ;llama a la funcion print_str de io.asm
    jmp fin     ;salta a fin

nprimo:
    mov esi, msg_np     ;carga el msg_np a esi
    call print_str      ;llama a la funcion print_str de io.asm y sigue a fin

fin:
    call print_newline      ;llama a la funcion print_newline de io.asm
    mov eax, 1      ; salida del sistema
    xor ebx, ebx        ; limpia ebx
    int 0x80
