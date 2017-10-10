; math_multiplicacao.nasm
; Faz a multiplicação dos valore de RAM[1] e RAM[2] salvando em RAM[0].


LOOP:

leaw $1, %A
movw (%A), %D


leaw %END, %A
movw %D, %D
jle
nop

decw %D
leaw $1, %A
movw %D, (%A)
leaw $2, %A
movw (%A), %D
leaw $0, %A
addw (%A), %D, %D
movw %D, (%A)
leaw %LOOP, %A
jmp
nop


END:
leaw %END, %A
jmp
nop