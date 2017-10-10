; math_divisao.nasm
; Faz a divisão do valor de RAM[1]/RAM[2] e salva em RAM[0] 
; divisão para numeros inteiros positivos

leaw $0, %A
movw (%A), %D
loop:
leaw $1, %A
subw  %D, (%A), %D
leaw $2, %A
incw (%A)
leaw $loop, %A
jge
leaw $2, %A
decw (%A)

