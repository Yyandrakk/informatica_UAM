#include "phone.h"


/**------------------------------------------------------------------
 * @name iniPhone
 * @brief Reserva memoria para un dato de tipo PHONE y lo inicializa.
 *
 * @param prefix, el valor del prefijo del teléfono
 * @param number, el valor del número del teléfono
 * @return el teléfono creado
 *------------------------------------------------------------------*/
PHONE* iniPhone(const int prefix, const long number)
{
  PHONE *p;
  
  p=(PHONE *)malloc(sizeof(PHONE));
  if(!p)
    return p;
  
  p->number=number;
  p->prefix=prefix;
  
  return p;
  
}

/**------------------------------------------------------------------
 * @name getPhonePrefix
 * @brief Devuelve el prefijo de un teléfono, o -1 si se produce algún error.
 *
 * @param p, teléfono
 * @return su prefijo
 *------------------------------------------------------------------*/
const int getPhonePrefix(const PHONE* p)
{
  if(!p)
    return -1;
  return p->prefix;
}

/**------------------------------------------------------------------
 * @name getPhoneNumber
 * @brief Devuelve el número de un teléfono, o -1 si se produce algún error.
 *
 * @param p, teléfono
 * @return su número
 *------------------------------------------------------------------*/
const long getPhoneNumber(const PHONE* p)
{
  if(!p)
    return -1;
  return p->number;
}

/**------------------------------------------------------------------
 * @name copyPhone
 * @brief Copia el contenido del teléfono apuntado por pOrigin en el teléfono
 * apuntado por pDest.
 *
 * @param pDest, elemento destino
 * @param pOrigin, elemento fuente
 * @return el posible error
 *------------------------------------------------------------------*/
STATUS copyPhone(PHONE* pDest, const PHONE* pOrigin)
{
  if(!pDest||!pOrigin)
    return ERROR;
  pDest->number=pOrigin->number;
  pDest->prefix=pOrigin->prefix;
  return OK;
}

/**------------------------------------------------------------------
 * @name cmpPhone
 * @brief Compara dos teléfonos.
 *
 * @param p1, teléfono destino
 * @param p2, teléfono fuente
 * @return un entero menor, igual, o mayor que cero si p1 es menor, 
 *  igual, o mayor que p2
------------------------------------------------------------------*/

int cmpPhone(const PHONE* p1, const PHONE* p2)
{
  if(!p1||!p2)
    return -2;
  if(p1->prefix<p2->prefix)
    return -1;
  else if(p1->prefix>p2->prefix)
    return 1;
  else 
    {
      if(p1->number<p2->number)
         return -1;
      else if(p1->number>p2->number)
         return 1;
     else 
       return 0;
    }
}

/**------------------------------------------------------------------
 * @name: printPhone
 * @brief Imprime en un descriptor de archivo un teléfono con el formato
 *        [prefix-number]
 *
 * @param pf, descriptor de archivo donde escribir
 * @param p, teléfono que se imprime
 * @return el posible error
 *------------------------------------------------------------------*/
STATUS printPhone(FILE *pf, const PHONE* p)
{
  if(!pf||!p)
    return ERROR;
  
  fprintf(pf,"\n[%d-%ld]",p->prefix,p->number);
  return OK;
}

/**------------------------------------------------------------------
 * @name: freePhone
 * @brief Libera la memoria reservada para un teléfono. Esta función no hará nada.
 *
 * @param p, teléfono a liberar
 * @return el posible error
 *------------------------------------------------------------------*/
STATUS freePhone(PHONE* p)
{
  if(!p)
    return ERROR;
  free(p);
  p=NULL;
  return OK;
}