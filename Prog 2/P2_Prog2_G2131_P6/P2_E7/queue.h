/*
 * File:   queue.h
 */

#ifndef QUEUE_H
#define	QUEUE_H


#include "elequeue.h"


#define MAXQUEUE 100

typedef struct {
    ELEQUEUE datos[MAXQUEUE];
    ELEQUEUE* pInser;		/* apunta a la direccion en datos donde se insertara el proximo elemento */
    ELEQUEUE* pExtrac; /* apunta a la direccion en datos donde se extraera el proximo elemento */ 
} QUEUE;

/**------------------------------------------------------------------
@name: iniQueue
@brief Inicializa la cola como vacia.
@param q, cola que se inicializa.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS iniQueue(QUEUE* q);

/**------------------------------------------------------------------
@name: isEmptyQueue
@brief Comprueba si una cola esta vacia.
@param q, cola que se comprueba.
@return TRUE si esta vacia, FALSE si no.
------------------------------------------------------------------*/
BOOL isEmptyQueue(const QUEUE* q);

/**------------------------------------------------------------------
@name: isFullQueue
@brief Comprueba si una cola esta llena.
@param q, cola que se comprueba.
@return TRUE si esta llena, FALSE si no.
------------------------------------------------------------------*/
BOOL isFullQueue(const QUEUE* q);

/**------------------------------------------------------------------
@name: insertQueue
@brief Introduce un elemento en la cola si es posible, aumentando el tamano de la cola.
@param q, cola donde se inserta el elemento.
@param elem direccion del elemento con el contenido que se inserta.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS insertQueue(QUEUE* q, const ELEQUEUE* elem);

/**------------------------------------------------------------------
@name: extractQueue
@brief Saca un elemento de la cola si es posible, disminuyendo el tamano de la cola.
@param q, cola de donde se extrae el elemento.
@param elem, direccion del elemento donde se copia el contenido del que se extrae.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS extractQueue(QUEUE* q, ELEQUEUE* elem);

/**------------------------------------------------------------------
@name: sizeOfQueue
@brief Devuelve el tamano de la cola.
@param q, cola cuyo tamano se obtiene.
@return El tamano de la cola. Cero si esta vacia y -1 si ocurre un error.
------------------------------------------------------------------*/
int sizeOfQueue(const QUEUE* q);

/**------------------------------------------------------------------
@name: destroyQueue
@brief Libera una cola eliminando todos sus elementos.
@param q, cola que se libera.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS destroyQueue(QUEUE* q);

#endif	/* QUEUE_H */


