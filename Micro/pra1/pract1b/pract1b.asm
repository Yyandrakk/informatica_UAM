;********** CABECERA ***********

;Nombres: Oscar Garcia de Lara Parreño y Alba de Castro Martin
;Pareja: 6

;**************************************************
; ESTRUCTURA BÁSICA DE UN PROGRAMA EN ENSAMBLADOR
;**************************************************

; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT

CONTADOR DB ?
BEBA DW 0CAFEH
TABLA100 DB 64H dup(?);Creas un array de 100 casillas de tamaño de 1Byte sin inicializar
ERROR1 DB "ERRORES EN EL PROGRAMA, RESULTADOS INCORRECTOS" 
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
	MOV AX, 0000H ;Inicializamos AX a 0
	MOV AL,OFFSET ERROR1[SI+5]; Guardamos en AL el 6 caracter de ERROR1
	MOV TABLA100[SI+63], AL;Guardamos el caracter anterior en la array, en la posicion 63
	MOV AX, BEBA;Cargamos lo que hay en BEBA en AX
	MOV TABLA100[SI+23], AL; En la posicion 23 del array metemos AL
	MOV TABLA100[SI+24], AH; En la posicion 24 del array metemos AH
	MOV CONTADOR, AH; Guardamos AH en el Contador 

	; FIN DEL PROGRAMA
	MOV AX, 4C00H
	INT 21H
INICIO ENDP
; FIN DEL SEGMENTO DE CODIGO
CODE ENDS
; FIN DEL PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END INICIO 