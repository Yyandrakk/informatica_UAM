;********** CABECERA ***********

;Nombres: Oscar Garcia de Lara Parreño y Alba de Castro Martin
;Pareja: 6

;**************************************************
; ESTRUCTURA BÁSICA DE UN PROGRAMA EN ENSAMBLADOR
;**************************************************

; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT

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
	MOV AX, 0531H;Paso intermedio para inicializar DS con el valor que te piden
	MOV DS, AX
	MOV AX, PILA
	MOV SS, AX
	MOV AX, EXTRA
	MOV ES, AX
	MOV SP, 64 ; CARGA EL PUNTERO DE PILA CON EL VALOR MAS ALTO
; FIN DE LAS INICIALIZACIONES
	
	;APARTADO A
	MOV AL,DS:[1234H] ;EL VALOR SE COGE DE LA POSICION 06544H
	
	;APARTADO B
	MOV BX,0211H
	MOV AX,[BX] ;EL VALOR SE COGE DE LA POSICION 05521H
	
	;APARTADO C
	MOV DI,1010H
	MOV [DI],AL ;EL CONTENIDO DE AL SE GUARDA EN LA POSICION DE MEMORIA APUNTADA POR DI

	; FIN DEL PROGRAMA
	MOV AX, 4C00H
	INT 21H
INICIO ENDP
; FIN DEL SEGMENTO DE CODIGO
CODE ENDS
; FIN DEL PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END INICIO 