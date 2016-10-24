%{
	#include "expresiones.h"
	int yyerror(char const *cad);
	extern FILE *yyin;
	extern FILE *yyout;
	extern int yylex();
	extern int yyleng;
%}
%union
	{
	tipo_atributos atributos;
	}
%token <atributos> TOK_ENTERO
%token <atributos> TOK_REAL
%token TOK_PA
%token TOK_PC
%token TOK_SUMA
%token TOK_MENOS
%token TOK_MULTIPLICAR
%token TOK_DIVISION
%left TOK_SUMA TOK_MENOS
%left TOK_MULTIPLICAR TOK_DIVISION
%right MENOSU
%type <atributos> exp
%type <atributos> constante
%start exp_prn
%%
exp_prn: exp {if($1.tipo==TOK_REAL){fprintf(yyout,"resultado -> <%f>\n",$1.valor_r);}else{fprintf(yyout,"resultado -> <%d>\n",$1.valor_e);}}
;
exp: exp TOK_SUMA exp {
	if($1.tipo==$3.tipo && $1.tipo==TOK_REAL)
	{$$.tipo=$1.tipo;$$.valor_r=$1.valor_r+$3.valor_r;fprintf(yyout,"<%f> -> <%f> + <%f>\n",$$.valor_r,$1.valor_r,$3.valor_r);}
	else if($1.tipo==$3.tipo && $1.tipo==TOK_ENTERO)
	{$$.tipo=$1.tipo;$$.valor_e=$1.valor_e+$3.valor_e;fprintf(yyout,"<%d> -> <%d> + <%d>\n",$$.valor_e,$1.valor_e,$3.valor_e);}
	else
	{return yyerror("CRUCE DE TIPOS");}
	}
	| exp TOK_MENOS exp	{
	if($1.tipo==$3.tipo && $1.tipo==TOK_REAL)
		{$$.tipo=$1.tipo;$$.valor_r=$1.valor_r-$3.valor_r;fprintf(yyout,"<%f> -> <%f> - <%f>\n",$$.valor_r,$1.valor_r,$3.valor_r);}
	else if($1.tipo==$3.tipo && $1.tipo==TOK_ENTERO)
		{$$.tipo=$1.tipo;$$.valor_e=$1.valor_e-$3.valor_e;fprintf(yyout,"<%d> -> <%d> - <%d>\n",$$.valor_e,$1.valor_e,$3.valor_e);}
	else
		{return yyerror("CRUCE DE TIPOS");}
	}
	| exp TOK_MULTIPLICAR exp	{
	if($1.tipo==$3.tipo && $1.tipo==TOK_REAL)
		{$$.tipo=$1.tipo;$$.valor_r=$1.valor_r*$3.valor_r;fprintf(yyout,"<%f> -> <%f> * <%f>\n",$$.valor_r,$1.valor_r,$3.valor_r);}
	else if($1.tipo==$3.tipo && $1.tipo==TOK_ENTERO)
		{$$.tipo=$1.tipo;$$.valor_e=$1.valor_e*$3.valor_e;fprintf(yyout,"<%d> -> <%d> * <%d>\n",$$.valor_e,$1.valor_e,$3.valor_e);}
	else
		{return yyerror("CRUCE DE TIPOS");}
	}
	| exp TOK_DIVISION exp	{
	if($1.tipo==$3.tipo && $1.tipo==TOK_REAL)
		{$$.tipo=$1.tipo;$$.valor_r=$1.valor_r/$3.valor_r;fprintf(yyout,"<%f> -> <%f> / <%f>\n",$$.valor_r,$1.valor_r,$3.valor_r);}
	else if($1.tipo==$3.tipo && $1.tipo==TOK_ENTERO)
		{$$.tipo=$1.tipo;$$.valor_e=$1.valor_e/$3.valor_e;fprintf(yyout,"<%d> -> <%d> / <%d>\n",$$.valor_e,$1.valor_e,$3.valor_e);}
	else
		{return yyerror("CRUCE DE TIPOS");}
	}
	| TOK_MENOS exp	%prec MENOSU{
		if($2.tipo==TOK_REAL)
		{
		$$.valor_r=-$2.valor_r;$$.tipo=$2.tipo;fprintf(yyout,"<%f> -> - <%f>\n",$$.valor_r,$2.valor_r);
		}
		else
		{$$.valor_e=-$2.valor_e;$$.tipo=$2.tipo;fprintf(yyout,"<%d> -> - <%d>\n",$$.valor_e,$2.valor_e);}
		}
	| TOK_PA exp TOK_PC{
		if($2.tipo==TOK_REAL)
		{
		$$.valor_r=$2.valor_r;$$.tipo=$2.tipo;fprintf(yyout,"<%f> -> (<%f>)\n",$$.valor_r,$2.valor_r);
		}
		else
		{$$.valor_e=$2.valor_e;$$.tipo=$2.tipo;fprintf(yyout,"<%d> -> - (<%d>)\n",$$.valor_e,$2.valor_e);}
		}
	| constante {$$.tipo=$1.tipo;if($1.tipo==TOK_REAL){$$.valor_r=$1.valor_r;}else{$$.valor_e=$1.valor_e;}}
;
constante: TOK_ENTERO {$$.tipo=$1.tipo;$$.valor_e=$1.valor_e;}
			| TOK_REAL	{$$.tipo=$1.tipo;$$.valor_r=$1.valor_r;}
;
%%
int yyerror (char const *cad)
{
	printf("\n%s\n",cad);
	return -1;
}

int main (int argc, char **argv)
{
	if(argc!=3)
	{
		printf("\n ERROR PARAMETROS\n\t./expresiones ficheroentrada ficherosalida\n");
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
