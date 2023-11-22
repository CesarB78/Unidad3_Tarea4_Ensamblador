TITLE   MULTIPLICACION DE 2 NUMEROS
;-------------------------
STACKSG SEGMENT 

    DW 64 DUP(0)

STACKSG ENDS 
;--------------------------
DATASG SEGMENT  PARA 'DATA'

    input Db 10,13,'Ingresa un numero : $'
   resuLt Db 10,13,'LA MULtipLiCACion De Los Numeros Es: $'
   n1 Db ?
   n2 Db ?

DATASG ENDS
;------------------------------------------------------------------------------
CODESG  SEGMENT
START PROC FAR

    ASSUME SS:STACKSG, DS:DATASG, CS:CODESG

    MOV AX,DATASG
    MOV DS,AX
    
            ;soLiCitAr DeL teCLADo numero 1
    
            MOV AH,09H
            LEA DX, input
            INT 21H
            
            MOV AH,01H ;la funcion 01H   Lee un caracter del teclado y desplegarlo.
            INT 21H
            SUB AL,30H
            
            MOV n1,AL ; MOVEMOS A n1 LO QUE TIENE AL
            
            ;soLiCitAr DeL teCLADo numero 2
            MOV AH,09H
            LEA DX, input
            INT 21H
            
            MOV AH,01H
            INT 21H
            SUB AL,30H
            
            MOV n2,AL
            
            ; proCeso De MULtipLiCACion
            
            MOV AL,n1
            MOV CL,n2
            
            MUL CL ; MULTIPLICACION DE AL * CL 
            
            MOV CL,AL ; guArDAmos en AL eL resuLtADo De LA MULtipLiCACion que estA en CL
            
            MOV AX,0000H ; LimpiAmos y MOVemos
            MOV AL,CL 
            
            AAM
            
            MOV CX,AX ; guArDAmos en CX De mAnerA temporAL eL resuLtADo
            ADD CX,3030H ;  ajustes ASCII centenas 
            
            MOV AH,09H
            LEA DX,resuLt
            INT 21H
            
            MOV AH,02H
            MOV DL,CH
            INT 21H
            
            MOV AH,02H
            MOV DL,CL
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
