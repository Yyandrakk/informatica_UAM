/* 
 * File:   elembag.h
 * Author: Rosa.Carro
 *
 * Created on 24 de enero de 2014, 12:37
 */

#ifndef ELEMBAG_H
#define	ELEMBAG_H


/* includes, defines y/o typedefs que necesites */
#include "coin.h"

typedef COIN ELEMBAG;


/* Copia el segundo elemento sobre el primero. Devuelve OK si todo va bien, ERROR si no. */
STATUS copyElemBag (ELEMBAG *pDest, const ELEMBAG *pOrigin);  

/* Imprime el elemento en pf */
void printElemBag (FILE * pf, const ELEMBAG *pe);

#endif	/* ELEMBAG_H */

