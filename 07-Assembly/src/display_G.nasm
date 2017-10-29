; display_G.nasm
; Exibe na tela a letra G

;0

leaw 32767,%A
movw %A,%D

leaw $SCREEN,%A
movw %D,(%A)

;1

leaw $32768,%A
movw %A,%D

leaw 16416,%A
movw %D,(%A)

;2

leaw $32768,%A
movw %D,%A

leaw $16448,%A
movw %D,(%A)

;3

leaw $32768,%A
movw %D,%A

leaw $16480,%A
movw %D,(%A)

;4

leaw $32768,%A
movw %D,%A

leaw $16512,%A
movw %D,(%A)

;5

leaw $32768,%A
movw %D,%A

leaw $16544,%A
movw %D,(%A)

;6

leaw $32768,%A
movw %D,%A

leaw $16576,%A
movw %D,(%A)

;7

leaw $32768,%A
movw %D,%A

leaw $16608,%A
movw %D,(%A)

;8

leaw $32768,%A
movw %D,%A

leaw $16640,%A
movw %D,(%A)

;9

leaw $32768,%A
movw %D,%A

leaw $16672,%A
movw %D,(%A)

;10

leaw $32768,%A
movw %D,%A

leaw $16704,%A
movw %D,(%A)

;11

leaw $40944,%A
movw %D,%A

leaw $16736,%A
movw %D,(%A)

;12

leaw $32784,%A
movw %D,%A

leaw $16768,%A
movw %D,(%A)

;13

leaw $32784,%A
movw %D,%A

leaw 16800,%A
movw %D,(%A)

;14

leaw $32784,%A
movw %D,%A

leaw $16832,%A
movw %D,(%A)

;15 

leaw $32784,%A
movw %D,%A

leaw $16864,%A
movw %D,(%A)

;16 

leaw $65520,%A
movw %D,%A

leaw $16896,%A
movw %D,(%A)





