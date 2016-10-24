/* 
 * File:   coin.h
 * Author: Oscar y Maria
 * Pareja: 6
 *
 */

#ifndef COIN_H
#define	COIN_H

/* includes, defines y/o typedefs que necesites */
#include "type.h"

#define LMAX 20

typedef int VALUE;

typedef struct {
    VALUE valor;
    char pais[LMAX];
}COIN;


        /* Inicializa una moneda, copiando value y country en los campos correspondientes de la estructura, 
             devolviendo OK si lo ha hecho correctamente o ERROR si no */       
        STATUS iniCoin (COIN * pc, const VALUE value, const char country []);   

         /* Devuelve el valor de una moneda dada, o -1 si se produce algun error */	      
        VALUE getValueCoin (const COIN * pc);
                
         /* Devuelve el pais de una moneda dada, o NULL si se produce algun error */
	char * getCountryCoin (const COIN * pc); 
                        
         /* Copia los datos de una moneda a otra (de pOrigin a pDest. */
	STATUS copyCoin (COIN * pDest, const COIN * pOrigin); 
        
         /* Imprime el valor y el pais de una moneda con el siguiente formato: {valor, pais}. 
          * Por ejemplo, una moneda de 5 centimos alemana se representara como {5, Germany} */
	void printCoin (FILE *pf, const COIN * pc); 
        
         /* Libera la memoria dinamica reservada para una moneda. De momento, como en este ejercicio 
          * estamos trabajando con arrays estaticos, esta funcion no hara nada */
	void freeCoin (COIN * pc); 
        
        
        /*AUXILIAR*/
        
/*Comprueba que la moneda este entre los valores validos*/
STATUS valorValido (const VALUE *valor);
#endif	/* COIN_H */

