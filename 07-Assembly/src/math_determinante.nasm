; math_somaMatriz.nasm
; Faz a soma de duas matrizes 2x2 (RAM[1000] e RAM[1010]) e salva seu resultado
;  no endereço RAM[0]
;
; Calcula o determinante de uma matriz 3x3 da forma
; A = [ a00, a01 ] 
;     [ a10, a11 ]
;
; B = [ b00, b01 ] 
;     [ b10, b11 ]
;
; Salva na memória da seguinte maneira  :
; RAM[1000] = a00
; RAM[1001] = a01
; RAM[1002] = a10
; RAM[1003] = a11
;
; RAM[1010] = b00
; RAM[1011] = b01
; ....
;
; E salva o resultado em no endereço RAM[0]
;
;
;  C = A + B
;
; RAM[0] = c00
; RAM[1] = c01
; ....




