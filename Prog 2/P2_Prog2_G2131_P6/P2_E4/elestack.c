/* 
 * File:   elestack.c
 * Author: María y Oscar
 *
 * Created on 15 de febrero de 2014, 14:10
 */

#include "elestack.h"

/*
 * 
 */
/* Inicializa un elemento de pila con el elemento que le pasan */ 
ELESTACK *iniEleStack (ELESTACK *dst, const ELESTACK *src){
    
     return copyEleStack(dst,src); 
}
/* Copia el elemento fuente src en el destino dst. Los elementos de entrada son el elemento a 
copiar y el elemento donde va a ser copiado. Devuelve un puntero al elemento copiado (= la 
dirección del mismo) o NULL en caso de error */ 
ELESTACK *copyEleStack (ELESTACK *dst, const ELESTACK *src){
    
    if(dst==NULL||src==NULL)
        return NULL;
        if (copyCoin (dst,src) == OK)
          return dst;
    return NULL;
}
/* Compara dos elementos. Devuelve TRUE en caso de ser iguales y si no FALSE */ 
BOOL cmpEleStack (const ELESTACK *ele1, const ELESTACK *ele2 ){
         
     return comparaMonedas (ele1,ele2); /* Si los dos elementos son iguales devuelve TRUE, sino FALSE */       
}

/* Imprime en un fichero ya abierto el elemento. */ 
void printEleStack (FILE *pf, const ELESTACK *ele){
    
   printCoin (pf, ele); 
}
/* Elimina un elemento. Tened en cuenta que ahora no estamos trabajando con memoria 
dinámica */ 
void destroyEleStack (ELESTACK *ele){
    
    freeCoin (ele);
}


