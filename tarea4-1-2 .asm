TITLE   SUMA DE 2 DIGITOS
;-------------------------
STACKSG SEGMENT 

    DW 64 DUP(0)

STACKSG ENDS 
;--------------------------
DATASG SEGMENT  PARA 'DATA'

   input DB 10,13,'IngresA un numero De 2 Digitos : $'
   result DB 10,13,'LA SumA De los Numeros Es: $' ; 10,13 SIGNIFICAN RETORNO/SALTO  DE LINEA EN MSDOS
   n1 DB ?
   n2 DB ?

DATASG ENDS
;------------------------------------------------------------------------------
CODESG  SEGMENT
START PROC FAR

    ASSUME SS:STACKSG, DS:DATASG, CS:CODESG

    MOV AX,DATASG
    MOV DS,AX
    
            ;SOLICITAMOS POR TECLADO EL PRIMER NUMERO
    
            MOV AH,09H  ; MUESTRA EL MENSAJE EN PANTALLA
            LEA DX, input ; CARGA EL TEXTO
            INT 21H  ; INTERRUPCION PARA QUE SE EJECUTE LA ACCION
            
            MOV AH,01H ; la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H     ; INTERRUPCION PARA QUE SE EJECUTE LA ACCION

            SUB AL,30H ; CCONVERTIR DE HEXADECIMAL A DECIMAL
            MOV BL,AL ; GUARDAMOS EN BL EL PRIMER DIGITO DEL PRIMERO NUMERO
           ;------------------------
            
            MOV AH,01H ; la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H    ; INTERRUPCION PARA QUE SE EJECUTE LA ACCION
            SUB Al,30H ; CCONVERTIR DE HEXADECIMAL A DECIMAL
            
            MOV CL,AL ; GUARDAMOS EN CL EL SEGUNDO DIGITO DEL PRIMER NUMERO


            
            ; SOLICITAMOS POR TECLADO EL SEGUNDO NUMERO
            MOV AH,09H ; MUESTRA EL MENSAJE EN PANTALLA
            LEA DX, input
            INT 21H ; INTERRUPCION PARA QUE SE EJECUTE LA ACCION
            
            MOV AH,01H  ; la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H     ; INTERRUPCION PARA QUE SE EJECUTE LA ACCION
            SUB Al,30H  ; CCONVERTIR DE HEXADECIMAL A DECIMAL

            ;operacion suma
            ADD BL,AL ; SUMAMOS LA PARTE ALTA 
            
            MOV AH,01H ; la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H     ; INTERRUPCION PARA QUE SE EJECUTE LA ACCION
            SUB AL,30H ; CCONVERTIR DE HEXADECIMAL A DECIMAL
            
            ;operacion suma
            ADD CL,AL ; SUMAMOS  LA PARTE BAJA
            
            MOV AH,09H ; VA A MOSTRAR EN PANTALLA EL RESULTADO
            LEA DX,result ; GUARDAMOS EN DX EL RESULTADO DE LA SUMA EN ESTE CASO
            INT 21H
            
            
            MOV AX,CX ; GUARDAMOS EN AX DE MANERA TEMPORTAL EL RESULTADO 
            
            ; AQUI EMPEZAMOS A REALIZAR LOS AJUSTES PARA QUE LA SUMA SEA CORRECTA DADO EL CASO QUE TENGA ACARREOS. 
            ; CONVIERTE LOS VALORES A DECIMAL
            AAM
            
            MOV CX,AX 
            
            ADD BL,CH ; REALIZAMOS LAS SUMAS DE LAS PARTES ALTAS Y BAJAS
            MOV AX,BX
            
            ; REALIZAMOS OTRO AJUSTE 
            AAM
            MOV BX,AX
            ;IMPRIME DECENAS
            MOV AH,02H
            MOV Dl,BH
            ADD Dl,30H
            INT 21H
            ;IMPRIME CENTENAS
            MOV AH,02H
            MOV Dl,Bl
            ADD Dl,30H
            INT 21H 
            ;IMPRIME UNIDADES
            MOV AH,02H
            MOV Dl,cl
            ADD Dl,30H
            INT 21H
            
            MOV AH,01H ; la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H
    CALL EXIT

EXIT PROC NEAR

    MOV AH, 4CH ;La funcion 4ch es una interrupcion de 21h que nos permite finalizar un programa
    INT 21H

EXIT ENDP
START ENDP


CODESG  ENDS
END START
