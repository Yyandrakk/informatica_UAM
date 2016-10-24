%{

	#include "logica.h"
	#define error -1;
	int yyerror(char const *cad);
	extern FILE *yyin;
	extern FILE *yyout;
	extern int yylex();
	extern int yyleng;
	int tamano=0;
	BOOL var=FALSE,formada=TRUE;
%}
%union
	{
	tipo_atributos atributos;
	}
%token <atributos> TOK_MINUS
%token TOK_TRUE
%token TOK_FALSE
%token TOK_PA
%token TOK_PC
%token <atributos> TOK_OR
%token <atributos> TOK_NOR
%token <atributos> TOK_AND
%token <atributos> TOK_NAND
%token <atributos> TOK_NOT
%token TOK_PUNTOYCOMA
%type <atributos> exp
%type <atributos> constante
%type <atributos> variable
%type <atributos> minuscula
%left TOK_OR TOK_NOR
%left TOK_AND TOK_NAND
%right TOK_NOT
%start s
%%
s: exp TOK_PUNTOYCOMA {

	if(formada==TRUE)
	fprintf(yyout,"LA EXPRESION ESTA BIEN FORMADA Y PERTENECE AL CONJUNTO %d\n",$1.conj);
	else{
		fprintf(yyout,"LA ESTA MAL FORMADA\n");
	}
	if (var==TRUE)
	 fprintf(yyout,"LA EXPRESION NO ES EVALUABLE\n\n");
	else if($1.valor==TRUE)
	fprintf(yyout,"LA EXPRESION VALE T\n\n");
	else
	fprintf(yyout,"LA EXPRESION VALE F\n\n");

	var=FALSE;
	formada=TRUE;
	tamano=0;
}
	| exp TOK_PUNTOYCOMA s {
	if(formada==TRUE)
		fprintf(yyout,"LA EXPRESION ESTA BIEN FORMADA Y PERTENECE AL CONJUNTO %d\n",$1.conj);
	else
		fprintf(yyout,"LA ESTA MAL FORMADA\n");

	if (var==TRUE)
		fprintf(yyout,"LA EXPRESION NO ES EVALUABLE\n\n");
	else if($1.valor==TRUE)
		fprintf(yyout,"LA EXPRESION VALE T\n\n");
	else
		fprintf(yyout,"LA EXPRESION VALE F\n\n");

	var=FALSE;
	formada=TRUE;
	tamano=0;
	}
;
exp: exp TOK_AND exp {printf("1\n");$$.conj=$2.conj;if(($1.conj!=$2.conj&&$1.conj!=C0)||($3.conj!=$2.conj&&$3.conj!=C0)){formada=FALSE;}if($1.valor==TRUE&&$1.valor==TRUE){$$.valor=TRUE;}else{$$.valor=FALSE;};}
	| exp TOK_OR exp {printf("2\n");$$.conj=$2.conj;if(($1.conj!=$2.conj&&$1.conj!=C0)||($3.conj!=$2.conj&&$3.conj!=C0)){formada=FALSE;}if($1.valor==FALSE && $3.valor==FALSE){$$.valor==FALSE;}else{$$.valor==TRUE;};}
	| exp TOK_NAND exp {printf("3\n");$$.conj=$2.conj;if(($1.conj!=$2.conj&&$1.conj!=C0)||($3.conj!=$2.conj&&$3.conj!=C0)){formada=FALSE;}if($1.valor==TRUE && $3.valor==TRUE){$$.valor==FALSE;}else{$$.valor==TRUE;};}
	| exp TOK_NOR exp {printf("4\n");$$.conj=$2.conj;if(($1.conj!=$2.conj&&$1.conj!=C0)||($3.conj!=$2.conj&&$3.conj!=C0)){formada=FALSE;}if($1.valor==FALSE&&$1.valor==FALSE){$$.valor=TRUE;}else{$$.valor=FALSE;};}
	| TOK_NOT exp {printf("5\n");$$.conj=$1.conj;if($2.valor==TRUE){$$.valor=FALSE;}else{$$.valor=TRUE;}}
	| TOK_PA exp TOK_PC {printf("6\n");$$.valor=$2.valor;strcpy($$.variable,$2.variable);$$.conj=$2.conj;}
	| constante {printf("7\n");$$.conj=C0;$$.valor=$1.valor;}
	| variable {printf("8\n");var=TRUE;$$.conj=C0;strcpy($$.variable,$1.variable);}
;
constante: TOK_TRUE {$$.valor=TRUE;}
	| TOK_FALSE {$$.valor=FALSE;}
;
variable : minuscula {$$.variable[tamano-1]=$1.variable[tamano-1];}
	|	minuscula variable {strcpy($$.variable,$2.variable);$$.variable[tamano-1]=$1.variable[tamano-1];}
;
minuscula: TOK_MINUS {$$.variable[tamano]=$1.letra;tamano++;}
;
%%
int yyerror (char const *cad)
{
	fprintf(yyout,"ERROR");
	return -1;
}

int main (int argc, char **argv)
{
	if(argc!=3)
	{
		printf("\n ERROR PARAMETROS\n\t./logica ficheroentrada ficherosalida\n");
		return 0;
	}
	yyin=fopen(argv[1],"r");
	yyout=fopen(argv[2],"w");
	if(yyparse()!=0)
		printf("\nERROR\n");
	else
		printf("\nEXITO\n");
	fclose(yyout);
	fclose(yyin);
	return 0;
}
