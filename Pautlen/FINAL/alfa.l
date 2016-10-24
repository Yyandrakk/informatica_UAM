%{
	#include "alfa.h"
	#include "y.tab.h"
	int linea=1,columna=1;
	int error=0;
	extern FILE *reg;
%}
%option noyywrap
DIGITO[0-9]
LETRAS [a-zA-Z]
LETDIG [a-zA-Z0-9]
%%
"//".*	{columna+=yyleng;}
"main"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_MAIN;}
"int"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_INT;}
"boolean"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_BOOLEAN;}
"array"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_ARRAY;}
"function"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_FUNCTION;}
"if"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_IF;}
"else"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_ELSE;}
"while"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_WHILE;}
"scanf"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_SCANF;}
"printf"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_PRINTF;}
"return"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_RETURN;}
";"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_PUNTOYCOMA;}
","	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_COMA;}
"("	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_PARENTESISIZQUIERDO;}
")"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_PARENTESISDERECHO;}
"["	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_CORCHETEIZQUIERDO;}
"]"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_CORCHETEDERECHO;}
"{"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_LLAVEIZQUIERDA;}
"}"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_LLAVEDERECHA;}
"=="	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_IGUAL;}
"="	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_ASIGNACION;}
"+"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_MAS;}
"-"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_MENOS;}
"*"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_ASTERISCO;}
"/"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_DIVISION;}
"&&"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_AND;}
"||"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_OR;}
"!="	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_DISTINTO;}
"!"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_NOT;}
"<="	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_MENORIGUAL;}
">="	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_MAYORIGUAL;}
">"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_MAYOR;}
"<"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_MENOR;}
"true"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_TRUE;}
"false"	{columna+=yyleng;fprintf(reg,";D:\t%s\n",yytext);return TOK_FALSE;}
"\t"	{columna+=yyleng;}
" "	{columna+=yyleng;}
"\r\n"	{linea++;columna=1;}
"\n"	{linea++;columna=1;}
{LETRAS}({LETDIG})*	{columna+=yyleng;strcpy(yylval.atributos.lexema,yytext);if(yyleng<=100){fprintf(reg,";D:\t%s\n",yytext);}else{fprintf(stderr,"****Error en [lin %d, col %d]: identificador demasiado largo (%s)\n",linea,columna-yyleng,yytext);error=1;return TOK_ERROR;};return TOK_IDENTIFICADOR;}
({DIGITO})+	{columna+=yyleng;yylval.atributos.valor_entero=atoi(yytext);fprintf(reg,";D:\t%s\n",yytext);return TOK_CONSTANTE_ENTERA;}
.	{error=1;columna+=yyleng;fprintf(stderr,"****Error en [lin %d, col %d]: simbolo no permitido (%s)\n",linea,columna-yyleng,yytext);return TOK_ERROR;}
%%
