;********** CABECERA ***********
;Nombres: Oscar Garcia de Lara Parreño y Alba de Castro Martin
;Pareja: 6
;*******************************

DATOS SEGMENT ; Segmento de datos publico
	fibonacci DW 0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368; Reserva de _fibonacci e inicialización
	numero1	DW 0
	numero2 DW 0
	ordenMed DW 0,0,0,0
	contador DB 0
DATOS ENDS

_PRACT3A SEGMENT BYTE PUBLIC 'CODE' 
ASSUME CS: _PRACT3A, DS: DATOS
	; unsigned int far minimoComunMultiplo (unsigned int a,unsigned int b);
PUBLIC _minimoComunMultiplo
_minimoComunMultiplo PROC FAR
push ds bx cx dx bp
MOV AX, DATOS
MOV DS, AX
XOR AX, AX
XOR DX, DX
XOR BX, BX
MOV BP,SP
MOV AX,[BP+14];a
CMP AX,0
je cero
MOV numero1,AX
MOV AX,[BP+16];b
CMP AX,0
JE cero
MOV numero2,AX
XOR AX,AX
mov cx,1 ;inicializar variable cont en 1
bucle: 
 mov DX,0
 mov ax,cx
 mov bx,numero1
 div bx
 cmp dx,0 ;si el resto de la division del contador con el nro1 es igual 0
 je parte1 
 bc:
 inc cx ;incrementar el contador
 jmp bucle ;bucle hasta que encuentre el MCM

parte1: ;si nro1 es multiplo del contador
 mov DX,0
 mov ax,cx
 mov bx,numero2
 div bx
 cmp dx,0 ;compara si el resto de la division del contador con el nro2 es 0
 je parte2 
 jmp bc ;si el nro2 no es multiplo del contador regresa a bucle1
parte2: ;si el nro1 y el nro2 son multiplos del contador
 mov ax,cx ;guarda el MCM para devolverlo
jmp final
cero: 
XOR AX,AX
 
final:
pop  bp dx cx bx ds
ret ;fin del programa
_minimoComunMultiplo ENDP


PUBLIC _calculaMediana 
_calculaMediana PROC FAR
	PUSH DS
	MOV AX, DATOS
	MOV DS, AX
	PUSH BX CX DX DI		;Se guarda el contexto en la pila
	PUSH BP 		 ;Para poder utilizar BP para direccionar la pila
	MOV BP, SP		 ;Se carga con puntero a cima de pila
	MOV AX, [BP+16]  ;Guardamos en AX el primer valor pasado como parametro
	MOV BX, [BP+18]  ;Guardamos en BX el segundo valor pasado como parametro
	MOV CX, [BP+20]	 ;Guardamos en BX el tercer valor pasado como parametro
	MOV DX, [BP+22] ;Guardamos en BX el cuarto valor pasado como parametro
	
	CMP AX, BX;Si AX es mayor que BX incrementamos el contador 2 veces ya que es DW
	JNG s1
	INC contador
	INC contador
s1:
	CMP AX, cX
	JNG s2
	INC contador
	INC contador
s2:
	CMP AX, DX
	JNG s3
	INC contador
	INC contador
s3:
	MOV DI, WORD PTR contador ;Pongo el numero en DI y asi lo insetara en posicion. El mas pequeño en 0 y el mas grande en la 3(DI=6 por ser DW)
	MOV ordenMed[DI],AX;Inserto el numero en su posicion
	MOV contador,0;Reinicio el contador a 0
	CMP BX, AX;Asi con los otros 3 numero
	JNG s4
	INC contador
	INC contador
s4:
	CMP BX,CX
	JNG s5
	INC contador
	INC contador
s5:
	CMP BX, DX
	JNG s6
	INC contador
	INC contador
s6:
	MOV DI,WORD PTR contador
	MOV ordenMed[DI],BX
	MOV contador,0
	CMP CX, AX
	JNG s7
	INC contador
	INC contador
s7:
	CMP CX, BX
	JNG s8
	INC contador
	INC contador
s8:
	CMP CX, DX
	JNG s9
	INC contador
	INC contador
s9:	
	MOV DI,WORD PTR contador
	MOV ordenMed[DI],CX
	MOV contador,0
	CMP DX, AX
	JNG s10
	INC contador 
	INC contador
s10:
	CMP DX, BX
	JNG s11
	INC contador 
	INC contador

s11:
	CMP DX, CX
	JNG s12
	INC contador 
	INC contador

s12:	
	MOV DI, WORD PTR contador
	MOV ordenMed[DI],DX
	MOV contador,0
	
	MOV AX, ordenMed[2]; Cojo los dos numeros centrales
	MOV BX, ordenMed[4]
	ADD AX,BX;Los sumo y divido por dos
	MOV BX, 0002h
	IDIV BL
	cbw
	pop bp di dx cx bx ds
	ret 
	
_calculaMediana ENDP

PUBLIC _esFibonacci
_esFibonacci PROC FAR
	PUSH DS
	MOV AX, DATOS
	MOV DS, AX
	
	PUSH bx si BP 		;Para poder utilizar BP para direccionar la pila y guardamos el contexto
	MOV BP, SP			;Se carga con puntero a cima de pila
	MOV SI, 0FFFEh					
	MOV AX, [BP+12]		;Guardamos en AX el valor del parametro num
buscar:
	INC SI
	INC SI ;Se aumenta el contador para poder acceder a la siguiente posicion del array
	MOV BX, fibonacci[si]
	CMP AX, BX
	JE pertenece ;Si el valor de AX esta contenido en el array fibonacci salta a la etiqueta
	CMP BX, 46368	
	JE no_pertenece ; Si el valor son iguales, es que ha llegado al final sin encontrarlo por tanto salta a no pertenece
	JNE buscar		;Si el valor de AX no esta contenido en el array fibonacci sigue buscando
	
no_pertenece:
	MOV AX, 0
	POP BP SI BX ds	 ;Restaura BP y el contexto
	RET 			 ;Retorna a procedimiento llamante
pertenece:
	MOV AX, 1
	POP bp si bx ds		 ;Restaura BP
	RET 			 ;Retorna a procedimiento llamante
	
_esFibonacci ENDP



PUBLIC _divisiblePor4
_divisiblePor4 PROC FAR
	PUSH DS
	MOV AX, DATOS
	MOV DS, AX

	PUSH BX 		 ;Se guarda el contexto en la pila
	PUSH BP 		 ;Para poder utilizar BP para direccionar la pila
	MOV BP, SP		 ;Se carga con puntero a cima de pila
	MOV BX, [BP+10] ;Guardamos en BX el valor del parametro num
	CMP BX,0
	JE divisible
	CMP BX, 4
	JB nodivisible
	SHR BX, 1 		 ;Dividimos por 2
	SHR BX, 1 		 ;Dividimos por 2
	JNC	divisible 	 ;Salta a la etiqueta si C=0
	JC nodivisible   ;Salta a la etiqueta si C=1
divisible:
	MOV AX, 1
	POP BP BX DS
	RET
nodivisible:
	MOV AX, 0
	POP BP BX DS
	RET

_divisiblePor4 ENDP


_PRACT3A ENDS
END