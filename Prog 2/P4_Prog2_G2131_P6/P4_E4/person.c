#include "person.h"

/* Inicializa una estructura de tipo persona */
STATUS iniEmptyPerson(PERSON *person, int tamano)
{
  
  if(!person)
    return ERROR;
  if(iniBag(&person->monedero)!=OK)
    return ERROR;
  person->nombre=(char*)malloc(sizeof(char)*(tamano));
  if(!person->nombre)
    return ERROR;
  person->telefono = iniPhone(0, 0);
  if (! person->telefono)
      return ERROR;  
  return OK;
}

/* Inicializa una estructura de tipo persona y le asigna un nombre*/
STATUS iniPersonWithName(PERSON *person, char *name, BAG *bag, PHONE *p)
{
  if(!person||!name||!bag)
    return ERROR;
  strcpy(person->nombre,name);
  if(copyBag(&person->monedero,bag)!=OK)
    return ERROR;
  if (copyPhone(person->telefono,p) != OK)
      return ERROR;  
  return OK;
          
}

/* Libera la memoria asociada a una persona*/
void freePerson(PERSON *person)
{
  free(person->nombre);
  freeBag(&person->monedero);
  freePhone(person->telefono);
}

/* Copia el segundo elemento sobre el primero. Devuelve OK si todo va bien, ERROR si no. */
STATUS copyPerson (PERSON *pDest,const PERSON *pOrigin)
{
  if(!pDest||!pOrigin)
    return ERROR;
  
  strcpy(pDest->nombre,pOrigin->nombre);
  
  if(copyBag(&pDest->monedero,&pOrigin->monedero)!=OK)
    return ERROR;
  
  if (copyPhone(pDest->telefono, pOrigin->telefono) != OK)
      return ERROR;
  return OK;
}

/* Obtiene el nombre de una persona dada o NULL en caso de error*/
char * getName (const PERSON *pe)
{
  return (char*) pe->nombre;
}

/* Obtiene la direcci�n del monedero de una persona dada, o NULL en caso de error */
BAG * getWallet (const PERSON *pe)
{
  return (BAG *)&pe->monedero;
}

PHONE * getPhone (const PERSON *pe)
{
  return pe->telefono;
}

/* Imprime el elemento en pf */
void printPerson (FILE * pf, const PERSON *pe)
{
  fprintf(pf,"\n%s",pe->nombre);
  printBag(pf,&pe->monedero);
  printPhone(pf,pe->telefono);
}