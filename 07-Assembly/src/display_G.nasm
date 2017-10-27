; display_G.nasm
; Exibe na tela a letra G

leaw 32640,%A
movw %A,%D

leaw $SCREEN,%A
movw %D,(%A)

