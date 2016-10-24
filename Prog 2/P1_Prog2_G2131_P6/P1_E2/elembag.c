/* 
 * File:   elembag.c
 * Author: Oscar y Maria
 * Pareja: 6
 * 
 */
#include "elembag.h"

/* Copia el segundo elemento sobre el primero. Devuelve OK si todo va bien, ERROR si no. */
STATUS copyElemBag (ELEMBAG *pDest, const ELEMBAG *pOrigin)
{
     if (pDest==NULL || pOrigin==NULL)
        return ERROR;
     
     *pDest=*pOrigin;
     
     return OK;
}

/* Imprime el elemento en pf */
void printElemBag (FILE * pf, const ELEMBAG *pe)
{
    fprintf(pf,"%d ",*pe);
    
}

