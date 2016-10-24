#include"bSTree.h"
/*----------------------------------
 * @name createBSTree
 * @brief Inicializa un arbol como vacio.
 *
 * @param pt Puntero al arbol.
 *
 * @return Resultado de la inicializacion.
 *-----------------------------------*/

STATUS createBSTree(BSTREE* pt)
{
  if(!pt)
    return ERROR;
  *pt=NULL;
  return OK;
}

/**-----------------------------
 * @name  isEmptyBSTree
 * @brief Determina si un arbol esta vacio.
 *
 * @param pt arbol.
 *
 * @return Resultado de la inicializacion.
 *-------------------------------------*/

BOOL isEmptyBSTree(const BSTREE* pt)
{
  if(*pt==NULL)
    return TRUE;
   return FALSE;
}

/**-----------------------------------------
 * @name destroyBSTree
 * @brief Libera la memoria utilizada por un arbol.
 *
 * @param pt Puntero al arbol.
 *----------------------------------------*/

void destroyBSTree(BSTREE* pt)
{
  if(isEmptyBSTree(pt)==TRUE)
    return;
  destroyBSTree(&LEFT(*pt));
  destroyBSTree(&RIGHT(*pt));
  destroyNodeBTree(*pt);
  *pt=NULL;
}

/**--------------------------------------------
 * @name insertBSTree
 * @brief Inserta un objeto en un arbol.
 *
 * @param pt Puntero al arbol.
 * @param pele Puntero al objeto.
 *
 * @return Resultado de la insercion.
 *-------------------------------------------*/

STATUS insertBSTree(BSTREE* pt, const ELEBTREE* pele)
{
  if(!pt||!pele)
    return ERROR;
            
  if(isEmptyBSTree(pt)==TRUE)
     {
      if((*pt=createNodeBTree(pele))==NULL)
        return ERROR;
      return OK;          
     }
  else if(cmpEleBTree(pele, INFO(*pt))==-1)
          return insertBSTree(&LEFT(*pt), pele);
  else
   return insertBSTree(&RIGHT(*pt), pele);
}

/**---------------------------------------------------------------
 * @name lookBSTree 
 * @brief Busca un objeto en un arbol y devuelve su direccion.
 *
 * @param pt arbol.
 * @param pele Puntero al objeto.
 *
 * @return Puntero al nodo que contiene el objeto, NULL en caso de error.
 *---------------------------------------------------------------*/

NODEBTREE* lookBSTree(const BSTREE* pt, const ELEBTREE* pele)
{
  int dir;
  if(!pt||!pele||isEmptyBSTree(pt)==TRUE)
    return NULL;
  else if((dir=cmpEleBTree(pele, INFO(*pt)))==0)
    return *pt;
  else if(dir==-1)
          return lookBSTree(&LEFT(*pt), pele);
  else
   return lookBSTree(&RIGHT(*pt), pele);
}

/**------------------------------------------------------
 * @name depthBSTree
 * @brief Calcula la profundidad de un árbol.
 *
 * @param pt puntero al arbol.
 *
 * @return Resultado de la operacion.
 *----------------------------------------------------------*/

int depthBSTree(BSTREE* pt)
{
  int i=0,d=0;
  if(!pt)
    return -1;
  if(isEmptyBSTree(pt)==TRUE)
    return -1;
  i=1+depthBSTree(&LEFT(*pt));
  d=1+depthBSTree(&RIGHT(*pt));
  if(i>d)
    return i;
  return d;
}

/**--------------------------------------------------
 * @name numNodesBSTree
 * @brief Calcula el número de nodos de un árbol.
 *
 * @param pt puntero al arbol.
 *
 * @return número de nodos del árbol.
 *------------------------------------------------------*/

int numNodesBSTree(BSTREE* pt)
{
  if(!pt)
    return -1;
  if(isEmptyBSTree(pt)==TRUE)
    return 0;
  return 1+numNodesBSTree(&LEFT(*pt))+numNodesBSTree(&RIGHT(*pt));
  }
