/* 
 * Archivo: types.h
 * Author: Alejandro Bellogin y Fernando Diez
 * Descripcion: Modulo con los tipos de retorno
 * Modulos necesarios: 
 * Fecha: 23-02-2014
 */

#ifndef _TYPES_H
#define _TYPES_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/* Constantes y tipos de retorno de funciones */
typedef enum {
    FALSE = 0, TRUE = 1
} BOOL;

typedef enum {
    ERROR = -1, OK = 0
} STATUS;

#endif
