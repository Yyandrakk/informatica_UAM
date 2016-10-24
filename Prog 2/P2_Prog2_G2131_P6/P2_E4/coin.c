/* 
 * File:   coin.c
 * Author: Oscar y Maria
 * Pareja: 6
 *
 */

#include "coin.h"


/* Inicializa una moneda, copiando value y country en los campos correspondientes de la estructura, 
   devolviendo OK si lo ha hecho correctamente o ERROR si no */       
STATUS iniCoin (COIN * pc, const VALUE value, const char country [])
{
    if (pc == NULL || valorValido(&value)!=OK)
        return ERROR;
    
    
    
    pc->valor=value;
    
    strcpy(pc->pais,country);
    
    return OK;
    
}

/* Devuelve el valor de una moneda dada, o -1 si se produce algun error */	      
VALUE getValueCoin (const COIN * pc)
{
     if (pc == NULL)
        return -1;
     
     return pc->valor;
     
    
}
                
/* Devuelve el pais de una moneda dada, o NULL si se produce algun error */
char * getCountryCoin (const COIN * pc){
         
    if (pc==NULL)
        return NULL;
  
    
    return (char*)pc->pais;
} 
                        
/* Copia los datos de una moneda a otra (de pOrigin a pDest. */
STATUS copyCoin (COIN * pDest, const COIN * pOrigin)
{
     if (pDest==NULL || pOrigin==NULL)
        return ERROR;
     
     pDest->valor=pOrigin->valor;
     
     strcpy( pDest->pais,pOrigin->pais);
     
     return OK;
}
        
/* Imprime el valor y el pais de una moneda con el siguiente formato: {valor, pais}. 
 * Por ejemplo, una moneda de 5 centimos alemana se representara como {5, Germany} */
void printCoin (FILE *pf, const COIN * pc)
{
    fprintf(pf,"{%d,%s}",pc->valor,pc->pais);
}
        
/* Libera la memoria dinamica reservada para una moneda. De momento, como en este ejercicio 
 * estamos trabajando con arrays estaticos, esta funcion no hara nada */
void freeCoin (COIN * pc)
{}

/*AUXILIAR*/
/*Comprueba que la moneda este entre los valores validos*/
STATUS valorValido (const VALUE *valor)
{
    if (valor==NULL||(*valor!=5&&*valor!=10&&*valor!=20&&*valor!=50&&*valor!=1&&*valor!=2))
        return ERROR; 
    
        return OK;
}

BOOL comparaMonedas(const COIN * moneda1,const COIN * moneda2)
{
  if(moneda1->valor==moneda2->valor && strcmp(moneda1->pais,moneda2->pais)==0)
    return TRUE;
  
  return FALSE;
}