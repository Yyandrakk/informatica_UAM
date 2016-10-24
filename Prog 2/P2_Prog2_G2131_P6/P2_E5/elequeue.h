/* 
 * Archivo:   elequeue.h
 * Author: Antonio Carlos y Jaime Moreno
 * Descripcion: Modulo con las funciones de elemento
 * Modulos necesarios: types.h
 * Fecha: 02-02-2014
 */

#ifndef ELEQUEUE_H
#define	ELEQUEUE_H


#include "types.h"


typedef int ELEQUEUE;

/**------------------------------------------------------------------
@name iniEleQueue
@brief Inicializa un elemento.
@param elem, elemento que se inicializa.
@param src, elemento de inicializacion.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
/*------------------------------------------------------------------
 Versión alternativa: STATUS iniEleQueue(ELEQUEUE* elem, const int n);
------------------------------------------------------------------*/
STATUS iniEleQueue(ELEQUEUE* elem, const ELEQUEUE* src);
/**------------------------------------------------------------------
@name copyEleQueue
@brief Copia el contenido de un elemento en otro.
@param dst, elemento destino.
@param src, elemento fuente.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS copyEleQueue(ELEQUEUE* dst, const ELEQUEUE* src);

/**------------------------------------------------------------------
@name printEleQueue
@brief Imprime un elemento.
@param f, fichero en el que se escribe.
@param elem, elemento que se imprime.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS printEleQueue(FILE *pf, const ELEQUEUE* elem);

/**------------------------------------------------------------------
@name destroyEleQueue
@brief Destruye un elemento.
@param elem, elemento que se destruye.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS destroyEleQueue(ELEQUEUE* elem);



#endif	/* ELEQUEUE_H */


