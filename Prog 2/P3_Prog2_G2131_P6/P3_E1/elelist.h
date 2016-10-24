#ifndef ELELIST_H
#define	ELELIST_H

/*includes, defines y/o typedef que necesitesis */
#include "types.h"

typedef int ELELIST;
/**------------------------------------------------------------------
Nombre: copyEleList
Descripcion: Copia el elemento
Entrada: elemento a copiar y elemento que va a ser copiado
Salida: ERR si ha habido error o OK si ha ido bien
------------------------------------------------------------------*/
STATUS copyEleList (ELELIST *pDest, const ELELIST *pOrigin);  

/**------------------------------------------------------------------
Nombre: printEleList
Descripcion: Imprime en un fichero el elemento
Entrada: Fichero en el que se imprime y el elemento a imprimir
------------------------------------------------------------------*/
void printEleList (FILE * pf, const ELELIST *pe);

#endif	/* ELELIST_H */

