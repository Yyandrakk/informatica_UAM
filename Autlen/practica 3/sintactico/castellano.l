%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"
	#include <string.h>
%}
%option noyywrap
%%
"el"|"El"|"las"|"Las"|"los"|"Los"|"La"|"la"	{strcpy(yylval.cadena,yytext);fprintf(yyout,"ARTICULO:\t%s\n",yytext);return ARTICULO;}
"chico"|"yo"|"Yo"|"tu"|"Tu"|"chicos"|"Chicos"|"Chico"|"chicas"|"Chicas"|"chica"|"Chica"|"manzanas"|"Manzanas"|"carne"|"Carne"|"casa"|"Casa"	{strcpy(yylval.cadena,yytext);fprintf(yyout,"NOMBRE:\t%s\n",yytext);return NOMBRE;}
"como"|"Como"|"comes"|"Comes"|"comen"|"Comen"|"come"|"Come"	{strcpy(yylval.cadena,yytext);fprintf(yyout,"VERBO:\t%s\n",yytext);return VERBO;}
"en"|"de"|"En"|"De"	{strcpy(yylval.cadena,yytext);fprintf(yyout,"PREPOSICION:\t%s\n",yytext);return PREPOSICION;}
"."	{strcpy(yylval.cadena,yytext);fprintf(yyout,"SEPARADOR ORACIONES\t%s\n",yytext);return SEPARADOR;}
" "|"\t"|"\n" {;}
.	{return -1;}
%%
