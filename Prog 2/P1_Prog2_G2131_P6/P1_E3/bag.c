#include "bag.h"

/* Inicializa una bolsa de modo que esté vacía, lista para introducir elementos */	
STATUS iniBag (BAG * pb)
{
    
    if(pb==NULL)
        return ERROR;
   
    pb->nelemsBag=0;
    
    return OK;
}

/* Devuelve el nº de elementos que contiene la bolsa cuando se invoca a esta primitiva, o -1 si error. */
unsigned short getNelemsBag (const BAG * pb)
{
    if(pb==NULL)
        return ERROR;
    
    return pb->nelemsBag;
}
        
/* Inserta el elemento cuya dirección se encuentra en pElem en la bolsa cuya dirección se encuentra en 
* pb. Devuelve OK si se ha logrado insertar, ERROR si no */
STATUS insertElemBag (BAG * pb, const ELEMBAG * pElem)
{
    
    
    if(pb==NULL || pElem==NULL||getNelemsBag (pb)==MAXBAG)
        return ERROR;
    
    if (copyElemBag (&pb->elemsBag[getNelemsBag (pb)],pElem)!=OK)
        return ERROR;
    
    pb->nelemsBag++;
    
    return OK;
}
        
/* Extrae un elemento de la bolsa y lo coloca en la dirección que indica pElem. Devuelve OK si se ha 
logrado realizar la operación, ERROR si no */
STATUS extractElemBag (BAG * pb, ELEMBAG * pElem)
{

    
    if(pb==NULL || pElem==NULL||getNelemsBag (pb)==0)
        return ERROR;
    
    if (copyElemBag (pElem, &pb->elemsBag[getNelemsBag (pb)-1])!=OK)
        return ERROR;
    
    pb->nelemsBag--;
    
    return OK;
    
}

/* Copia una bolsa en otra, copiando el número de elementos de la misma y cada uno de ellos.
Devuelve OK si todo ha ido bien */
STATUS copyBag (BAG * pDest, const BAG * pOrigin)
{
    int i;
    
    if (pDest==NULL || pOrigin==NULL)
        return ERROR;
    
    for(i=0;i<getNelemsBag (pOrigin);i++)
      {
       if(copyElemBag (&pDest->elemsBag[i],&pOrigin->elemsBag[i])!=OK)
           return ERROR;
      }
        
    pDest->nelemsBag=pOrigin->nelemsBag;
    
    return OK;
}
        
/* Imprime el contenido de la bolsa en pf. Primero imprime el nº de elementos que contiene y después,
 * uno por uno, cada uno de sus elementos. */
void printBag (FILE* f, const BAG * pb)
{
    int i;
    
    fprintf(f,"\nBolsa con %d elementos:",getNelemsBag (pb));
    
    for(i=0;i<pb->nelemsBag;i++)
    {
        printElemBag (f, &pb->elemsBag[i]);
    }
}
        
/* Libera la memoria ocupada por la bolsa, liberando uno a uno sus elementos, si fuera necesario, y 
 * finalmente liberando  la memoria dinámica reservada para la bolsa, si fuera el caso. Pone el nº de 
 * elementos de la bolsa a 0.De momento, como en este ejercicio estamos trabajando con arrays             
 * estáticos, esta función no hará nada con la memoria, pero sí reseteará el nº de elementos a 0 */

void freeBag (BAG * pb){
    
    iniBag(pb);
}
