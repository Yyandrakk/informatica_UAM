%{

	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror(char const *cad);
	extern FILE *yyin;
	extern FILE *yyout;
	extern int yylex();
	extern int yyleng;
%}
%union
	{
	char cadena[1000];
	}
%token ARTICULO
%token NOMBRE
%token VERBO
%token PREPOSICION
%token SEPARADOR
%start texto
%%
texto: oracion SEPARADOR {fprintf(yyout,"<texto> -> <oracion> .\n");}
	| oracion SEPARADOR texto {fprintf(yyout,"<texto> -> <oracion> . <texto>\n");}
;
oracion: sujeto predicado {fprintf(yyout,"<oracion> -> <sujeto> <predicado>\n");}
	| predicado sujeto {fprintf(yyout,"<oracion> -> <predicado> <sujeto>\n");}
;
sujeto: grupo_nombre {fprintf(yyout,"<sujeto> -> <grupo_nombre> .\n");}
;
grupo_nombre: articulo nombre {fprintf(yyout,"<grupo_nombre> -> <articulo> <nombre>\n");}
	| nombre {fprintf(yyout,"<grupo_nombre> -> <nombre>\n");}
;
predicado: verbo complemento {fprintf(yyout,"<predicado> -> <verbo> <complemento>\n");}
;
complemento: preposicion grupo_nombre {fprintf(yyout,"<complemento> -> <preposicion> <grupo_nombre>\n");}
	| grupo_nombre {fprintf(yyout,"<complemento> -> <grupo_nombre>\n");}
;
articulo: ARTICULO {;}
;
nombre: NOMBRE {;}
;
verbo: VERBO {;}
;
preposicion: PREPOSICION {;} 
;
%%
void yyerror (char const *cad)
{
	printf("\nERROR\n");
}

int main (int argc, char **argv)
{
	if(argc!=3)
	{
		printf("\n ERROR PARAMETROS\n\t./castellano ficheroentrada ficherosalida\n");
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
