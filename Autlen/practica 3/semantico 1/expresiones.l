%{
	#include "expresiones.h"
	#include "y.tab.h"
%}
%option noyywrap
DIGITO [0-9]
%%
"+"	{fprintf(yyout,"SIMBOLO: %c\n",yytext[0]);return TOK_SUMA;}
"-"	{fprintf(yyout,"SIMBOLO: %c\n",yytext[0]);return TOK_MENOS;}
"*"	{fprintf(yyout,"SIMBOLO: %c\n",yytext[0]);return TOK_MULTIPLICAR;}
"/"	{fprintf(yyout,"SIMBOLO: %c\n",yytext[0]);return TOK_DIVISION;}
"("	{fprintf(yyout,"SIMBOLO: %c\n",yytext[0]);return TOK_PA;}
")"	{fprintf(yyout,"SIMBOLO: %c\n",yytext[0]);return TOK_PC;}
({DIGITO})+	{yylval.atributos.valor_e=atoi(yytext);yylval.atributos.tipo=TOK_ENTERO;fprintf(yyout,"ENTERO: %s\n",yytext);return TOK_ENTERO;}
({DIGITO})+"."({DIGITO})+	{yylval.atributos.valor_r=atof(yytext);yylval.atributos.tipo=TOK_REAL;fprintf(yyout,"REAL: %s\n",yytext);return TOK_REAL;}
" "|"\t"|"\n"
.	{return -1;}
%%
