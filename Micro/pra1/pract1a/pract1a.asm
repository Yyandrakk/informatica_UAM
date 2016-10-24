;********** CABECERA ***********

;Nombres: Oscar Garcia de Lara Parreño y Alba de Castro Martin
;Pareja: 6

;**************************************************
; ESTRUCTURA BÁSICA DE UN PROGRAMA EN ENSAMBLADOR
;**************************************************

; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT

DATO_1 DB 46H  ;Final de direcion de memoria para la primera copia
DATO_2 DB 47H  ;Final de direcion de memoria para la segunda copia
DATO_3 DB 7H   ;Final de direcion de memoria para la tercera copia
DATOS ENDS 

;**************************************************

; DEFINICION DEL SEGMENTO DE PILA
PILA SEGMENT STACK "STACK"
	DB 40H DUP (0) ;ejemplo de inicialización, 64 bytes inicializados a 0
PILA ENDS
;**************************************************

; DEFINICION DEL SEGMENTO EXTRA
EXTRA SEGMENT
	RESULT DW 0,0 ;ejemplo de inicialización. 2 PALABRAS (4 BYTES)
EXTRA ENDS
;**************************************************

; DEFINICION DEL SEGMENTO DE CODIGO
CODE SEGMENT
ASSUME CS: CODE, DS: DATOS, ES: EXTRA, SS: PILA
; COMIENZO DEL PROCEDIMIENTO PRINCIPAL
INICIO PROC
; INICIALIZA LOS REGISTROS DE SEGMENTO CON SU VALOR
	MOV AX, DATOS
	MOV DS, AX
	MOV AX, PILA
	MOV SS, AX
	MOV AX, EXTRA
	MOV ES, AX
	MOV SP, 64 ; CARGA EL PUNTERO DE PILA CON EL VALOR MAS ALTO
; FIN DE LAS INICIALIZACIONES
	; COMIENZO DEL PROGRAMA

	
	MOV AX, 13H
	MOV AH, 00H ;PARA EVITAR QUE EN AH HAYA BASURA, YA QUE LE METEMOS A AX 1BYTE Y  AX ES DE 2BYTE
	MOV BX, 00BAH
	MOV CX, 3412H
	MOV DX, CX; Copiamos el contenido de CX en DX
	
	MOV BX,6560H; Paso intermedio para meter el principio de la direcion de memoria en DS
	MOV DS,BX; 
	MOV AL, DATO_1;Guardamos en AL lo que haya en DS:DATO_1
	MOV AH, DATO_2;Guardamos en AH lo que haya en DS:DATO_2
	MOV BX, 7000H; Paso intermedio para meter el principio de la direcion de memoria en DS
	MOV DS, BX
	MOV DATO_3, CH;Guardamos en DS:DATO_3 lo que haya en CH
	MOV AX,[DI];Guardamos en AX lo que haya en la direcion que apunta DI
	MOV AX,[BP]+10;Guardamos en AX lo que haya por encima (+10) de la direcion de BP



	; FIN DEL PROGRAMA
	MOV AX, 4C00H
	INT 21H
INICIO ENDP
; FIN DEL SEGMENTO DE CODIGO
CODE ENDS
; FIN DEL PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END INICIO 