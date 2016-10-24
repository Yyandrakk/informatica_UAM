;********** CABECERA ***********
;Nombres: Oscar Garcia de Lara Parreño y Alba de Castro Martin
;Pareja: 6
;********************************************************
DATA SEGMENT ; Segmento de datos 
DATA ENDS

_PRACT3B SEGMENT BYTE PUBLIC 'CODE' 
ASSUME CS: _PRACT3B, DS: DATA

;1.-void enteroACadenaHexa (int num, char* outStr)
PUBLIC _enteroACadenaHexa
_enteroACadenaHexa PROC FAR

	push AX BX DI ES BP
	MOV BP, SP
	XOR AX, AX; PONGO A CERO AX Y BX
	XOR BX, BX
	MOV AX, [BP+14]
	MOV DI, [BP+16];OFFSET DE LA CADENA DE SALIDA
	MOV ES, [BP+18];SEGMENT DE LA CADENA DE SALIDA
	CALL itoa
	POP BP ES DI BX AX
	ret
_enteroACadenaHexa ENDP

;2.- void calculaChecksum(char* inStr, char* Check) 
PUBLIC _calculaChecksum
_calculaChecksum PROC FAR
	push di es si ds ax bx dx cx bp
	mov bp, sp
	mov si,[BP+22];OFFSET DE LA CADENA DE ENTRADA
	mov ds,WORD PTR[BP+24];SEGMENT DE LA CADENA DE ENTRADA
	mov di,[BP+26];OFFSET DE LA CADENA DE SALIDA
	mov es,WORD PTR[BP+28];SEGMENTE DE LA CADENA DE SALIDA
	call checksum
	XOR AX, AX
	MOV AL, DL ; PASO EL CHECKSUM A AL Y LO MULTIPLICO POR 10h POR TANTO EN AH ME QUEDA UN NUMERO Y EN AL EL OTRO
	MOV DL, 10h
	MUL DL

	cmp ah,9
	jbe numero2  ;SALTA CUANDO ES DE 0-9
	add ah, 37h ;RESTAMOS 37H PARA CONSEGUIR LA LETRA DEL NUMERO HEX DEL ASCII
	jmp escribir
numero2: 
  add ah,30h  ;RESTAMOS 30H PARA CONSEGUIR EL NUMERO DEL ASCII
escribir:
	MOV [ES:DI],AH ;ESCRIBIMOS EL PRIMER NUMERO
	INC DI
	
	MOV AH,00H
	DIV DL ;DIVIDO PARA QUE EN AL QUEDE 0X DONDE X ES UN NUMERO YA QUE ANTES ESTABA X0 POR LA MULTIPLICACION 
	cmp al,9
	jbe numero3  ;SALTA CUANDO ES DE 0-9
	add al, 37h ;RESTAMOS 37H PARA CONSEGUIR LA LETRA DEL NUMERO HEX DEL ASCII
	jmp escribir2
numero3: 
  add al,30h  ;RESTAMOS 30H PARA CONSEGUIR EL NUMERO DEL ASCII
escribir2:
	MOV [ES:DI],Al;ESCRIBIMOS EL 2º NUMERO
	INC DI
	MOV AL, 00h; FINAL DE CADENA
	MOV [ES:DI],Al
	
	pop bp cx dx bx ax ds si es di
	ret
_calculaChecksum ENDP
; =============== CALCULAR CHECKSUM ===============
; Parametros
; SI: OFFSET DE LA CADENA DE ENTRADA
; Retorna
; DL: CHECKSUM
;==================================================
checksum proc
    MOV BX, 0000h   ;BX = 0
	MOV AX, 0000h
	XOR DX, DX
	MOV CX,0002h
byte1:
  lodsb       ;CARGA EN AL LO QUE APUNTA SI E INCREMENTA SI
              
  cmp al,'0'  
  jb noascii1  ;CUANDO NO ES EL ASCII DE UN NUMERO SALE
  cmp al,'9'
  jbe numero  ;CUANDO AL SER MAYOR IGUAL QUE CERO O MENOR IGUAL QUE 9 SALTA
  cmp al,'A'
  jb noascii1 ;CUANDO NO HA SALTADO EN LOS NUMEROS, Y NO ESTA ENTRE A-F
  cmp al, 'F';ENTONCES ES EL FINAL DE CADENA Y SALTA AL FINAL DE LA FUNCION PARA TERMINAR
  ja noascii1
  letra:
	sub al, 37h ;RESTAMOS 37H PARA CONSEGUIR LA LETRA DEL NUMERO HEX DEL ASCII
	cbw;BYTE A WORD
	jmp conversion
numero: 
  sub al,30h  ;RESTAMOS 30H PARA CONSEGUIR EL NUMERO DEL ASCII
  cbw         ;BYTE A WORD
conversion:  
 cmp cx,1 ;SI EL CONTADOR ES 1 OSEA ES LA UNIDAD DEL NUMERO, SALTA
 je suma ;SINO CONTINUA
 push cx
 mov cx, 10h;SE LE MULTIPLICA POR 10H(16) PARA MOVERLO A LAS DECENAS Y DEJARLO EN AL=X0
 mul cl
 pop cx
 suma:
  add bx,ax;SE SUMA A BX QUE CONTIENE EL BYTE
  loop byte1 ;EL BUCLE SE REPITE DOS VECES PARA SACAR 1BYTE
  MOV CX, 0002h;REINICIO CONTADOR
  ADD DX, BX;SE LO SUMO A DX QUE CONTENDRA EL NUMERO
  XOR BX,BX;REINICIO BX
  jmp byte1; NO SE SALE HASTA QUE ENCUENTRE CARACTER NO ASCII
 noascii1:
 MOV DH, 00h
 NEG DL ;NIEGO DL PARA SACAR EL CHECKSUM
 ret    ;RETORNO EN DL
checksum endp
; =============== Convertir numero a cadena ===============
; Parametros
; ax: valor
; ES: SEGMENT DE LA CADENA FINAL
; DI: OFFSET DE LA CADENA FINAL
; Retorna
; NADA YA SE HA GUARDADO EN LA CADENA
itoa proc
	push cx dx 
    xor cx,cx  ;CX = 0
itoa_1:
  cmp ax,0   
  je itoa_2  ;Si el numero es 0 saltamos a itoa_2
  mov dx, ax;MUEVO EL NUMERO A DX
  mov ax, 0;
  restar:
		mov bx, dx
		inc ax
		sub dx,16
        cmp bx, 16
		jge  restar; 
  dec ax
  push bx
  inc cx
  jmp itoa_1

  itoa_2:
  cmp cx,0    ; CUANDO CX ES 0, OSEA NO HIZO EL BUCLE ANTERIOR PORQUE EL NUMERO ES 0
  ja itoa_3   ; DIRECTAMENTE ESCRIBE 0 EN LA CADENA SIN UTILIZAR LA PILA
  mov ax,'0'  ;Y SALTA PARA PONERLE EL FIN DE LA CADENA
  mov [ES:DI],ax 
  inc DI     
  jmp itoa_4

  itoa_3:
  pop ax      ; Extraemos los numero del stack
  cmp ax, 9
  jg mayor
  
  add ax,30h  ; lo pasamos a su valor ascii
  mov [ES:DI],ax ; lo guardamos en la cadena final
  inc DI
  loop itoa_3;TANTAS VECES HASTA QUE CX SEA 0
  jmp itoa_4
  mayor:
  add ax, 37h
  mov[ES:DI],ax
  inc DI
  loop itoa_3;TANTAS VECES HASTA QUE CX SEA 0

  itoa_4:
  mov ax,00h  ; terminar cadena con '0' para 
  mov [ES:DI],ax ; imprimirla en C
  pop dx cx
  ret
itoa endp

_PRACT3B ENDS
END