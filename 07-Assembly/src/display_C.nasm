; display_C.nasm
; Exibe na tela a letra C

leaw $1984, %A
movw %A, %D
leaw $16544, %A
movw %D, (%A)

leaw $2080, %A
movw %A, %D
leaw $16576, %A
movw %D, (%A)


leaw $32, %A
movw %A, %D
leaw $16608, %A
movw %D, (%A)


leaw $32, %A
movw %A, %D
leaw $16640, %A
movw %D, (%A)


leaw $32, %A
movw %A, %D
leaw $16672, %A
movw %D, (%A)


leaw $32, %A
movw %A, %D
leaw $16704, %A
movw %D, (%A)


leaw $2080, %A
movw %A, %D
leaw $16736, %A
movw %D, (%A)


leaw $1984, %A
movw %A, %D
leaw $16768, %A
movw %D, (%A)

END:
leaw %END, %A
jmp
nop
