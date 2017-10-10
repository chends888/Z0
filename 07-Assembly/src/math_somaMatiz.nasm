; Abs.nasm
; Copia o valor de RAM[1] para RAM[0] deixando o valor sempre positivo.

;MAIN: 
;  leaw %R1,%A    ; A <= 1
;  movw (%A),%D  ; D <= RAM[1]
;  leaw %DPOS,%A ; A <= DPOS
;  movw %D,%D    ; D <= D (ALU verifica D)
;  jg            ; if(D <= 0) :
;  nop
;  negw %D       ;    D <= -D

;DPOS:
;  leaw %R0,A     ; A      <= 0
;  movw %D,(%A)  ; RAM[A] <= D

;LOOP:           ; LOOP
;  leaw %LOOP,%A
;  jmp
;  nop


