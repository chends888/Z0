leaw $SP,%A
movw (%A),%D
decw %D
movw %D,(%A)
movw %D,%A
movw (%A),%D
decw %A
movw (%A),%A
subw %D,%A,%D
movw %D,%A
LabelTrue:
leaw $LabelTrue,%A
leaw $1,%(A)
jg
nop
LabelFalse:
leaw $LabelTrue,%A
leaw $0,(%A)
jl
nop
