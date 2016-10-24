/* 
 * File:   person.h
 * Author: María
 *
 * Created on 22 de abril de 2014, 17:48
 */

#ifndef PERSON_H
#define	PERSON_H
#define MAX_N 20

#include "types.h"
#include "bag.h"
#include "phone.h"

typedef struct {
    char *nombre;
    BAG monedero; 
    PHONE *telefono;
}PERSON;

/* Inicializa una estructura de tipo persona */
STATUS iniEmptyPerson(PERSON *person,int tamano);

/* Inicializa una estructura de tipo persona y le asigna un nombre*/
STATUS iniPersonWithName(PERSON *person, char *name, BAG *bag,PHONE *p);

/* Libera la memoria asociada a una persona*/
void freePerson(PERSON *person);

/* Copia el segundo elemento sobre el primero. Devuelve OK si todo va bien, ERROR si no. */
STATUS copyPerson (PERSON *pDest,const PERSON *pOrigin);  

/* Obtiene el nombre de una persona dada o NULL en caso de error*/
char * getName (const PERSON *pe);

/* Obtiene la direcciï¿½n del monedero de una persona dada, o NULL en caso de error */
BAG * getWallet (const PERSON *pe);

PHONE * getPhone (const PERSON *pe);
/* Imprime el elemento en pf */
void printPerson (FILE * pf, const PERSON *pe);


#endif	/* PERSON_H */

