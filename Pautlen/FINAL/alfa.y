%{
	#include "alfa.h"
	#include "printNASM.h"
	void yyerror(char const *cadena);
	extern int linea,columna,error;
	extern FILE *yyin;
	extern FILE *reg;
	extern int yylex();
	extern int yyleng;
	/* Los dos ambitos */
	TablaHash ts_global,ts_local;
	/* Ficheros auxiliares */
	FILE *auxident,*reg;
  int local=FALSE,en_funcion=FALSE,etiqueta=0,nretorno=0,llamada_dentro_funcion=0,tipoErrorSemantico=0;/*Variables de control*/
	char nomfun[100];/* Nombre de la funcion del ambito actual */
	/* Variables axiliares para la herencia */
	int tipo_actual=0,clase_actual=0,tamanio_vector_actual=0,pos_variable_local_actual=0,num_variables_locales_actual=0,num_param_actual=0,pos_param_actual=0,en_explit=0,num_parametros_llamada_actual=0;
%}
%union
	{
	tipo_atributos atributos;
	}
%token TOK_MAIN
%token TOK_INT
%token TOK_BOOLEAN
%token TOK_ARRAY
%token TOK_FUNCTION
%token TOK_IF
%token TOK_ELSE
%token TOK_WHILE
%token TOK_SCANF
%token TOK_PRINTF
%token TOK_RETURN
%token TOK_PUNTOYCOMA
%token TOK_COMA
%token TOK_PARENTESISIZQUIERDO
%token TOK_PARENTESISDERECHO
%token TOK_CORCHETEIZQUIERDO
%token TOK_CORCHETEDERECHO
%token TOK_LLAVEIZQUIERDA
%token TOK_LLAVEDERECHA
%token TOK_ASIGNACION
%token TOK_MAS
%token TOK_MENOS
%token TOK_DIVISION
%token TOK_ASTERISCO
%token TOK_AND
%token TOK_OR
%token TOK_NOT
%token TOK_IGUAL
%token TOK_DISTINTO
%token TOK_MENORIGUAL
%token TOK_MAYORIGUAL
%token TOK_MENOR
%token TOK_MAYOR
%token <atributos> TOK_IDENTIFICADOR
%token <atributos> TOK_CONSTANTE_ENTERA
%token <atributos> TOK_TRUE
%token <atributos> TOK_FALSE
%token TOK_ERROR
%type <atributos> clase exp clase_escalar clase_vector constante constante_logica constante_entera comparacion fn_name fn_declaration funcion identificadores identificador asignacion elemento_vector condicional if_exp if_exp_sentencias bucle while while_exp idf_llamada_funcion idpf
%left TOK_MAS TOK_MENOS TOK_OR
%left TOK_DIVISION TOK_ASTERISCO TOK_AND
%right TOK_NOT MENOSU
%start programa
%%
programa: inicio_tabla TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones escritura_TS funciones escritura_main sentencias TOK_LLAVEDERECHA {system("rm auxident.txt");escribirErrores();fprintf(reg,";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }\n");fclose(reg);destruirTablaHash(ts_global);}
;
inicio_tabla: {
	auxident=fopen("auxident.txt","w");
	reg=fopen("reglas.txt","w");
	if((ts_global = crearTablaHash())==NULL)
	{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("Error abrir ambito global.");
			return -1;
	}
}
;
escritura_TS:{
	clase_actual=1;
	fclose(auxident);
	escribirSegmentBss (ts_global);
	escribirSegmentData();
	escribirCabCodigo();

}
;
escritura_main: {
	escribirMain();

}
;
declaraciones: declaracion {fprintf(reg,";R2:\t<declaraciones> ::= <declaracion>\n");}
		| declaracion declaraciones {fprintf(reg,";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
;
declaracion: clase identificadores TOK_PUNTOYCOMA {
	$2.tipo=$1.tipo;fprintf(reg,";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");
	}
;
clase: clase_escalar {clase_actual=ESCALAR;fprintf(reg,";R5:\t<clase> ::= <clase_escalar>\n");}
	| clase_vector {clase_actual=VECTOR;fprintf(reg,";R7:\t<clase> ::= <clase_vector>\n");}
;
clase_escalar:tipo {fprintf(reg,";R9:\t<clase_escalar> ::= <tipo>\n");}
;
clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO constante_entera TOK_CORCHETEDERECHO {
	tamanio_vector_actual=$4.valor_entero;
	if(tamanio_vector_actual<1||tamanio_vector_actual>MAX_TAMANIO_VECTOR)
		error=-1;


	;fprintf(reg,";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");}
;
tipo: TOK_INT
				{tipo_actual=INT;fprintf(reg,";R10:\t<tipo> ::= int\n");}
	|TOK_BOOLEAN
				{tipo_actual=BOOLEAN;fprintf(reg,";R11:\t<tipo> ::= boolean\n");}
;
identificadores: identificador
		{
			$1.tipo=$$.tipo;
			fprintf(reg,";R18:\t<identificadores> ::= <identificador>\n");
		}
	| identificador TOK_COMA identificadores
		{
			$1.tipo=$$.tipo;$3.tipo=$$.tipo;
			fprintf(reg,";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");
		}
;
funciones: funcion funciones
						{fprintf(reg,";R20:\t<funciones> ::= <funcion> <funciones>\n");}
	| /* VACIO */
						{fprintf(reg,";R21:\t<funciones> ::=\n");}
;
funcion : fn_declaration sentencias TOK_LLAVEDERECHA {
	destruirTablaHash(ts_local);
	local=FALSE;
	if (FALSE==actualizarFuncionHash (ts_global,$1.lexema,num_param_actual))
	{
		error=-1;
		tipoErrorSemantico=0;
		yyerror("No se puede actualizar los datos de la global");
		return -1;
	}
	if(nretorno==0)
	{
		error=-1;
		tipoErrorSemantico=3;
		yyerror($1.lexema);
		return -1;
	}
	escribirfuncionend();
	nretorno=0;
	en_funcion=FALSE;
	fprintf(reg,";R22:\t<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> }\n");}
;
fn_name : TOK_FUNCTION tipo TOK_IDENTIFICADOR {

		if(local==TRUE)
		{error=-1;
			tipoErrorSemantico=0;
			yyerror("Creacion de una funcion dentro de una funcion");
			return -1;
		}
		if(FALSE==InsertarHash ($3.lexema,FUNCION,clase_actual,tipo_actual, tamanio_vector_actual, num_variables_locales_actual, pos_variable_local_actual,num_param_actual ,pos_param_actual , ts_global))
			{error=-1;
				tipoErrorSemantico=0;
				yyerror("Declaracion duplicada.");
				return -1;
			}
		if((ts_local=crearTablaHash())==NULL)
		{
			error=-1;
			tipoErrorSemantico=0;
				yyerror("Error al abrir el ambito local");
				return -1;
		}
		InsertarHash ($3.lexema,FUNCION,clase_actual,tipo_actual, tamanio_vector_actual, num_variables_locales_actual, pos_variable_local_actual,num_param_actual ,pos_param_actual , ts_local);
		local=TRUE;
		num_variables_locales_actual = 0;
		pos_variable_local_actual = 1;
		num_param_actual = 0;
		pos_param_actual = 0;
		strcpy($$.lexema,$3.lexema);
	}
;
fn_declaration : fn_name TOK_PARENTESISIZQUIERDO parametros_funcion TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA declaraciones_funcion{
	if (FALSE==actualizarFuncionHash (ts_local,$1.lexema,num_param_actual))
	{
		error=-1;
		tipoErrorSemantico=0;
		yyerror("No se puede actualizar los datos del ambito local.");
		return -1;
	}
	en_funcion=TRUE;
	strcpy($$.lexema,$1.lexema);
	strcpy(nomfun,$1.lexema);
	escribirfuncionfirst($1.lexema,num_variables_locales_actual);
	}
;
parametros_funcion: parametro_funcion resto_parametros_funcion
{fprintf(reg,";R23:\t<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>\n");}
			| /* VACIO */
			{fprintf(reg,";R24:\t<parametros_funcion> :=\n");}
;
resto_parametros_funcion: TOK_PUNTOYCOMA parametro_funcion resto_parametros_funcion {fprintf(reg,";R25:\t<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>\n");}
			| /* VACIO */ {fprintf(reg,";R26:\t<resto_parametros_funcion> ::=\n");}
;
parametro_funcion: tipo idpf {fprintf(reg,";R27:\t<parametro_funcion> ::= <tipo> <identificador>\n");}
;
declaraciones_funcion: declaraciones {fprintf(reg,";R28:\t<declaraciones_funcion> ::= <declaraciones>\n");}
			| /* VACIO */ {fprintf(reg,";R29:\t<declaraciones_funcion> ::=\n");}
;
sentencias: sentencia {fprintf(reg,";R30:\t<sentencias> ::= <sentencia>\n");}
	| sentencia sentencias {fprintf(reg,";R31:\t<sentencias> ::= <sentencia> <sentencias>\n");}
;
sentencia: sentencia_simple TOK_PUNTOYCOMA {fprintf(reg,";R32:\t<sentencia> ::= <sentencia_simple> ;\n");}
	| bloque {fprintf(reg,";R33:\t<sentencia> ::= <bloque>\n");}
;
sentencia_simple: asignacion {fprintf(reg,";R34:\t<sentencia_simple> ::= <asignacion>\n");}
		| lectura {fprintf(reg,";R35:\t<sentencia_simple> ::= <lectura>\n");}
		| escritura {fprintf(reg,";R36:\t<sentencia_simple> ::= <escritura>\n");}
		| retorno_funcion {fprintf(reg,";R38:\t<sentencia_simple> ::= <retorno_funcion>\n");}
;
bloque: condicional {fprintf(reg,";R40:\t<bloque> ::= <condicional>\n");}
	| bucle {fprintf(reg,";R41:\t<bloque> ::= <bucle>\n");}
;
asignacion: TOK_IDENTIFICADOR TOK_ASIGNACION exp {
	if(local==FALSE)
	{
		if(!MiembroHash($1.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=1;
			yyerror($1.lexema);
			return -1;
		}
		if(FUNCION==returnCategoriaHash ($1.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("Asignacion incompatible.");
			return -1;
		}
		if(ESCALAR != returnClaseHash ($1.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("Asignacion incompatible.");
			return -1;
		}
		if($3.tipo!=returnTipoHash ($1.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("Asignacion incompatible.");
			return -1;
		}
		asignarIdent($1.lexema, $3.es_direccion);
	}
	else
	{
			if(!MiembroHash($1.lexema,ts_local))
			{
				if(!MiembroHash($1.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=1;
					yyerror($1.lexema);
					return -1;
				}
				if(FUNCION==returnCategoriaHash ($1.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Asignacion incompatible.");
					return -1;
				}
				if(ESCALAR != returnClaseHash ($1.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Asignacion incompatible.");
					return -1;
				}
				if($3.tipo!=returnTipoHash ($1.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Asignacion incompatible.");
					return -1;
				}
				asignarIdent($1.lexema, $3.es_direccion);

			}
			else{
			if(FUNCION==returnCategoriaHash ($1.lexema,ts_local))
			{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("Asignacion incompatible.");
				return -1;
			}
			if(ESCALAR != returnClaseHash ($1.lexema,ts_local))
			{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("Asignacion incompatible.");
				return -1;
			}
			if($3.tipo!=returnTipoHash ($1.lexema,ts_local))
			{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("Asignacion incompatible.");
				return -1;
			}
			escribirIdentificadorLocal (returnCategoriaHash ($1.lexema,ts_local),num_param_actual, returnPosParHash  ($1.lexema,ts_local),returnPosVarHash ($1.lexema,ts_local),en_explit);
			asignarIdentLocal( $3.es_direccion);
	}
	}
	fprintf(reg,";R43:\t<asignacion> ::= <identificador> = <exp>\n");
}
	| elemento_vector TOK_ASIGNACION exp {
		if($3.tipo!=$1.tipo)
	{
		error=-1;
		tipoErrorSemantico=0;
		yyerror("Asignacion incompatible.");
		return -1;
	}
	asignarElem ($3.es_direccion);
	fprintf(reg,";R44:\t<asignacion> ::= <elemento_vector> = <exp>\n");}
;
elemento_vector: TOK_IDENTIFICADOR TOK_CORCHETEIZQUIERDO exp TOK_CORCHETEDERECHO {
	if(local==FALSE)
	{
		if(!MiembroHash($1.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=1;
			yyerror($1.lexema);
			return -1;
		}
		if(FUNCION==returnCategoriaHash ($1.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("Intento de indexacion de una variable que es de categoria funcion.");
			return -1;
		}
		if(VECTOR != returnClaseHash ($1.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("Intento de indexacion de una variable que no es de tipo vector.");
			return -1;
		}
		if($3.tipo!=INT)
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("El indice en una operacion de indexacion tiene que ser de tipo entero.");
			return -1;
		}
		$$.tipo=returnTipoHash ($1.lexema,ts_global);
		$$.es_direccion=1;
		escribirElemVector($$.es_direccion,$1.lexema,ts_global);

	}
	else
	{
			if(!MiembroHash($1.lexema,ts_local))
			{
				if(!MiembroHash($1.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=1;
					yyerror($1.lexema);
					return -1;
				}
				if(FUNCION==returnCategoriaHash ($1.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=1;
					yyerror("Intento de indexacion de una variable que es de categoria funcion.");
					return -1;
				}
				if(VECTOR != returnClaseHash ($1.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Intento de indexacion de una variable que no es de tipo vector.");
					return -1;
				}
				if($3.tipo!=INT)
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("El indice en una operacion de indexacion tiene que ser de tipo entero.");
					return -1;
				}
				$$.tipo=returnTipoHash ($1.lexema,ts_global);
				$$.es_direccion=1;
				escribirElemVector($$.es_direccion,$1.lexema,ts_global);

			 }
			else
			{
				if(FUNCION==returnCategoriaHash ($1.lexema,ts_local))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Intento de indexacion de una variable que es de categoria funcion.");
					return -1;
				}
				if(VECTOR != returnClaseHash ($1.lexema,ts_local))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Intento de indexacion de una variable que no es de tipo vector.");
					return -1;
				}
				if($3.tipo!=INT)
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("El indice en una operacion de indexacion tiene que ser de tipo entero.");
					return -1;
				}
				$$.tipo=returnTipoHash ($1.lexema,ts_local);
				$$.es_direccion=1;
				escribirElemVector($$.es_direccion,$1.lexema,ts_local);
	}
}

	fprintf(reg,";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");}
;
condicional: if_exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {escribirifend($1.etiqueta);fprintf(reg,";R50:\t<condicional> ::= if ( <exp> ) { <sentencias> }\n");}
	| if_exp_sentencias TOK_ELSE TOK_LLAVEIZQUIERDA sentencias  TOK_LLAVEDERECHA {escribirelse($1.etiqueta);fprintf(reg,";R51:\t<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }\n");}
;
if_exp: TOK_IF TOK_PARENTESISIZQUIERDO exp {if($3.tipo!=BOOLEAN){error=-1;tipoErrorSemantico=0;yyerror("Condicional con condicion de tipo int.");return -1;}$$.etiqueta=etiqueta;etiqueta++;escribirif($3.es_direccion,$$.etiqueta);}
;
if_exp_sentencias : if_exp  TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {$$.etiqueta=$1.etiqueta;escribirif_exp($1.etiqueta);}
;
bucle: while_exp sentencias TOK_LLAVEDERECHA {escribirwhile_fin($1.etiqueta);fprintf(reg,";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");}
;
while: TOK_WHILE TOK_PARENTESISIZQUIERDO  {$$.etiqueta=etiqueta;etiqueta++;escribirwhile($$.etiqueta);}
;
while_exp: while exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA {if($2.tipo!=BOOLEAN){error=-1;tipoErrorSemantico=0;yyerror("Bucle con condicion de tipo int.");return -1;}$$.etiqueta=$1.etiqueta;escribirwhile_exp($2.es_direccion,$1.etiqueta);}
;
lectura: TOK_SCANF TOK_IDENTIFICADOR {
	if(local==FALSE)
	{
		if(!MiembroHash($2.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=1;
			yyerror($2.lexema);
			return -1;
		}
		if(FUNCION==returnCategoriaHash ($2.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("La lectura no se puede guardar en una variable de categoria funcion.");
			return -1;
		}
		if(ESCALAR != returnClaseHash ($2.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("La lectura no se puede guardar en una variable de clase vector.");
			return -1;
		}

		escribirScanf ($2.lexema, returnTipoHash ($2.lexema,ts_global));

	}
	else
	{
			if(!MiembroHash($2.lexema,ts_local))
			{
				if(!MiembroHash($2.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=1;
					yyerror($2.lexema);
					return -1;
				}
				if(FUNCION==returnCategoriaHash ($2.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("La lectura no se puede guardar en una variable de categoria funcion.");
					return -1;
				}
				if(ESCALAR != returnClaseHash ($2.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("La lectura no se puede guardar en una variable de clase vector.");
					return -1;
				}
				escribirScanf ($2.lexema, returnTipoHash ($2.lexema,ts_global));
			}
			else{


			if(FUNCION==returnCategoriaHash ($2.lexema,ts_local))
			{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("La lectura no se puede guardar en una variable de categoria funcion.");
				return -1;
			}
			if(ESCALAR != returnClaseHash ($2.lexema,ts_local))
			{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("La lectura no se puede guardar en una variable de clase vector.");
				return -1;
			}
			escribirIdentificadorLocal (returnCategoriaHash ($2.lexema,ts_local),num_param_actual, returnPosParHash  ($2.lexema,ts_local),returnPosVarHash ($2.lexema,ts_local),en_explit);
			escribirScanfFuncion (returnTipoHash ($2.lexema,ts_local));
		}
	}
	fprintf(reg,";R54:\t<lectura> ::= scanf <identificador>\n");
	}

;
escritura: TOK_PRINTF exp {escribirPrint ($2.es_direccion,$2.tipo);fprintf(reg,";linea %d\n",linea);fprintf(reg,";R56:\t<escritura> ::= printf <exp>\n");}
;
retorno_funcion: TOK_RETURN exp {if(en_funcion==FALSE){error=-1;tipoErrorSemantico=0;yyerror("Sentencia de retorno fuera del cuerpo de una función.");return -1;}if($2.tipo!=returnTipoHash (nomfun,ts_global)){error=-1;tipoErrorSemantico=0;yyerror("Asignacion incompatible, la expresion de retorno tiene que tener el mismo tipo que la funcion.");return -1;}nretorno++;escribirRetorno ($2.es_direccion);fprintf(reg,";R61:\t<retorno_funcion> ::= return <exp>\n");}
;
exp: exp TOK_MAS exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=$1.tipo;$$.es_direccion=0;operacionesExp(SUMA, $1.es_direccion,$3.es_direccion);}else{error=-1;tipoErrorSemantico=0;yyerror("Operacion aritmetica con operandos boolean");return -1;}fprintf(reg,";R72:\t<exp> ::= <exp> + <exp>\n");}
	| exp TOK_MENOS exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=$1.tipo;$$.es_direccion=0;operacionesExp(RESTA, $1.es_direccion,$3.es_direccion);}else{error=-1;tipoErrorSemantico=0;yyerror("Operacion aritmetica con operandos boolean");return -1;}fprintf(reg,";R73:\t<exp> ::= <exp> - <exp>\n");}
	| exp TOK_DIVISION exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=$1.tipo;$$.es_direccion=0;operacionesExp(DIV, $1.es_direccion,$3.es_direccion);}else{error=-1;tipoErrorSemantico=0;yyerror("Operacion aritmetica con operandos boolean");return -1;}fprintf(reg,";R74:\t<exp> ::= <exp> / <exp>\n");}
	| exp TOK_ASTERISCO exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=$1.tipo;$$.es_direccion=0;operacionesExp(MULTI, $1.es_direccion,$3.es_direccion);}else{error=-1;tipoErrorSemantico=0;yyerror("Operacion aritmetica con operandos boolean");return -1;}fprintf(reg,";R75:\t<exp> ::= <exp> * <exp>\n");}
	| TOK_MENOS exp %prec MENOSU {if($2.tipo==INT){$$.tipo=$2.tipo;$$.es_direccion=0;operacionesExp(MENOS, $2.es_direccion,0);}else{error=-1;tipoErrorSemantico=0;yyerror("Operacion aritmetica con operandos boolean");return -1;}fprintf(reg,";R76:\t<exp> ::= - <exp>\n");}
	| exp TOK_AND exp {if($1.tipo==$3.tipo&&$1.tipo==BOOLEAN){$$.tipo=$1.tipo;$$.es_direccion=0;operacionesExp(AND, $1.es_direccion,$3.es_direccion);}else{error=-1;tipoErrorSemantico=0;yyerror("Operacion logica con operandos int.");return -1;}fprintf(reg,";R77:\t<exp> ::= <exp> && <exp>\n");}
	| exp TOK_OR exp {if($1.tipo==$3.tipo&&$1.tipo==BOOLEAN){$$.tipo=$1.tipo;$$.es_direccion=0;operacionesExp(OR, $1.es_direccion,$3.es_direccion);}else{error=-1;tipoErrorSemantico=0;yyerror("Operacion logica con operandos int.");return -1;}fprintf(reg,";R78:\t<exp> ::= <exp> || <exp>\n");}
	| TOK_NOT exp {if($2.tipo==BOOLEAN){$$.tipo=$2.tipo;$$.es_direccion=0;operacionesExp(NOT,$2.es_direccion,0);}else{error=-1;tipoErrorSemantico=0;yyerror("Operacion logica con operandos int.");return -1;}fprintf(reg,";R79:\t<exp> ::= ! <exp>\n");}
	| TOK_IDENTIFICADOR {
		if(local==FALSE)
		{
			if(!MiembroHash($1.lexema,ts_global))
			{
				error=-1;
				tipoErrorSemantico=1;
				yyerror($1.lexema);
				return -1;
			}
			if(FUNCION==returnCategoriaHash ($1.lexema,ts_global))
			{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("Expresion identificador de categoria funcion.");
				return -1;
			}
			if(ESCALAR != returnClaseHash ($1.lexema,ts_global))
			{
				error=-1;
				tipoErrorSemantico=0;
				if(en_explit==0)
				yyerror("Expresion identificador de clase vector.");
				else
				 yyerror("Parametro de funcion de tipo no escalar.");
				return -1;
			}

		$$.tipo=returnTipoHash ($1.lexema,ts_global);
		$$.es_direccion=1;
		escribirIdentificador($1.lexema,en_explit);
		}
		else
		{
				if(!MiembroHash($1.lexema,ts_local))
				{
					if(!MiembroHash($1.lexema,ts_global))
					{
						error=-1;
						tipoErrorSemantico=1;
						yyerror($1.lexema);
						return -1;
					}
					if(FUNCION==returnCategoriaHash ($1.lexema,ts_global))
					{
						error=-1;
						tipoErrorSemantico=0;
						yyerror("Expresion identificador de categoria funcion.");
						return -1;
					}
					if(ESCALAR != returnClaseHash ($1.lexema,ts_global))
					{
						error=-1;
						tipoErrorSemantico=0;
						if(en_explit==0)
							yyerror("Expresion identificador de clase vector.");
						else
							yyerror("Parametro de funcion de tipo no escalar.");
						return -1;
					}

					$$.tipo=returnTipoHash ($1.lexema,ts_global);
					$$.es_direccion=1;
					escribirIdentificador($1.lexema,en_explit);
			 }
				else
				{
					if(FUNCION==returnCategoriaHash ($1.lexema,ts_local))
					{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Expresion identificador de categoria funcion.");
					return -1;
				}
				if(ESCALAR != returnClaseHash ($1.lexema,ts_local))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Expresion identificador de clase vector.");
					return -1;
				}
				$$.es_direccion=1;


				escribirIdentificadorLocal (returnCategoriaHash ($1.lexema,ts_local),num_param_actual, returnPosParHash  ($1.lexema,ts_local),returnPosVarHash ($1.lexema,ts_local),llamada_dentro_funcion);

				$$.tipo=returnTipoHash ($1.lexema,ts_local);

			}
		}


		fprintf(reg,";R80:\t<exp> ::= <identificador>\n");}
	| constante {$$.tipo=$1.tipo;$$.es_direccion=$1.es_direccion;$$.valor_entero=$1.valor_entero;fprintf(reg,";R81:\t<exp> ::= <constante>\n");}
	| TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO {$$.tipo=$2.tipo;$$.es_direccion=$2.es_direccion;$$.valor_entero=$2.valor_entero;fprintf(reg,";R82:\t<exp> ::= ( <exp> )\n");}
	| TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO {$$.tipo=$2.tipo;$$.es_direccion=$2.es_direccion;$$.valor_entero=$2.valor_entero;fprintf(reg,";R83:\t<exp> ::= ( <comparacion> )\n");}
	| elemento_vector {$$.tipo=$1.tipo;$$.es_direccion=$1.es_direccion;$$.valor_entero=$1.valor_entero;fprintf(reg,";R85:\t<exp> ::= <elemento_vector>\n");}
	| idf_llamada_funcion TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO {
		llamada_dentro_funcion=0;
		if(local==FALSE)
		{
			if(num_parametros_llamada_actual!=returnNumParamHash ($1.lexema,ts_global))
			{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("Numero incorrecto de parametros en llamada a funcion.");
				return -1;
			}
		}
		else
		{
			if(strcmp(nomfun,$1.lexema)==0)
			{
				if(num_parametros_llamada_actual!=returnNumParamHash ($1.lexema,ts_local))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Numero incorrecto de parametros en llamada a funcion.");
					return -1;
				}
			}
			else
			{
				if(num_parametros_llamada_actual!=returnNumParamHash ($1.lexema,ts_global))
				{
					error=-1;
					tipoErrorSemantico=0;
					yyerror("Numero incorrecto de parametros en llamada a funcion.");
					return -1;
				}
			}
		}
		en_explit=0;
		$$.tipo=returnTipoHash ($1.lexema,ts_global);
		$$.es_direccion=0;
		escribirllamadafuncion($1.lexema, num_param_actual);

		fprintf(reg,";R88:\t<exp> ::= <identificador> ( <lista_expresiones> )\n");}
;
idf_llamada_funcion: TOK_IDENTIFICADOR{
		llamada_dentro_funcion=0;
		if(!MiembroHash($1.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=1;
			yyerror($1.lexema);
			return -1;
		}
		if(FUNCION!=returnCategoriaHash ($1.lexema,ts_global))
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("El identificador de llamada de funcion, no es de categoria funcion.");
			return -1;
		}
		if(en_explit==1)
		{
			error=-1;
			tipoErrorSemantico=0;
			yyerror("No esta permitido el uso de llamadas a funciones como parametros de otras funciones.");
			return -1;
		}
		if(strcmp(nomfun,$1.lexema)!=0)
			llamada_dentro_funcion=1;
	en_explit=1;
	num_parametros_llamada_actual=0;
	strcpy($$.lexema,$1.lexema);
 }
;
lista_expresiones: exp resto_lista_expresiones {num_parametros_llamada_actual++;fprintf(reg,";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n");}
		| /* VACIO */ {fprintf(reg,";R90:\t<lista_expresiones> ::=\n");}
;
resto_lista_expresiones: TOK_COMA exp resto_lista_expresiones {num_parametros_llamada_actual++;fprintf(reg,";R91:\t<resto_lista_expresiones> ::= , <exp> <resto_lista_expresiones>\n");}
			| /* VACIO */ {fprintf(reg,";R92:\t<resto_lista_expresiones> ::=\n");}
;
comparacion: exp TOK_IGUAL exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=BOOLEAN;$$.es_direccion=0;operacionesCmp(IGUAL, $1.es_direccion,$3.es_direccion,etiqueta);etiqueta++;}else{error=-1;tipoErrorSemantico=0;yyerror("Comparacion con operandos boolean.");return -1;}fprintf(reg,";R93:\t<comparacion> ::= <exp> == <exp>\n");}
	| exp TOK_DISTINTO exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=BOOLEAN;$$.es_direccion=0;operacionesCmp(DESIGUAL, $1.es_direccion,$3.es_direccion,etiqueta);etiqueta++;}else{error=-1;tipoErrorSemantico=0;yyerror("Comparacion con operandos boolean.");return -1;}fprintf(reg,";R94:\t<comparacion> ::= <exp> != <exp>\n");}
	| exp TOK_MENORIGUAL exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=BOOLEAN;$$.es_direccion=0;operacionesCmp(MENORIGUAL, $1.es_direccion,$3.es_direccion,etiqueta);etiqueta++;}else{error=-1;tipoErrorSemantico=0;yyerror("Comparacion con operandos boolean.");return -1;}fprintf(reg,";R95:\t<comparacion> ::= <exp> <= <exp>\n");}
	| exp TOK_MAYORIGUAL exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=BOOLEAN;$$.es_direccion=0;operacionesCmp(MAYORIGUAL, $1.es_direccion,$3.es_direccion,etiqueta);etiqueta++;}else{error=-1;tipoErrorSemantico=0;yyerror("Comparacion con operandos boolean.");return -1;}fprintf(reg,";R96:\t<comparacion> ::= <exp> >= <exp>\n");}
	| exp TOK_MENOR exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=BOOLEAN;$$.es_direccion=0;operacionesCmp(MENOR, $1.es_direccion,$3.es_direccion,etiqueta);etiqueta++;}else{error=-1;tipoErrorSemantico=0;yyerror("Comparacion con operandos boolean.");return -1;}fprintf(reg,";R97:\t<comparacion> ::= <exp> < <exp>\n");}
	| exp TOK_MAYOR exp {if($1.tipo==$3.tipo&&$1.tipo==INT){$$.tipo=BOOLEAN;$$.es_direccion=0;operacionesCmp(MAYOR, $1.es_direccion,$3.es_direccion,etiqueta);etiqueta++;}else{error=-1;tipoErrorSemantico=0;yyerror("Comparacion con operandos boolean.");return -1;}fprintf(reg,";R98:\t<comparacion> ::= <exp> > <exp>\n");}
;
constante: constante_logica {$$.es_direccion=$1.es_direccion;$$.tipo=$1.tipo;fprintf(reg,";R99:\t<constante> ::= <constante_logica>\n");}
	| constante_entera {$$.tipo=$1.tipo;$$.es_direccion=$1.es_direccion;$$.valor_entero=$1.valor_entero;fprintf(reg,";R100:\t<constante> ::= <constante_entera>\n");}
;
constante_logica: TOK_TRUE {$$.es_direccion=0;$$.tipo=BOOLEAN;insertarConst(1,linea);fprintf(reg,";R102:\t<constante_logica> ::= true\n");}
		| TOK_FALSE {$$.es_direccion=0;$$.tipo=BOOLEAN;insertarConst(0,linea);fprintf(reg,";R103:\t<constante_logica> ::= false\n");}
;
constante_entera: TOK_CONSTANTE_ENTERA {$$.tipo=INT;$$.es_direccion=0;insertarConst($1.valor_entero,linea);fprintf(reg,";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n");}
;
idpf: TOK_IDENTIFICADOR {

	if(FALSE==InsertarHash ($1.lexema,PARAMETRO,clase_actual,tipo_actual, tamanio_vector_actual, num_variables_locales_actual, pos_variable_local_actual,num_param_actual ,pos_param_actual , ts_local))
		{error=-1;
			tipoErrorSemantico=1;
			yyerror($1.lexema);
			return -1;
		}
		strcpy($$.lexema,$1.lexema);
		fprintf(reg,";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");
		num_param_actual++;
		pos_param_actual++;
 }
identificador: TOK_IDENTIFICADOR {
	if(error==-1){
		tipoErrorSemantico=2;
		yyerror($1.lexema);
		return -1;
	}

	if(local==FALSE)
	{
		if(FALSE==InsertarHash ($1.lexema,VARIABLE,clase_actual,tipo_actual, tamanio_vector_actual, num_variables_locales_actual, pos_variable_local_actual,num_param_actual ,pos_param_actual , ts_global))
			{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("Declaracion duplicada.");
				return -1;
			}
		fprintf(auxident,"%s\n",$1.lexema);
  }
	else{
		if (!MiembroHash($1.lexema,ts_local))
		{
			if(clase_actual==ESCALAR)
			{
				InsertarHash($1.lexema,VARIABLE,clase_actual,tipo_actual, tamanio_vector_actual, num_variables_locales_actual, pos_variable_local_actual,num_param_actual ,pos_param_actual , ts_local);
				pos_variable_local_actual++;
				num_variables_locales_actual++;
			}
			else
			{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("Variable local de tipo no escalar.");
				return -1;
			}
		}
		else
		{
				error=-1;
				tipoErrorSemantico=0;
				yyerror("Declaracion duplicada.");
				return -1;
		}
 }
  strcpy($$.lexema,$1.lexema);fprintf(reg,";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");

 }
;
%%
void yyerror(char const *cadena)
{
	if(error==-1)
	{
		if (tipoErrorSemantico==0)
			fprintf(stderr,"****Error semantico en lin %d: %s\n",linea,cadena);
		else if (tipoErrorSemantico==1)
			fprintf(stderr,"****Error semantico en lin %d: Acceso a variable no declarada (%s).\n",linea,cadena);
		else if (tipoErrorSemantico==2)
			fprintf(stderr,"****Error semantico en lin %d: El tamanyo del vector <%s> excede los limites permitidos (1,64).\n",linea,cadena);
		else
			fprintf(stderr,"****Error semantico en lin %d: Funcion <%s> sin sentencia de retorno.\n",linea,cadena);
	}
	else if(error == 0)
		fprintf(stderr,"**** Error sintactico en [lin %d, col %d]\n",linea,columna-yyleng);
	error = 0;
	destruirTablaHash(ts_global);
	if(reg!=NULL)
		fclose(reg);
	if(local==TRUE)
		destruirTablaHash(ts_local);
	system("rm auxident.txt");

}
