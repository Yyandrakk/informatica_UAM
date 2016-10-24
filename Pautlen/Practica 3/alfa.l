%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"
	#include <string.h>
	int linea=1,columna=1;
	int error=0;

%}
%option noyywrap
DIGITO[0-9]
LETRAS [a-zA-Z]
LETDIG [a-zA-Z0-9]
%%
"//".*	{columna+=yyleng;}
"main"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_MAIN;}
"int"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_INT;}
"boolean"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_BOOLEAN;}
"array"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_ARRAY;}
"function"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_FUNCTION;}
"if"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_IF;}
"else"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_ELSE;}
"while"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_WHILE;}
"scanf"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_SCANF;}
"printf"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_PRINTF;}
"return"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_RETURN;}
";"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_PUNTOYCOMA;}
","	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_COMA;}
"("	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_PARENTESISIZQUIERDO;}
")"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_PARENTESISDERECHO;}
"["	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_CORCHETEIZQUIERDO;}
"]"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_CORCHETEDERECHO;}
"{"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_LLAVEIZQUIERDA;}
"}"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_LLAVEDERECHA;}
"=="	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_IGUAL;}
"="	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_ASIGNACION;}
"+"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_MAS;}
"-"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_MENOS;}
"*"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_ASTERISCO;}
"/"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_DIVISION;}
"&&"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_AND;}
"||"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_OR;}
"!="	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_DISTINTO;}
"!"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_NOT;}
"<="	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_MENORIGUAL;}
">="	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_MAYORIGUAL;}
">"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_MAYOR;}
"<"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_MENOR;}
"true"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_TRUE;}
"false"	{columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_FALSE;}
"\t"	{columna+=yyleng;}
" "	{columna+=yyleng;}
"\n"	{linea++;columna=1;}
{LETRAS}({LETDIG})*	{columna+=yyleng;strcpy(yylval.cadena,yytext);if(yyleng<=100){fprintf(yyout,";D:\t%s\n",yytext);}else{fprintf(stdout,"****Error en [lin %d, col %d]: identificador demasiado largo (%s)\n",linea,columna-yyleng,yytext);error=1;return TOK_ERROR;};return TOK_IDENTIFICADOR;}
({DIGITO})+	{columna+=yyleng;yylval.numero=atoi(yytext);fprintf(yyout,";D:\t%s\n",yytext);return TOK_CONSTANTE_ENTERA;}
.	{error=1;columna+=yyleng;strcpy(yylval.cadena,yytext);fprintf(stdout,"****Error en [lin %d, col %d]: simbolo no permitido (%s)\n",linea,columna-yyleng,yytext);return TOK_ERROR;}
%%
