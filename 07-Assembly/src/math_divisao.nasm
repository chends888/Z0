; math_divisao.nasm
; Faz a divisão do valor de RAM[1]/RAM[2] e salva em RAM[0] 
; divisão para numeros inteiros positivos

leaw $1, %A
movw (%A), %D
loop:
leaw $2, %A
subw  %D, (%A), %D
leaw $0, %A
incw (%A)
leaw $loop, %A
jge
leaw $0, %A
decw (%A)
