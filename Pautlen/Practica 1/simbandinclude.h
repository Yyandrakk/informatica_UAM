/* 
 * File:   simbandinclude.h
 * Author: oscar
 *
 * Created on 14 de octubre de 2014, 10:09
 */

#ifndef SIMBANDINCLUDE_H
#define	SIMBANDINCLUDE_H

#ifdef	__cplusplus
extern "C" {
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define VARIABLE 1
#define PARAMETRO 2
#define FUNCION 3

#define BOOLEAN 1
#define INT 2

#define ESCALAR 1
#define VECTOR 2

#define TAMANO_HASH 257/*Tiene que ser primo*/
#define TAMANO 100
#define BORRADO ''''
    
    typedef enum {
	FALSE = 0,
	TRUE = 1
} BOOL;


typedef enum {
	OK = 0,				/* todo fue bien */
	ERROR = -1			/* error general */
} STATUS;
#ifdef	__cplusplus
}
#endif

#endif	/* SIMBANDINCLUDE_H */

