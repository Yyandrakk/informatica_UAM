.386
DATA SEGMENT ; Segmento de datos 
DATA ENDS
_PRACT3C SEGMENT BYTE PUBLIC 'CODE' 
ASSUME CS: _PRACT3C, DS:DATA

; =============== Convertir cadena a numero ===============
; Parametros
; SI: OFFSET DE LA CADENA
; Retorna
; EAX: DONDE SE GUARDA EL NUMERO FINAL
;===========================================================
atoi proc 
	MOV EBX, 0   ;EBX,EAX,ECX,EDX = 0
	MOV EAX, 0
	MOV ECX, 10
atoi_1:
	movzx EBX,BYTE PTR [SI]
	cmp EBX,'0'  
    jb noascii  ;CUANDO NO ES EL ASCII DE UN NUMERO SALE
    cmp EBX,'9'
    ja noascii  ;CUANDO NO ES EL ASCII DE UN NUMERO SALE
	
	mul ECX;MULTIPLICO EAX POR 10
	sub EBX,30h ;RESTO PARA OBTENER EL NUMERO DEL ASCII
	ADD EAX, ECX;SE LO SUMO A 
	INC SI
	JMP atoi_1
noascii:
	ret
atoi endp
;3.- void calculaLetraDNI(char* inStr, char* letra) 
PUBLIC _calculaLetraDNI
_calculaLetraDNI PROC FAR

	push di es si ds ax bx dx cx bp
	mov bp, sp
	mov si,WORD PTR[BP+36];OFFSET CADENA DE ENTRADA
	mov ds,WORD PTR[BP+38];SEGMENT CADENA DE ENTRADA
	mov di,WORD PTR[BP+40];OFFSET CADENA DE SALIDA
	mov es,WORD PTR[BP+42];SEGMENT CADENA DE SALIDA
	CALL atoi
	;MOV EAX, 0311684Dh;ESTO ERA PARA PROBAR MI DNI PERO LA DIV NO FUNCIONABA
	MOV EBX,00000017h; Cargo 23 en BX
	DIV BX; Segun el resto que quede sera la letra
	CMP DL,0 ;LA letra T es el 0
	JNE LR
	MOV BX, 'T'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H;FINAL DE CADENA EN TODOS LOS CASOS
	MOV [ES:DI],BX
	JMP salir
LR:
	CMP DL,1 ;LA letra R es el 1
	JNE LW
	MOV BX, 'R'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LW:
	CMP DL,2 ;LA letra W es el 2
	JNE LA
	MOV BX, 'W'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LA:
	CMP DL,3 ;LA letra A es el 3
	JNE LG
	MOV BX, 'A'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LG:
	CMP DL,4 ;LA letra G es el 4
	JNE LM
	MOV BX, 'G'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LM:
	CMP DL,5 ;LA letra M es el 5
	JNE LY
	MOV BX, 'M'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LY:
	CMP DL,6 ;LA letra Y es el 6
	JNE LF
	MOV BX, 'Y'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LF:
	CMP DL,7 ;LA letra F es el 7
	JNE LP
	MOV BX, 'F'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LP:
	CMP DL,8 ;LA letra P es el 8
	JNE LD
	MOV BX, 'P'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LD:
	CMP DL,9 ;LA letra D es el 9
	JNE LX
	MOV BX, 'D'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LX:
	CMP DL,10 ;LA letra X es el 10
	JNE LB
	MOV BX, 'X'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LB:
	CMP DL,11 ;LA letra B es el 11
	JNE LN
	MOV BX, 'B'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LN:
	CMP DL,12 ;LA letra N es el 12
	JNE LJ
	MOV BX, 'N'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LJ:
	CMP DL,13 ;LA letra J es el 13
	JNE LZ
	MOV BX, 'J'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LZ:
	CMP DL,14 ;LA letra Z es el 14
	JNE LS
	MOV BX, 'Z'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LS:
	CMP DL, 15;LA letra S es el 15
	JNE LQ
	MOV BX, 'S'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LQ:
	CMP DL,16 ;LA letra Q es el 16
	JNE LV
	MOV BX, 'Q'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LV:
	CMP DL,17 ;LA letra V es el 17
	JNE LH
	MOV BX, 'V'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LH:
	CMP DL,18 ;LA letra H es el 18
	JNE LL
	MOV BX, 'H'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LL:
	CMP DL,19 ;LA letra L es el 19
	JNE LC
	MOV BX, 'L'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LC:
	CMP DL,20 ;LA letra C es el 20
	JNE LK
	MOV BX, 'C'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LK:
	CMP DL,21 ;LA letra K es el 21
	JNE LTE
	MOV BX, 'K'
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
	jmp salir
LTE:
	MOV BX, 'E';LA letra E es el 22
	MOV [ES:DI],BX
	INC DI
	MOV BX, 00H
	MOV [ES:DI],BX
salir:
	pop bp cx dx bx ax ds si es di
	ret
_calculaLetraDNI ENDP
_PRACT3C ENDS
END