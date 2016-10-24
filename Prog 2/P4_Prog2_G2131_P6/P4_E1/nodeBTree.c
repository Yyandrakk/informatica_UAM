#include"nodeBTree.h"
/**------------------------------------------------------------------
 * @name: createNodeBTree
 * @brief Crea un nodo a partir de un elemento, utilizando memoria dinámica.
 *
 * @param pele, dirección de un elemento cuyo contenido se insertará en el nodo.
 * @return el nodo creado, o NULL si ocurrió un error
 *------------------------------------------------------------------*/

NODEBTREE* createNodeBTree(const ELEBTREE* pele)
{
  NODEBTREE *nt;
  
  nt=(NODEBTREE*)malloc(sizeof(NODEBTREE));
  if(!nt)
    return NULL;
  INFO(nt)=createEleBTree(pele);
  if(!INFO(nt))
    {
      free(nt);
    return NULL;
    }
  if(copyEleBTree(INFO(nt), pele)!=OK)
    return NULL;
  LEFT(nt)=NULL;
  RIGHT(nt)=NULL;
  
  return nt;
}

/**------------------------------------------------------------------
 * @name: destroyNodeBTree
 * @brief Libera la memoria usada por un nodo.
 *
 * @param pn, nodo que se libera.
 * @return el posible error
 *------------------------------------------------------------------*/

STATUS destroyNodeBTree(NODEBTREE* pn)
{
  if(!pn||destroyEleBTree(INFO(pn))!=OK)
    return ERROR;
  free(pn);
  pn=NULL;
  return OK;
          
}

/**------------------------------------------------------------------
 * @name: printNodeBTree
 * @brief Imprime en un descriptor de archivo el contenido de un nodo.
 *
 * @param pf, descriptor de archivo donde escribir
 * @param pn, nodo que se imprime
 * @return el posible error
 *------------------------------------------------------------------*/

STATUS printNodeBTree(FILE* pf, const NODEBTREE* pn)
{
  return printEleBTree(pf, INFO(pn));
}


