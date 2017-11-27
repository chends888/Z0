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
leaw $0 ,%A
notw %A
movw %A,%D
leaw $SP ,%A
movw (%A) ,%A
decw %A
movw %D, (%A)
leaw $LabelEnd,%A
jl
nop
LabelFalse:
leaw $0 ,%A
movw %A,%D
leaw $SP ,%A
movw (%A) ,%A
decw %A
movw %D, (%A)
leaw $LabelEnd,%A
jl
nop
leaw $0,(%A
leaw $LabelEnd,%A
je
nop
LabelEnd:
nop
