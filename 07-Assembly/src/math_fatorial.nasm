; math_fatorial.nasm
; Faz o fatorial do valor salvo em RAM[1] e salva em RAM[0].


;Copiando os valor de RAM[1] para RAM[3]
leaw $1, %A
movw (%A), %D
leaw $3, %A
movw %D, (%A)

;Realiza o loop para fatorial
LOOPFAT:
;Copiando valor RAM[3] para RAM[2]
leaw $3, %A
movw (%A), %D
leaw $2, %A
movw %D, (%A)

;Finaliza loop quando fatorial acabou
leaw %END, %A
movw %D, %D
jle
nop

decw %D
leaw $3, %A
movw %D, (%A)



LOOPMULT:


leaw $2, %A
movw (%A), %D


leaw %LOOPFAT, %A
movw %D, %D
jle
nop

decw %D
leaw $2, %A
movw %D, (%A)
leaw $1, %A
movw (%A), %D
leaw $0, %A
addw (%A), %D, %D
movw %D, (%A)
leaw %LOOPMULT, %A
jmp
nop




END:
leaw %END, %A
jmp
nop
