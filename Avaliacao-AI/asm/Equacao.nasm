; Arquivo: Equacao.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 9/2017

; Nt = N0 + K*t
;
; R0 : Nt
; R1 : N0
; R2 : K
; R3 : t

leaw $SP,%A
leaw (%A),%A
decw %A
movw (%A),%D
leaw $TEMP,%A
movw %D,(%A)
