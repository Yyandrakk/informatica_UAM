#include "eleBTree.h"
/**------------------------------------------------------------------
 * @name createEleBTree
 * @brief Crea un elemento (campo info) del árbol.
 *
 * @param p, el valor del elemento
 * @return el elemento creado
 *------------------------------------------------------------------*/

ELEBTREE* createEleBTree(char *name)
{
    ELEBTREE *elemento;
  if(!name)
    return NULL;
  
  elemento=(ELEBTREE*)malloc(sizeof(ELEBTREE));
  
  if(!elemento||iniEmptyPerson((PERSON*)elemento,strlen(name)+1)!=OK)
      return NULL;

/* Inicializa una estructura de tipo persona y le asigna un nombre*/
  return elemento;
}

/**------------------------------------------------------------------
 * @name copyEleBTree
 * @brief Copia el contenido del elemento apuntado por src en el elemento
 * apuntado por dst. El elemento destino debe tener suficiente memoria.
 *
 * @param dst, elemento destino
 * @param src, elemento fuente
 * @return el posible error
 *------------------------------------------------------------------*/

STATUS copyEleBTree(ELEBTREE* dst, const ELEBTREE* src)
{
  return copyPerson(dst,src); 
}

/**------------------------------------------------------------------
 * @name cmpEleBTree
 * @brief Compara dos elementos de un arbol.
 *
 * @param e1, elemento destino
 * @param e2, elemento fuente
 * @return un entero menor, igual, o mayor que cero si e1 es menor, 
 *  igual, o mayor que e2
------------------------------------------------------------------*/

int cmpEleBTree(const ELEBTREE* e1, const ELEBTREE* e2)
{
  return cmpPhone(e1->telefono,e2->telefono);
}

/**------------------------------------------------------------------
 * @name: destroyEleBTree
 * @brief Destruye un elemento
 *
 * @param pele, elemento que se destruye.
 * @return el posible error
------------------------------------------------------------------*/

STATUS destroyEleBTree(ELEBTREE* pele)
{
   freePerson(pele);
   free(pele);
   return OK;
}

/**------------------------------------------------------------------
 * @name: printEleBTree
 * @brief Imprime en un descriptor de archivo un elemento.
 *
 * @param pf, descriptor de archivo donde escribir
 * @param pele, elemento que se imprime
 * @return el posible error
 *------------------------------------------------------------------*/

STATUS printEleBTree(FILE* pf, const ELEBTREE* pele)
{
  printPerson(pf, pele); 
  return OK;
}
