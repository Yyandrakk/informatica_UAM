%{
	#include <stdlib.h>
	#include <string.h>
	    typedef enum {
		FIJO = 1,
		INFORMACION = 2,
		MOVIL=3,
		ESPECIAL=4,
		INTERNACIONAL=5,
		GRATIS=6,
		MINUTOS=7
			} TARIFA;
%}
%option noyywrap
DIGITO[0-9]
SEPARADOR [ \t\n]
%%
9[1-9]({DIGITO}{7})	{return FIJO;}
11({DIGITO}{3})	{return INFORMACION;}
6({DIGITO}{8})	{return MOVIL;}
[803|806|807|901|902|905]({DIGITO}{6})	{return ESPECIAL;}
"+"({DIGITO}{2})[9[1-9]({DIGITO}{7})|6({DIGITO}{8})] {return INTERNACIONAL;}
[0|1]({DIGITO}{2})	{return GRATIS;}
{DIGITO}"."{DIGITO}	{return MINUTOS;}
.
%%
int main(int argc, char **argv){
	int variable=0,numf=0,numm=0,numi=0,nume=0,numin=0,numg=0,control=0;
	double minf=0,minm=0,mini=0,mine=0,minin=0,ming=0;

	yyin=fopen(argv[1],"r");
	yyout=fopen(argv[2],"w");


	do{
		variable=yylex();
		switch(variable)
		{
			case FIJO:
				variable=yylex();

				if(variable==MINUTOS)
				{

					minf+=atof(yytext);
					numf++;

				}
			break;

			case INFORMACION:
				variable=yylex();

				if(variable==MINUTOS)
				{

					mini+=atof(yytext);
					numi++;

				}
			break;

			case MOVIL:
				variable=yylex();

				if(variable==MINUTOS)
				{

					minm+=atof(yytext);
					numm++;

				}

			break;

			case ESPECIAL:
				variable=yylex();

				if(variable==MINUTOS)
				{

					mine+=atof(yytext);
					nume++;

				}

			break;

			case INTERNACIONAL:
				variable=yylex();

				if(variable==MINUTOS)
				{

					minin+=atof(yytext);
					numin++;

				}

			break;

			case GRATIS:
				variable=yylex();

				if(variable==MINUTOS )
				{
					ming+=atof(yytext);
					numg++;

				}

			break;
			default:

			break;
		}
	}while(variable);

	fprintf(yyout,"\nNúmeros fijos: %d llamadas, %f minutos, %f euros\n",numf,minf,minf*0.038);
	fprintf(yyout,"Números moviles: %d llamadas, %f minutos, %f euros\n",numm,minm,minm*0.081);
	fprintf(yyout,"Números internacionales: %d llamadas, %f minutos, %f euros\n",numin,minin,minin*0.45);
	fprintf(yyout,"Números informacion: %d llamadas, %f minutos, %f euros\n",numi,mini,mini*0.160);
	fprintf(yyout,"Números de emergencia: %d llamadas, %f minutos, %f euros\n",numg,ming,ming*0);
	fprintf(yyout,"Números tarifacion especial: %d llamadas, %f minutos, %f euros\n",nume,mine,mine*1.005);
	fclose(yyin);
	fclose(yyout);
	return 0;
}
