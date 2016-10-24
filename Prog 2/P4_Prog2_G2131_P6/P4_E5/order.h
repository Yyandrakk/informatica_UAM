/*
 * Nombre: order.h
 *
 * Descripción: prototipos de los recorridos sobre árboles
 */

#ifndef _ORDER_
#define _ORDER_

#include "bSTree.h"
#include "list.h"
/**--------------------------------------------------
 * @name preOrderToFile
 * @brief: Devuelve un recorrido de un árbol en orden previo. 
 *
 * @param pf fichero.
 * @param pt arbol.

 * @return status
 *------------------------------------------------------*/

STATUS preOrderToFile(FILE* pf, BSTREE* pt);

/**--------------------------------------------------
 * @name inOrderToFile
 * @brief: Devuelve un recorrido de un árbol en orden medio. 
 *
 * @param pf fichero.
 * @param pt arbol.
 *
 * @return status
 *------------------------------------------------------*/

STATUS inOrderToFile(FILE* pf, BSTREE* pt);

/**--------------------------------------------------
 * @name postOrderToFile
 * @brief: Devuelve un recorrido de un árbol en orden posterior
 *
 * @param pf fichero.
 * @param pt arbol.
 *
 * @return status
 *------------------------------------------------------*/

STATUS postOrderToFile(FILE* pf, BSTREE* pt);

/**--------------------------------------------------
* @name preOrderToList
* @brief: Devuelve un recorrido de un árbol en orden previo como lista.
*------------------------------------------------------*/
STATUS preOrderToList(LIST* pl, BSTREE* pt);
#endif /* _ORDER_ */
