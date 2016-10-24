;************************************************************
;Nombre: Oscar Garcia de Lara Parreño y Alba de Castro Martin
;Pareja: 6
;*************************************************************
; DEFINICION DEL SEGMENTO DE CODIGO
PA4A SEGMENT
ASSUME CS: PA4A
ORG 256
inicio: JMP instalador
;Variables globales

	CAD_DATOS DB "DATOS: "
	DB "NOMBRES: OSCAR GARCIA DE LARA PARREÑO Y ALBA DE CASTRO MARTIN "
	DB "GRUPO: 2273","INSTRUCIONES DE USO: "
	DB "/I PARA INSTALAR Y /D PARA DESISNTALAR RUTINA 60H "
	DB "CUANDO SE LLAME A LA RUTINA: "
	DB "AH=12H PARA CONVERTIR CADENA DECIMAL A HEXADECIMAL Y AH=13 LO INVERSO "
	DB "EL SEGMENTO EN DS Y EL OFFSET APUNTANDO YA AL PRIMER NUMERO EN DX ","$"
	CAD_ERROR DB "ERROR EN EL PASO DE PARAMETROS","$"
	CAD_AUX DB 10 DUP(0);CADENA AUXILIAR PARA LA CONVERSION DE HEX A DEC
	RESUL DB 20 dup(0);DONDE ALMACENA EL RESULTADO
;Rutina de servicio a interrupcion 
rsi PROC FAR
	PUSHF
	CMP AH, 12h
	JE impDAH
	CMP AH,13h
	JE impHAD
	JMP errD
impDAH: 
	CALL imprimirDAH
	JMP salir
impHAD: 
	CALL imprimirHAD
	JMP salir
errD:	
	CALL errorD
	
salir:	
	POPF
	IRET 
rsi ENDP

errorD proc near
	MOV AH,9	
	MOV DX, OFFSET CAD_ERROR; IMPRIME EL ERROR
	INT 21H
	RET 
errorD endp

; ========= Imprime cadena decimal en hexadecimal =====================
; Parametros
; DX: offset inicial de la cadena con respecto a DS
; Retorna
; NADA
;==========================================================
imprimirDAH proc near
	PUSH SI BX CX DX DS DI
	MOV SI,DX
	CALL atoi  
	CALL imprimirH
	POP DI DS DX CX BX SI
	RET
imprimirDAH endp	

; ========= Convertir cadena a numero =====================
; Parametros
; si: offset inicial de la cadena con respecto a DS
; Retorna
; bx: valor
;==========================================================
atoi proc near
	xor bx,bx   ;BX = 0

atoi_1:
	lodsb       ;carga byte apuntado por SI en AL e incrementa si
	cmp al,'0'  ;es numero ascii? [0-9]
	jb noascii  ;no, salir
	cmp al,'9'
	ja noascii  ;no, salir

	sub al,30h  ;ascii '0'=30h, ascii '1'=31h...etc.
	cbw         ;byte a word
	push ax
	mov ax,bx   ;BX tendra el valor final
	mov cx,10
	mul cx      ;AX=AX*10
	mov bx,ax
	pop ax
	add bx,ax
	jmp atoi_1  ;seguir mientras SI apunte a un numero ascii
noascii:
	ret         ;BX tiene el valor final
atoi endp

; ========= Imprime cadena hexadecimal en decimal =====================
; Parametros
; DX: offset inicial de la cadena con respecto a DS
; Retorna
; NADA
;==========================================================
imprimirHAD proc near
	
	PUSH SI BX CX DX DS DI
	MOV SI,DX
	CALL atoh
	CALL imprimirD
	POP DI DS DX CX BX SI
	ret
imprimirHAD endp

; ========= Convertir cadena a numero HEX =====================
; Parametros
; si: offset inicial de la cadena con respecto a DS
; Retorna
; bx: valor
;==========================================================
atoh proc near
	MOV BX, 0000h   ;BX = 0
	MOV AX, 0000h
	MOV CX,0001h
nhex:
	lodsb       ;CARGA EN AL LO QUE APUNTA SI E INCREMENTA SI          
	cmp al,'0'  
	jb noascii1  ;CUANDO NO ES EL ASCII DE UN NUMERO SALE
	cmp al,'9'
	jbe numero  ;CUANDO AL SER MAYOR IGUAL QUE CERO O MENOR IGUAL QUE 9 SALTA
	cmp al,'A'
	jb noascii1 ;CUANDO NO HA SALTADO EN LOS NUMEROS, Y NO ESTA ENTRE A-F
	cmp al, 'F'	;ENTONCES ES EL FINAL DE CADENA Y SALTA AL FINAL DE LA FUNCION PARA TERMINAR
	ja noascii1
letra:
	sub al, 37h ;RESTAMOS 37H PARA CONSEGUIR LA LETRA DEL NUMERO HEX DEL ASCII
	cbw			;BYTE A WORD
	jmp conversion
numero: 
	sub al,30h  ;RESTAMOS 30H PARA CONSEGUIR EL NUMERO DEL ASCII
	cbw         ;BYTE A WORD
conversion:  
	cmp cx,1 	;SI EL CONTADOR ES 1 O SEA, ES LA UNIDAD DEL NUMERO, SALTA
	je suma 	;SI NO CONTINUA
	push cx ax
	mov ax,bx
	mov cx, 10h	;SE LE MULTIPLICA POR 10H(16) PARA MOVERLO A LAS DECENAS Y DEJARLO EN AL=X0
	mul cx
	mov bx,ax
	pop ax cx
suma:
	add bx,ax	;SE SUMA A BX QUE CONTIENE EL BYTE
	inc cx
	jmp nhex 	;EL BUCLE SE REPITE DOS VECES PARA SACAR 1BYTE
  
noascii1:
	ret    		;RETORNO EN BX
atoh endp

; ========= IMPRIMIR EN DECIMAL =====================
; Parametros
; BX: VALOR
; Retorna
; NADA
;==========================================================
imprimirD proc near
	
	MOV CX,000AH
	MOV DI, 0000h
	XOR DX,DX
	MOV AX, BX;Muevo en AX el valor
	
DIV10:
	DIV CX
	MOV CAD_AUX[DI],DL
	MOV DX, 0000h
	INC DI
	CMP AX, 0000h
	JNE DIV10
	MOV ax,0200h
IMPR:	
	DEC DI
	MOV DL, CAD_AUX[DI]
	ADD DL,30h
	INT 21h
	CMP DI, 00h	
	JNE IMPR

	RET
imprimirD endp
; ========= IMPRIMIR EN HEXADECIMAL =====================
; Parametros
; BX: VALOR
; Retorna
; NADA
;==========================================================
imprimirH proc near

	MOV AH,00h	
	MOV CX,0010H
	MOV DI, 0000h
	MOV AX, BX	
	
DIV10h:
	DIV CX
	MOV RESUL[DI], DL
	MOV DX,0000H
	INC DI
	CMP AX,0000H
	JNE DIV10h
	
	MOV ax,0000H
	MOV AH,02H
IMPRh:	
	DEC DI
	MOV DL, RESUL[DI]
	CMP DL,9
	JBE numeroh
	ADD DL,37h
	JMP print
numeroh:ADD DL, 30h	
print:	
	INT 21h
	CMP DI, 00h	
	JNE IMPRh
	RET
imprimirH endp
;=============================
;   RUTINA DE INSTALACION
;=============================
instalar proc near
	XOR AX, AX
	MOV ES, AX
	MOV AX,OFFSET rsi
	CLI
	MOV ES:[60H*4],AX
	MOV ES:[60H*4+2],CS
	STI 
	MOV DX, OFFSET instalar 
	INT 27H ; ACABA Y DEJA RESIDENTE PSP, VARIABLE Y RUTINA RSI
instalar endp


instalador PROC NEAR
	XOR CX, CX
	MOV SI,80H	;OFFSET DE LOS PARAMETROS
	MOV CL,[SI]	;LONGITUD DE LA LINEA
	CMP CX,0
	JZ info
	INC SI		;AVANZAMOS EN LA CADENA
	INC SI		;EVITAMOS EL ESPACIO
	MOV CL,[SI]
	CMP CL,'/'
	JNE erD
	INC SI
	MOV CL,[SI]
	CMP CL,'I'
	JE instala
	MOV CL,[SI]
	CMP CL,'D'
	JE desinstala
	JMP erD
info:	
	CALL impDatos
	JMP salirIn
instala:	
	MOV AX,0
	MOV ES,AX
	CMP ES:[60H*4],WORD PTR 0
	JNE salirIn
	CALL instalar
	JMP salirIn
desinstala:
	CALL desinstalar
	JMP salirIn
erD:
	CALL errorD
salirIn:
	MOV AX,4C00H
	INT 21H
instalador ENDP

desinstalar proc near
	XOR AX,AX
	MOV ES,AX
	CMP ES:[60H*4],WORD PTR 0	;SI ES 0, ESTA DESINSTALADO POR TANTO EVITAMOS QUE LO DESINSTALE DE NUEVO
	JE salirD
	
	CLI
	MOV ES:[60H*4],AX	;PONEMOS A 0
	MOV ES:[60H*4],AX
	STI
	
	MOV ES, CS:[2CH]
	MOV AH, 49H
	INT 21H				;LIBERA SEGMENTO DE RSI
	MOV AX,CS
	MOV ES,AX
	MOV AH,49H
	INT 21H				;LIBERA SEGMENTO DE VARIABLES DE ENTORNO DE RSI
salirD:	
	RET
desinstalar endp

impDatos proc near
	MOV AH,9
	MOV DX, OFFSET CAD_DATOS	;IMPRIME EL ERROR
	INT 21H
	RET 
impDatos endp
PA4A ENDS

END	inicio