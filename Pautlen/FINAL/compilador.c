#include "alfa.h"
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
extern FILE *yyout;

int main (int argc, char **argv)
{
  if(argc!=3)
  {
    printf("\n ERROR PARAMETROS\n\t./alfa ficheroentrada ficherosalida\n");
    return 0;
  }
  yyin=fopen(argv[1],"r");
  if(yyin==NULL)
    {printf("\n ERROR ABRIR FICHERO ENTRADA\n");
    return 0;
    }
  yyout=fopen(argv[2],"w");
  if(yyout==NULL)
    {printf("\n ERROR ABRIR FICHERO SALIDA\n");
    fclose(yyin);
    return 0;
    }
  if(yyparse()!=0)
    printf("\nERROR AL COMPILAR\n");
  else
    printf("\nCOMPILACION TERMINADO CON EXITO\n");
  fclose(yyout);
  fclose(yyin);
  return 0;
}
