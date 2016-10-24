/* 
 * File:   nodeBTree.h
 * Author: Alejandro Bellogin y Fernando Diez
 *
 * Descripción: definición del TaD NodeBTree
 */

#ifndef _NODEBTREE_H
#define	_NODEBTREE_H

#include "eleBTree.h"

typedef struct _NODE {
    ELEBTREE *info;
    struct _NODE *left, *right;
} NODEBTREE;

/* Macros */
#define INFO(t) ((t)->info)
#define LEFT(t) ((t)->left)
#define RIGHT(t) ((t)->right)

/**------------------------------------------------------------------
 * @name: createNodeBTree
 * @brief Crea un nodo a partir de un elemento, utilizando memoria dinámica.
 *
 * @param pele, dirección de un elemento cuyo contenido se insertará en el nodo.
 * @return el nodo creado, o NULL si ocurrió un error
 *------------------------------------------------------------------*/

NODEBTREE* createNodeBTree(const ELEBTREE* pele);

/**------------------------------------------------------------------
 * @name: destroyNodeBTree
 * @brief Libera la memoria usada por un nodo.
 *
 * @param pn, nodo que se libera.
 * @return el posible error
 *------------------------------------------------------------------*/

STATUS destroyNodeBTree(NODEBTREE* pn);

/**------------------------------------------------------------------
 * @name: printNodeBTree
 * @brief Imprime en un descriptor de archivo el contenido de un nodo.
 *
 * @param pf, descriptor de archivo donde escribir
 * @param pn, nodo que se imprime
 * @return el posible error
 *------------------------------------------------------------------*/

STATUS printNodeBTree(FILE* pf, const NODEBTREE* pn);

#endif	/* _NODEBTREE_H */

