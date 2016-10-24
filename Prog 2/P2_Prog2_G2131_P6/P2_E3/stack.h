/* 
 * Archivo:   stack.h
 * Author: Oscar y Maria
 * Descripcion: Modulo con las funciones de pila
 * Modulos necesarios: stack.h
 * Fecha: 26-01-2014
 */

#ifndef _STACK_H
#define _STACK_H

#define MAXSTACK 100

/* includes, defines y/o typedef que necesitesis */
#include "elestack.h"

typedef struct {
    ELESTACK item[MAXSTACK];
    ELESTACK *top;
}STACK;
/**------------------------------------------------------------------
Nombre: iniStack
Descripcion: Inicializa la pila
Entrada: pila a inicializar
Salida: ERR si ha habido error o OK si ha ido bien
------------------------------------------------------------------*/
STATUS iniStack (STACK *str);

/**------------------------------------------------------------------
Nombre: isFullStack
Descripcion: Comprueba si la pila esta llena
Entrada: pila a comprobar
Salida: TRUE si está llena o FALSE si no lo esta
------------------------------------------------------------------*/
BOOL isFullStack (const STACK *stc);

/**------------------------------------------------------------------
Nombre: isEmptyStack
Descripcion: Comprueba si la pila esta vacia
Entrada: pila a comprobar
Salida: TRUE si está vacia o FALSE si no lo esta
------------------------------------------------------------------*/
BOOL isEmptyStack (const STACK *stc);

/**------------------------------------------------------------------
Nombre: push
Descripcion: inserta un elemento en la pila
Entrada: un elemento y la pila donde insertarlo
Salida: ERR si no logra insertarlo o OK si lo logra
------------------------------------------------------------------*/
STATUS push(STACK *stc, const ELESTACK *ele);

/**------------------------------------------------------------------
Nombre: pop
Descripcion: extrae un elemento en la pila
Entrada: un elemento y la pila de donde extraerlo
Salida: ERR si no logra extraerlo o OK si lo logra
------------------------------------------------------------------*/
STATUS pop(STACK *stc, ELESTACK *ele);

/**------------------------------------------------------------------
Nombre: topStack
Descripcion: copia un elemento sin modificar el top
Entrada: un elemento y la pila de donde copiarlo
Salida: ERR si no logra copiarlo o OK si lo logra
------------------------------------------------------------------*/
STATUS topStack(const STACK *stc, ELESTACK *ele);

/**------------------------------------------------------------------
Nombre: printStack
Descripcion: imprime toda la pila
Entrada: pila a imprimir y fichero donde imprimirla
------------------------------------------------------------------*/
void printStack (FILE *pf, const STACK *stc);

/**------------------------------------------------------------------
Nombre: destroyStack
Descripcion: elimina la pila
Entrada: la pila a eliminar
Salida: ERR si no logra eliminarla o OK si lo logra
------------------------------------------------------------------*/
STATUS destroyStack(STACK *stack);

#endif


