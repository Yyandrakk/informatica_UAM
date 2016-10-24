/*
 * Nombre: bSTree.h
 * Author: Alejandro Bellogin y Fernando Diez
 *
 * Descripción: definición del TaD BSTree
 */

#ifndef _BSTREE_
#define _BSTREE_

#include "nodeBTree.h"

/* Definición de la EdD del TAD BSTree */
typedef NODEBTREE* BSTREE;



/*----------------------------------
 * @name createBSTree
 * @brief Inicializa un arbol como vacio.
 *
 * @param pt Puntero al arbol.
 *
 * @return Resultado de la inicializacion.
 *-----------------------------------*/

STATUS createBSTree(BSTREE* pt);

/**-----------------------------
 * @name  isEmptyBSTree
 * @brief Determina si un arbol esta vacio.
 *
 * @param pt arbol.
 *
 * @return Resultado de la inicializacion.
 *-------------------------------------*/

BOOL isEmptyBSTree(const BSTREE* pt);

/**-----------------------------------------
 * @name destroyBSTree
 * @brief Libera la memoria utilizada por un arbol.
 *
 * @param pt Puntero al arbol.
 *----------------------------------------*/

void destroyBSTree(BSTREE* pt);

/**--------------------------------------------
 * @name insertBSTree
 * @brief Inserta un objeto en un arbol.
 *
 * @param pt Puntero al arbol.
 * @param pele Puntero al objeto.
 *
 * @return Resultado de la insercion.
 *-------------------------------------------*/

STATUS insertBSTree(BSTREE* pt, const ELEBTREE* pele);

/**---------------------------------------------------------------
 * @name lookBSTree 
 * @brief Busca un objeto en un arbol y devuelve su direccion.
 *
 * @param pt arbol.
 * @param pele Puntero al objeto.
 *
 * @return Puntero al nodo que contiene el objeto, NULL en caso de error.
 *---------------------------------------------------------------*/

NODEBTREE* lookBSTree(const BSTREE* pt, const ELEBTREE* pele);

/**------------------------------------------------------
 * @name depthBSTree
 * @brief Calcula la profundidad de un árbol.
 *
 * @param pt puntero al arbol.
 *
 * @return Resultado de la operacion.
 *----------------------------------------------------------*/

int depthBSTree(BSTREE* pt);

/**--------------------------------------------------
 * @name numNodesBSTree
 * @brief Calcula el número de nodos de un árbol.
 *
 * @param pt puntero al arbol.
 *
 * @return número de nodos del árbol.
 *------------------------------------------------------*/

int numNodesBSTree(BSTREE* pt);

#endif /* _BSTREE_ */
