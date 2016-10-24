/* 
 * Archivo:   elestack.h
 * Author: Antonio Carlos y Jaime Moreno
 * Descripcion: Modulo con las funciones de elemento
 * Modulos necesarios: tipos.h
 * Fecha: 26-01-2014
 */


#ifndef _ELESTACK_H
#define	_ELESTACK_H

/*! Includes the STATUS and BOOL types*/

#include "types.h"

/**
 * @brief ELESTACK definition
 *
 */
typedef int ELESTACK;

/**------------------------------------------------------------------
Nombre: iniEleStack
Descripcion: Inicializa un elemento de pila con el elemento que le pasan
Entrada: origen y destino
Salida: Puntero al elemento inicializado o null en caso de error
------------------------------------------------------------------*/
ELESTACK *iniEleStack (ELESTACK *dst, const ELESTACK *src);


/**------------------------------------------------------------------
Nombre: copyEleStack 
Descripcion: Copia el elemento fuente src en el destino dst
Entrada: Los elementos de entrada son el elemento a copiar y el elemento donde va a ser copiado.
Salida: Devuelve un puntero al elemento copiado (= la direcci�n del mismo) o NULL en caso de error
------------------------------------------------------------------*/

ELESTACK *copyEleStack (ELESTACK *dst, const ELESTACK *src);


/**------------------------------------------------------------------
Nombre: cmpEleStack 
Descripcion: Compara dos elementos
Entrada: dos elementos a comparar
Salida: Devuelve TRUE en caso de ser iguales y si no FALSE 
------------------------------------------------------------------*/
BOOL cmpEleStack (const ELESTACK *ele1, const ELESTACK *ele2 );


/**------------------------------------------------------------------
Nombre: printEleStack 
Descripcion: IImprime en un fichero ya abierto el elemento
Entrada: Fichero en el que se imprime y el elemento a imprimir
Salida: void
------------------------------------------------------------------*/
void printEleStack (FILE *pf, const ELESTACK *ele);

/**------------------------------------------------------------------
Nombre: destroyEleStack 
Descripcion: Elimina un elemento. Tened en cuenta que ahora no estamos trabajando con memoria din�mica 
Entrada: Elemento a destruir
------------------------------------------------------------------*/
void destroyEleStack (ELESTACK *ele);


#endif	/* ELESTACK_H */

