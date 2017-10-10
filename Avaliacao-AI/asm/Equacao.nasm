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

MUL:                   ; while(True):
  leaw %R3,%A          ;  
  movw (%A),%D         ;     D = t
  leaw %END,%A         ; 
  movw %D,%D           ; 
  jle                  ;     if(D<=0):   
  nop                  ;       break
  decw %D              ;     D = D-1
  leaw %R3,%A          ;     
  movw %D,(%A)         ;     t = D
  leaw %R2,%A          ;     
  movw (%A),%D         ;     D = K
  leaw %R0,%A          ;     
  addw (%A),%D,%D      ;     D = D + R0
  movw %D,(%A)         ;     R0= D
  leaw %MUL,%A         ;
  jmp                  ; 
  nop
END:                   ; while(True):
   leaw $END,%A        ;     nop
   jmp                 ;
   nop                 ;
