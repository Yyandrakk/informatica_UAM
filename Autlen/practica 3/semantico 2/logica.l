%{
	#include "logica.h"
	#include "y.tab.h"

%}
%option noyywrap
DIGITO [0-9]
LETRA [a-z]
%%
"AND"	{yylval.atributos.conj=C1;return TOK_AND;}
"OR"	{yylval.atributos.conj=C1;return TOK_OR;}
"NAND"	{yylval.atributos.conj=C2;return TOK_NAND;}
"NOR"	{yylval.atributos.conj=C3;return TOK_NOR;}
"NOT"	{yylval.atributos.conj=C1;return TOK_NOT;}
"("	{return TOK_PA;}
")"	{return TOK_PC;}
";" {return TOK_PUNTOYCOMA;}
"T"	{return TOK_TRUE;}
"F"	{return TOK_FALSE;}
{LETRA} {yylval.atributos.letra=yytext[0];return TOK_MINUS;}
" "|"\t"|"\n" {}
.	{}
%%
