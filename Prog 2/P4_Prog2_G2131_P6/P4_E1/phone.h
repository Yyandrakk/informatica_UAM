/* 
 * Nombre: phone.h
 * Author: Alejandro Bellogin y Fernando Diez
 *
 * Descripción: definición del TaD EleBTree
 *
 * Fecha: 23-02-2014
 */

#ifndef _PHONE_H
#define	_PHONE_H

#include "types.h"

typedef struct {
    int prefix;
    long number;
} PHONE;


/**------------------------------------------------------------------
 * @name iniPhone
 * @brief Reserva memoria para un dato de tipo PHONE y lo inicializa.
 *
 * @param prefix, el valor del prefijo del teléfono
 * @param number, el valor del número del teléfono
 * @return el teléfono creado
 *------------------------------------------------------------------*/
PHONE* iniPhone(const int prefix, const long number);

/**------------------------------------------------------------------
 * @name getPhonePrefix
 * @brief Devuelve el prefijo de un teléfono, o -1 si se produce algún error.
 *
 * @param p, teléfono
 * @return su prefijo
 *------------------------------------------------------------------*/
const int getPhonePrefix(const PHONE* p);

/**------------------------------------------------------------------
 * @name getPhoneNumber
 * @brief Devuelve el número de un teléfono, o -1 si se produce algún error.
 *
 * @param p, teléfono
 * @return su número
 *------------------------------------------------------------------*/
const long getPhoneNumber(const PHONE* p);

/**------------------------------------------------------------------
 * @name copyPhone
 * @brief Copia el contenido del teléfono apuntado por pOrigin en el teléfono
 * apuntado por pDest.
 *
 * @param pDest, elemento destino
 * @param pOrigin, elemento fuente
 * @return el posible error
 *------------------------------------------------------------------*/
STATUS copyPhone(PHONE* pDest, const PHONE* pOrigin);

/**------------------------------------------------------------------
 * @name cmpPhone
 * @brief Compara dos teléfonos.
 *
 * @param p1, teléfono destino
 * @param p2, teléfono fuente
 * @return un entero menor, igual, o mayor que cero si p1 es menor, 
 *  igual, o mayor que p2
------------------------------------------------------------------*/

int cmpPhone(const PHONE* p1, const PHONE* p2);

/**------------------------------------------------------------------
 * @name: printPhone
 * @brief Imprime en un descriptor de archivo un teléfono con el formato
 *        [prefix-number]
 *
 * @param pf, descriptor de archivo donde escribir
 * @param p, teléfono que se imprime
 * @return el posible error
 *------------------------------------------------------------------*/
STATUS printPhone(FILE *pf, const PHONE* p);

/**------------------------------------------------------------------
 * @name: freePhone
 * @brief Libera la memoria reservada para un teléfono. Esta función no hará nada.
 *
 * @param p, teléfono a liberar
 * @return el posible error
 *------------------------------------------------------------------*/
STATUS freePhone(PHONE* p);

#endif	/* _PHONE_H */

