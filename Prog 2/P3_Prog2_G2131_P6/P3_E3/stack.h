#ifndef STACK_H
#define	STACK_H

#include "list.h"
/*includes, defines y/o typedef que necesitesis */
typedef LIST STACK;
/**------------------------------------------------------------------
Nombre: iniStack
Descripcion: Inicializa la pila
Entrada: la pila a inicializar
Salida: ERR si ha habido error o OK si ha ido bien
------------------------------------------------------------------*/
STATUS iniStack(STACK *stack);

/**------------------------------------------------------------------
Nombre: isEmptyStack
Descripcion: Comprueba si la pila está vacía
Entrada: la pila
Salida: TRUE si la pila está vacía y FALSE en caso contrario
------------------------------------------------------------------*/
BOOL isEmptyStack(STACK *stack);

/**------------------------------------------------------------------
Nombre: push
Descripcion: inserta un elemento en la pila
Entrada: un elemento y la pila donde insertarlo
Salida: ERR si no logra insertarlo o OK si lo logra
------------------------------------------------------------------*/
STATUS push(STACK *stack, const ELELIST *pElem);

/**------------------------------------------------------------------
Nombre: pop
Descripcion: extrae un elemento en la pila
Entrada: un elemento y la pila de donde extraerlo
Salida: ERR si no logra extraerlo o OK si lo logra
------------------------------------------------------------------*/
STATUS pop(STACK *stack, ELELIST *pElem);

/**------------------------------------------------------------------
Nombre: printStack
Descripcion: imprime toda la pila
Entrada: pila a imprimir y fichero donde imprimirla
------------------------------------------------------------------*/
void printStack (FILE *pf, const STACK *stack);

/**------------------------------------------------------------------
Nombre: freeStack
Descripcion: libera la pila
Entrada: la pila
Salida: ERR si no logra eliminarla o OK si lo logra
------------------------------------------------------------------*/
STATUS freeStack(STACK *stack);

#endif	/* STACK_H */

