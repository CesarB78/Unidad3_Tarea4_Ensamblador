TITLE   RESTA DE 2 DIGITOS
;-------------------------
STACKSG SEGMENT 

    DW 64 DUP(0)

STACKSG ENDS 
;--------------------------
DATASG SEGMENT  PARA 'DATA'

    input DB 10,13,'IngresA un numero De 2 Digitos : $'
    resuLt DB 10,13,'LA RestA De Los Numeros Es: $'
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
    
            MOV AH,09H ;MUESTRA EL MENSAJE EN PANTALLA
            LEA DX, input
            INT 21H  ;INTERRUPCION PARA QUE SE EJECUTE LA ACCION
            
            MOV AH,01H ;la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H
            SUB AL,30H ; CONVERTIR DE HEXADECIMAL A DECIMAL
            
            MOV BL,AL ; GUARDAMOS EN BL EL PRIMER DIGITO DEL PRIMERO NUMERO
           
            
            MOV AH,01H  ;la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H
            SUB AL,30H ; CONVERTIR DE HEXADECIMAL A DECIMAL
            
            MOV CL,AL ; GUARDAMOS EN CL EL SEGUNDO DIGITO DEL PRIMER NUMERO

            ;------------- SOLICITAMOS POR TECLADO EL SEGUNDO NUMERO

            MOV AH,09H ; MUESTRA EL MENSAJE EN PANTALLA
            LEA DX, input
            INT 21H ; INTERRUPCION PARA QUE SE EJECUTE LA ACCION
             
            MOV AH,01H ; la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H
            SUB AL,30H ; CONVERTIR DE HEXADECIMAL A DECIMAL

            SUB BL,AL ; RESTAMOS LA PARTE DE ARRIBA DE NUESTRO PROCESOI
            
            MOV AH,01H ; la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H
            SUB AL,30H ; CONVERTIR DE HEXADECIMAL A DECIMAL
            
            SUB CL,AL ; RESTAMOS  CON AL QUE ES LO QUE TRAEMOS DEL TECLADO
            
            MOV AH,09H ; VA A MOSTRAR EN PANTALLA EL RESULTADO
            LEA DX,resuLt 
            INT 21H
            
            
            MOV AX,CX
            
            ; AQUI EMPEZAMOS A REALIZAR LOS AJUSTES PARA QUE LA SUMA SEA CORRECTA DADO EL CASO QUE TENGA ACARREOS. 
            ; CONVIERTE LOS VALORES A DECIMAL
            AAM
            
            MOV CX,AX 
            
            SUB BL,CH ; REALIZAMOS LA RESTA DE LAS PARTES ALTAS Y BAJAS
            MOV AX,BX
            
            ; REALIZAMOS OTRO AJUSTE 
            AAM
            MOV BX,AX
            ;MOSTRAMOS EN PANTALLA → IMPRIME DECENAS
            MOV AH,02H
            MOV DL,BH
            ADD DL,30H
            INT 21H
            ;MOSTRAMOS EN PANTALLA → IMPRIME CENTENAS
            MOV AH,02H
            MOV DL,BL
            ADD DL,30H
            INT 21H 
            ;MOSTRAMOS EN PANTALLA → IMPRIME UNIDADES
            MOV AH,02H
            MOV DL,CL
            ADD DL,30H
            INT 21H
            
            MOV AH,01H
            INT 21H
    CALL EXIT

EXIT PROC NEAR

    MOV AH, 4CH ;La funcion 4ch es una interrupcion de 21h que nos permite finalizar un programa
    INT 21H

EXIT ENDP

    ENDP START


 CODESG  ENDS
 END START
