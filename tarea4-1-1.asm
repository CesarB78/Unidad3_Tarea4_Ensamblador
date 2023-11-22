
TITLE   MOSTRAR EN PANTALLA NOMBRE Y NUMERO IDENTIFICACION
;-------------------------
STACKSG SEGMENT 

    DW 64 DUP(0) ;DUP es un especificador de operando específico para las instrucciones psuedo DB / DW / etc, 
					; que le indican que repitan un valor específico. Solo se puede utilizar en estas instrucciones de datos.

STACKSG ENDS 
;--------------------------
DATASG SEGMENT  PARA 'DATA'

MESG1 DB 10,13, 'Cesar Augusto Botina','$'
MESG2 DB 10,13, 'Numero ID 94521189','$'


DATASG ENDS
;------------------------------------------------------------------------------
CODESG  SEGMENT 
START PROC FAR

    ASSUME SS:STACKSG, DS:DATASG, CS:CODESG

    MOV AX,DATASG
    MOV DS,AX
    
    MOV AH,09H ; MUESTRA EL MENSAJE1 EN PANTALLA
    LEA DX , MESG1
    INT 21H ; INTERRUPCION PARA QUE SE EJECUTE LA ACCION

    MOV AH,09H ; MUESTRA EL MENSAJE2 EN PANTALLA
    LEA DX , MESG2
    INT 21H ; INTERRUPCION PARA QUE SE EJECUTE LA ACCION
EXIT PROC FAR

    MOV AH, 4CH ; la funcion 4ch es una interrupcion de 21h que nos permite finalizar un programa
    INT 21H

EXIT ENDP
START ENDP 

 CODESG  ENDS
 END START
