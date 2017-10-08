; Max.nasm

; Calcula R2 = max(R0, R1)  (R0,R1,R2 se referem a  RAM[0],RAM[1],RAM[2])
; ou seja, o maior valor que estiver, ou em R0 ou R1 sera copiado para R2

MAIN:
   leaw $R0,%A        ; Endereca R0
   movw (%A),%D       ; D <= R0
   leaw $R1,%A        ; Endereça R1
   subw %D, (%A), %D  ; D <= D - RAM[R1]
   leaw $R0MAIOR, %A  ; Endereça R0MAIOR
   jge                ; if(D<0):
   nop                ;    
R1MAIOR:              ;     
   leaw $R1,%A        ;   Endereça R1
   movw (%A), %D      ;   D <= RAM[R1]
   leaw $SAVE,%A      ;   
   jmp                ;  
R0MAIOR:              ; else:
   leaw $R0,%A        ;   Endereça R0
   movw (%A),%D       ;   D <= RAM[0]
SAVE:                 ;
   leaw $R2,%A        ; Endereça R2
   movw %D,(%A)       ; RAM[R2] <= D
LOOP:                 ;
  leaw %LOOP,%A       ; While(1){
  jmp                 ;
  nop                 ; }
 