#ifndef LIST_H
#define	LIST_H

/*includes, defines y/o typedef que necesitesis */
#include "elelist.h"

#define NEXT(a) (a)->next
#define DATA(a) (a)->data

typedef struct t_node{
ELELIST data;
struct t_node *next;
}NODE;
typedef NODE *LIST;

/**------------------------------------------------------------------
Nombre: getNode
Descripcion: Inicializa un nodo
Salida: el nodo inicializado
------------------------------------------------------------------*/
NODE *getNode();

/**------------------------------------------------------------------
Nombre: freeNode
Descripcion: Libera un nodo de la lista
Entrada: la lista 
------------------------------------------------------------------*/
void freeNode(NODE *node);

/**------------------------------------------------------------------
Nombre: iniList
Descripcion: Inicializa una lista
Entrada: la lista a inicializar
Salida: ERR si ha habido error o OK si ha ido bien
------------------------------------------------------------------*/
STATUS iniList(LIST *list);

/**------------------------------------------------------------------
Nombre: insertFirstEleList
Descripcion: inserta un elemento al principio de la lista
Entrada: un elemento y la lista donde insertarlo
Salida: ERR si ha habido error o OK si ha ido bien
------------------------------------------------------------------*/
STATUS insertFirstEleList (LIST *list, const ELELIST *pElem);

/**------------------------------------------------------------------
Nombre: insertLastEleList
Descripcion: inserta un elemento al final de la lista
Entrada: un elemento y la lista donde insertarlo
Salida: ERR si ha habido error o OK si ha ido bien
------------------------------------------------------------------*/
STATUS insertLastEleList  (LIST *list, const ELELIST *pElem);

/**------------------------------------------------------------------
Nombre: extractFirstEleList
Descripcion: Extrae primer elemento de la lista
Entrada: un elemento y la lista de donde extraerlo
Salida: ERR si ha habido error o OK si ha ido bien
------------------------------------------------------------------*/
STATUS extractFirstEleList (LIST *list, ELELIST *pElem);

/**------------------------------------------------------------------
Nombre: extractLastEleList
Descripcion: Extrae el último elemento de la lista
Entrada: un elemento y la lista de donde extraerlo
Salida: ERR si ha habido error o OK si ha ido bien
------------------------------------------------------------------*/
STATUS extractLastEleList (LIST *list, ELELIST *pElem);

/**------------------------------------------------------------------
Nombre: freeList
Descripcion: Libera la lista
Entrada: la lista
Salida: ERR si ha habido error o OK si ha ido bien
------------------------------------------------------------------*/
STATUS freeList(LIST *list);

/**------------------------------------------------------------------
Nombre: isEmptyList
Descripcion: Comprueba si la lista está vacía
Entrada: la lista
Salida: TRUE si la lista está vacía y FALSE en caso contrario
------------------------------------------------------------------*/
BOOL isEmptyList(const LIST *list);

/**------------------------------------------------------------------
Nombre: numElemsList
Descripcion: Devuelve el número de elementos de la lista
Entrada: la lista
Salida: el número de elementos de la lista
------------------------------------------------------------------*/
int numElemsList(const LIST *list);

/**------------------------------------------------------------------
Nombre: printList
Descripcion: imprime toda la lista
Entrada: lista a imprimir y fichero donde imprimirla
------------------------------------------------------------------*/
void printList(FILE *fd, const LIST *list);

/**------------------------------------------------------------------
Nombre: insertInOrderList
Descripcion: inserta en orden la lista
Entrada: lista donde insertar y elelist a insertar
------------------------------------------------------------------*/
STATUS insertInOrderList (LIST *list, const ELELIST *pElem);
#endif	/* LIST_H */
