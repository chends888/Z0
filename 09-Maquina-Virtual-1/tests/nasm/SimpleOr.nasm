; OR
leaw $SP,%A
movw (%A),%D
decw %D
movw %D,(%A)
movw (%A),%A
movw (%A),%D
leaw $SP,%A
subw (%A),$1,%A
orw (%A),%D,%D
movw %D,(%A)
leaw $SP,%A
movw (%A),%D
incw %D
movw %D,(%A)
