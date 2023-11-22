TITLE   DIVISION DE 2 NUMEROS
;-------------------------
STACKSG SEGMENT 

    DW 64 DUP(0)

STACKSG ENDS 
;--------------------------
DATASG SEGMENT  PARA 'DATA'

    input Db 10,13,'Ingresa un numero: $'
   result Db 10,13,'LA Division De los Numeros Es: $'
   n1 Db ?
   n2 Db ?

DATASG ENDS
;------------------------------------------------------------------------------
CODESG  SEGMENT
START PROC FAR

    ASSUME SS:STACKSG, DS:DATASG, CS:CODESG

    MOV AX,DATASG
    MOV DS,AX
    
           ;soliCitAr Del teClADo numero 1
    
            MOV AH,09H
            LEA DX, input
            INT 21H
            
            MOV AH,01H
            INT 21H
            sub Al,30H
            
            MOV n1,Al
            
            
            MOV AH,09H
            LEA DX, input
            INT 21H
            
            MOV AH,01H
            INT 21H
            sub Al,30H
            
            MOV n2,Al
            
            ; proCeso De Division
            
            Xor AX,AX ; limpiAmos
            MOV Al,n1
            MOV Cl,n2
            
            Div Cl
            
            MOV Cl,Al ; guArDAmos en AL el resultADo De lA multipliCACion que estA en CL
            
            MOV AX,0000H ; limpiAmos y MOVemos
            MOV Al,Cl 
            
            AAM
            
            MOV CX,AX ; guArDAmos en CX De mAnerA temporAl el resultADo
            ADD CX,3030H
            
            MOV AH,09H
            LEA DX,result
            INT 21H
            
            MOV AH,02H
            MOV Dl,CH
            INT 21H
            
            MOV AH,02H
            MOV Dl,Cl
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
