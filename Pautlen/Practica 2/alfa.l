%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "tokens.h"
	int linea=1,columna=1;
%}
%option noyywrap
DIGITO[0-9]
LETRAS [a-zA-Z]
LETDIG [a-zA-Z0-9]
%%
"//".*	{columna+=yyleng;return TOK_COMENTARIO;}
"main"	{columna+=yyleng;return TOK_MAIN;}
"int"	{columna+=yyleng;return TOK_INT;}
"boolean"	{columna+=yyleng;return TOK_BOOLEAN;}
"array"	{columna+=yyleng;return TOK_ARRAY;}
"function"	{columna+=yyleng;return TOK_FUNCTION;}
"if"	{columna+=yyleng;return TOK_IF;}
"else"	{columna+=yyleng;return TOK_ELSE;}
"while"	{columna+=yyleng;return TOK_WHILE;}
"scanf"	{columna+=yyleng;return TOK_SCANF;}
"printf"	{columna+=yyleng;return TOK_PRINTF;}
"return"	{columna+=yyleng;return TOK_RETURN;}
";"	{columna+=yyleng;return TOK_PUNTOYCOMA;}
","	{columna+=yyleng;return TOK_COMA;}
"("	{columna+=yyleng;return TOK_PARENTESISIZQUIERDO;}
")"	{columna+=yyleng;return TOK_PARENTESISDERECHO;}
"["	{columna+=yyleng;return TOK_CORCHETEIZQUIERDO;}
"]"	{columna+=yyleng;return TOK_CORCHETEDERECHO;}
"{"	{columna+=yyleng;return TOK_LLAVEIZQUIERDA;}
"}"	{columna+=yyleng;return TOK_LLAVEDERECHA;}
"=="	{columna+=yyleng;return TOK_IGUAL;}
"="	{columna+=yyleng;return TOK_ASIGNACION;}
"+"	{columna+=yyleng;return TOK_MAS;}
"-"	{columna+=yyleng;return TOK_MENOS;}
"*"	{columna+=yyleng;return TOK_ASTERISCO;}
"/"	{columna+=yyleng;return TOK_DIVISION;}
"&&"	{columna+=yyleng;return TOK_AND;}
"||"	{columna+=yyleng;return TOK_OR;}
"!="	{columna+=yyleng;return TOK_DISTINTO;}
"!"	{columna+=yyleng;return TOK_NOT;}
"<="	{columna+=yyleng;return TOK_MENORIGUAL;}
">="	{columna+=yyleng;return TOK_MAYORIGUAL;}
">"	{columna+=yyleng;return TOK_MAYOR;}
"<"	{columna+=yyleng;return TOK_MENOR;}
"true"	{columna+=yyleng;return TOK_TRUE;}
"false"	{columna+=yyleng;return TOK_FALSE;}
"\t"	{columna+=yyleng;}
" "	{columna+=yyleng;}
"\n"	{linea++;columna=1;}
{LETRAS}({LETDIG})*	{columna+=yyleng;return TOK_IDENTIFICADOR;}
({DIGITO})+	{columna+=yyleng;return TOK_CONSTANTE_ENTERA;}
.	{columna+=yyleng;return TOK_ERROR;}
%%
int main(int argc, char **argv){
	int variable=0;	
	yyin=fopen(argv[1],"r");
	yyout=fopen(argv[2],"w");
	do{	
		variable=yylex();
		switch(variable)
		{
			case TOK_MAIN:
				fprintf(yyout,"TOK_MAIN\t%d\t%s\n",TOK_MAIN,yytext);
				break;		
			case TOK_INT:
				fprintf(yyout,"TOK_INT\t%d\t%s\n",TOK_INT,yytext);
			break;
			case TOK_BOOLEAN:
				fprintf(yyout,"TOK_BOOLEAN\t%d\t%s\n",TOK_BOOLEAN,yytext);
			break;
			case TOK_ARRAY:
				fprintf(yyout,"TOK_ARRAY\t%d\t%s\n",TOK_ARRAY,yytext);
			break;
			case TOK_FUNCTION:
				fprintf(yyout,"TOK_FUNCTION\t%d\t%s\n",TOK_FUNCTION,yytext);
			break;
			case TOK_IF:
				fprintf(yyout,"TOK_IF\t%d\t%s\n",TOK_IF,yytext);
				break;
			case TOK_ELSE:
				fprintf(yyout,"TOK_ELSE\t%d\t%s\n",TOK_ELSE,yytext);
				break;
			case TOK_WHILE:
				fprintf(yyout,"TOK_WHILE\t%d\t%s\n",TOK_WHILE,yytext);
				break;
			case TOK_SCANF:
				fprintf(yyout,"TOK_SCANF\t%d\t%s\n",TOK_SCANF,yytext);
				break;
			case TOK_PRINTF:
				fprintf(yyout,"TOK_PRINTF\t%d\t%s\n",TOK_PRINTF,yytext);
				break;			
			case TOK_RETURN:
				fprintf(yyout,"TOK_RETURN\t%d\t%s\n",TOK_RETURN,yytext);
				break;			
			case TOK_COMENTARIO:
				break;
			case TOK_PUNTOYCOMA:
				fprintf(yyout,"TOK_PUNTOYCOMA\t%d\t%s\n",TOK_PUNTOYCOMA,yytext);
				break;
			case TOK_COMA:
				fprintf(yyout,"TOK_COMA\t%d\t%s\n",TOK_COMA,yytext);
				break;
			case TOK_PARENTESISIZQUIERDO:
				fprintf(yyout,"TOK_PARENTESISIZQUIERDO\t%d\t%s\n",TOK_PARENTESISIZQUIERDO,yytext);
				break;
			case TOK_PARENTESISDERECHO:
				fprintf(yyout,"TOK_PARENTESISDERECHO\t%d\t%s\n",TOK_PARENTESISDERECHO,yytext);
				break;
			case TOK_CORCHETEIZQUIERDO:
				fprintf(yyout,"TOK_CORCHETEIZQUIERDO\t%d\t%s\n",TOK_CORCHETEIZQUIERDO,yytext);
				break;
			case TOK_CORCHETEDERECHO:
				fprintf(yyout,"TOK_CORCHETEDERECHO\t%d\t%s\n",TOK_CORCHETEDERECHO,yytext);
				break;
			case TOK_LLAVEIZQUIERDA:
				fprintf(yyout,"TOK_LLAVEIZQUIERDA\t%d\t%s\n",TOK_LLAVEIZQUIERDA,yytext);
				break;
			case TOK_LLAVEDERECHA:
				fprintf(yyout,"TOK_LLAVEDERECHA\t%d\t%s\n",TOK_LLAVEDERECHA,yytext);
				break;
			case TOK_ASIGNACION:
				fprintf(yyout,"TOK_ASIGNACION\t%d\t%s\n",TOK_ASIGNACION,yytext);
				break;
			case TOK_MAS:
				fprintf(yyout,"TOK_MAS\t%d\t%s\n",TOK_MAS,yytext);
				break;
			case TOK_MENOS:
				fprintf(yyout,"TOK_MENOS\t%d\t%s\n",TOK_MENOS,yytext);
				break;
			case TOK_DIVISION:
				fprintf(yyout,"TOK_DIVISION\t%d\t%s\n",TOK_DIVISION,yytext);
				break;
			case TOK_ASTERISCO:
				fprintf(yyout,"TOK_ASTERISCO\t%d\t%s\n",TOK_ASTERISCO,yytext);
				break;
			case TOK_AND:
				fprintf(yyout,"TOK_AND\t%d\t%s\n",TOK_AND,yytext);
				break;
			case TOK_OR:
				fprintf(yyout,"TOK_OR\t%d\t%s\n",TOK_OR,yytext);
				break;
			case TOK_NOT:
				fprintf(yyout,"TOK_NOT\t%d\t%s\n",TOK_NOT,yytext);
				break;
			case TOK_IGUAL:
				fprintf(yyout,"TOK_IGUAL\t%d\t%s\n",TOK_IGUAL,yytext);
				break;
			case TOK_DISTINTO:
				fprintf(yyout,"TOK_DISTINTO\t%d\t%s\n",TOK_DISTINTO,yytext);
				break;
			case TOK_MENORIGUAL:
				fprintf(yyout,"TOK_MENORIGUAL\t%d\t%s\n",TOK_MENORIGUAL,yytext);
				break;
			case TOK_MAYORIGUAL:
				fprintf(yyout,"TOK_MAYORIGUAL\t%d\t%s\n",TOK_MAYORIGUAL,yytext);
				break;
			case TOK_MENOR:
				fprintf(yyout,"TOK_MENOR\t%d\t%s\n",TOK_MENOR,yytext);
				break;
			case TOK_MAYOR:
				fprintf(yyout,"TOK_MAYOR\t%d\t%s\n",TOK_MAYOR,yytext);
				break;
			case TOK_IDENTIFICADOR:
				if(yyleng<=100)
				fprintf(yyout,"TOK_IDENTIFICADOR\t%d\t%s\n",TOK_IDENTIFICADOR,yytext);
				else
				fprintf(yyout,"****Error en [lin %d, col %d]: identificador demasiado largo (%s)\nTOK_ERROR\t%d\t%s \n",linea,columna-yyleng,yytext,TOK_ERROR,yytext);
				break;
			case TOK_CONSTANTE_ENTERA:
				fprintf(yyout,"TOK_CONSTANTE_ENTERA\t%d\t%s\n",TOK_CONSTANTE_ENTERA,yytext);
				break;
			case TOK_TRUE:
				fprintf(yyout,"TOK_TRUE\t%d\t%s\n",TOK_TRUE,yytext);
				break;
			case TOK_FALSE:
				fprintf(yyout,"TOK_FALSE\t%d\t%s\n",TOK_FALSE,yytext);
				break;
			case TOK_ERROR:
				fprintf(yyout,"****Error en [lin %d, col %d]: simbolo no permitido (%s)\nTOK_ERROR\t%d\t%s \n",linea,columna-yyleng,yytext,TOK_ERROR,yytext);
				break;
			default:
			
			break;
		}
	}while(variable);
	fclose(yyout);
	fclose(yyin);
	return 0;
}
