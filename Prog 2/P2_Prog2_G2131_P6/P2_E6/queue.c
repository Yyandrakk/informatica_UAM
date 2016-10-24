 #include "queue.h"

/**------------------------------------------------------------------
@name: iniQueue
@brief Inicializa la cola como vacia.
@param q, cola que se inicializa.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS
iniQueue (QUEUE* q)
{
  if (!q)
    return ERROR;
  q->pExtrac = q->pInser = q->datos;

  return OK;
}

/**------------------------------------------------------------------
@name: isEmptyQueue
@brief Comprueba si una cola esta vacia.
@param q, cola que se comprueba.
@return TRUE si esta vacia, FALSE si no.
------------------------------------------------------------------*/
BOOL
isEmptyQueue (const QUEUE* q)
{
  if (q->pExtrac == q->pInser)
    return TRUE;

  return FALSE;
}

/**------------------------------------------------------------------
@name: isFullQueue
@brief Comprueba si una cola esta llena.
@param q, cola que se comprueba.
@return TRUE si esta llena, FALSE si no.
------------------------------------------------------------------*/
BOOL
isFullQueue (const QUEUE* q)
{
  ELEQUEUE *pa;
  if (q->pInser == q->datos + MAXQUEUE - 1)
    pa=(ELEQUEUE*)q->datos;
  else
    pa=q->pInser+1;
  if(q->pExtrac==pa)
    return TRUE;

  return FALSE;
}

/**------------------------------------------------------------------
@name: insertQueue
@brief Introduce un elemento en la cola si es posible, aumentando el tamano de la cola.
@param q, cola donde se inserta el elemento.
@param elem direccion del elemento con el contenido que se inserta.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS
insertQueue (QUEUE* q, const ELEQUEUE* elem)
{
  if (!q || !elem || isFullQueue (q) == TRUE)
    return ERROR;

  if (copyEleQueue (q->pInser, elem) != OK)
    return ERROR;

  if (q->pInser == q->datos + (MAXQUEUE - 1))
    q->pInser = q->datos;
  else
    q->pInser++;

  return OK;


}

/**------------------------------------------------------------------
@name: extractQueue
@brief Saca un elemento de la cola si es posible, disminuyendo el tamano de la cola.
@param q, cola de donde se extrae el elemento.
@param elem, direccion del elemento donde se copia el contenido del que se extrae.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS extractQueue (QUEUE* q, ELEQUEUE* elem)
{

  if (!q || !elem || isEmptyQueue (q) == TRUE)
    return ERROR;

  if (copyEleQueue (elem, q->pExtrac) != OK)
    return ERROR;

  if (q->pExtrac == q->datos + MAXQUEUE - 1)
    q->pExtrac = q->datos;
  else
    q->pExtrac++;

  return OK;
}

/**------------------------------------------------------------------
@name: sizeOfQueue
@brief Devuelve el tamano de la cola.
@param q, cola cuyo tamano se obtiene.
@return El tamano de la cola. Cero si esta vacia y -1 si ocurre un error.
------------------------------------------------------------------*/
int sizeOfQueue (const QUEUE* q)
{
  if(!q)
    return -1;
  if(isEmptyQueue(q)==TRUE)
    return 0;

  if(q->pInser > q->pExtrac)
    return q->pInser - q->pExtrac;

  return MAXQUEUE - (q->pExtrac - q->pInser);
}

/**------------------------------------------------------------------
@name: destroyQueue
@brief Libera una cola eliminando todos sus elementos.
@param q, cola que se libera.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS destroyQueue (QUEUE* q)
{
  return iniQueue(q);
}
