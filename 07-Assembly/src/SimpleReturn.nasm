leaw $SP,%A
movw (%A),%D
decw %D
movw %D,(%A)
movw (%A),%A
movw (%A),%D
leaw $argument,%A
movw %D,(%A)
leaw $SP,%A
movw (%A),%D
decw %D
movw %D,(%A)
leaw $LCL, %A
movw (%A), %D
leaw $5, %A
movw %D, (%A)
leaw $5, %A
subw (%A), $5, %D
leaw $6, %A
movw %D, (%A)
leaw $ARG, %A
addw (%A), $1, %D
leaw %SP, %A
movw %D, (%A)
leaw $5, %A
subw (%A), $1, %D
leaw $THAT, %A
movw %D, (%A)
leaw $5, %A
subw (%A), $2, %D
leaw $THIS, %A
movw %D, (%A)
leaw $5, %A
subw (%A), $3, %D
leaw $ARG, $A
movw %D, (%A)
leaw $5, %A
subw (%A), $4, %D
leaw $LCL, %A
movw %D, (%A)
leaw $6, %A
movw (%A), %A
jmp
