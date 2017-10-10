; math_determinante.nasm
; Calcula o determinante de uma matriz 2x2 (RAM[10]) e
;  salva seu resultado no endereço RAM[0]
;
; Calcula o determinante de uma matriz 2x2 da forma
; [ a0, a1 ]
; [ b0, b1 ]
;
; Salva na memória da seguinte maneira  :
; RAM[10] = a0
; RAM[11] = a1
; RAM[12] = b0
; RAM[13] = b1


LOOP:

leaw $10, %A
movw (%A), %D


leaw %END, %A
movw %D, %D
jle
nop

decw %D
leaw $10, %A
movw %D, (%A)
leaw $13, %A
movw (%A), %D
leaw $1, %A
addw (%A), %D, %D
movw %D, (%A)
leaw %LOOP, %A
jmp
nop


END:

LOOP2:

leaw $11, %A
movw (%A), %D


leaw %END2, %A
movw %D, %D
jle
nop

decw %D
leaw $11, %A
movw %D, (%A)
leaw $12, %A
movw (%A), %D
leaw $2, %A
addw (%A), %D, %D
movw %D, (%A)
leaw %LOOP2, %A
jmp
nop


END2:

leaw $2, %A
movw (%A), %D
leaw $1, %A
subw (%A), %D, %D
leaw %0, %A
movw %D, (%A)


END3:
leaw %END3, %A
jmp
nop
