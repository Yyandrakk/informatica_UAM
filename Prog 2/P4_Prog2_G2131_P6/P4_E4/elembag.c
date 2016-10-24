#include "elembag.h"

/* Copia el segundo elemento sobre el primero. Devuelve OK si todo va bien, ERROR si no. */
STATUS copyElemBag (ELEMBAG *pDest, const ELEMBAG *pOrigin)
{
     if (pDest==NULL || pOrigin==NULL)
        return ERROR;
     
    copyCoin (pDest,pOrigin);
     
     return OK;
}

/* Imprime el elemento en pf */
void printElemBag (FILE * pf, const ELEMBAG *pe)
{
  printCoin (pf,pe);
}

