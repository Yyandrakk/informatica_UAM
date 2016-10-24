/* 
 * File:   bag.c
 * Author: oscar y maria
 *
 * Created on 24 de enero de 2014, 12:05
 */

#ifndef BAG_H
#define	BAG_H




/* includes, defines y/o typedefs que necesites */

#include "elembag.h"
#define MAXBAG 20

typedef struct{
    int nelemsBag;
    ELEMBAG elemsBag[MAXBAG];
}BAG;




         /* Inicializa una bolsa de modo que esté vacía, lista para introducir elementos */	
        STATUS iniBag (BAG * pb);   

        /* Devuelve el nº de elementos que contiene la bolsa cuando se invoca a esta primitiva, o -1 si error. */
	unsigned short getNelemsBag (const BAG * pb);
        
        /* Inserta el elemento cuya dirección se encuentra en pElem en la bolsa cuya dirección se encuentra en 
         * pb. Devuelve OK si se ha logrado insertar, ERROR si no */
	STATUS insertElemBag (BAG * pb, const ELEMBAG * pElem);
        
        /* Extrae un elemento de la bolsa y lo coloca en la dirección que indica pElem. Devuelve OK si se ha 
	logrado realizar la operación, ERROR si no */
	STATUS extractElemBag (BAG * pb, ELEMBAG * pElem); 

         /* Copia una bolsa en otra, copiando el número de elementos de la misma y cada uno de ellos.
	Devuelve OK si todo ha ido bien */
	STATUS copyBag (BAG * pDest, const BAG * pOrigin);
        
        /* Imprime el contenido de la bolsa en pf. Primero imprime el nº de elementos que contiene y después, 
	uno por uno, cada uno de sus elementos. */
        void printBag (FILE* f, const BAG * pb);
        
  	/* Libera la memoria ocupada por la bolsa, liberando uno a uno sus elementos, si fuera necesario, y 
         * finalmente liberando  la memoria dinámica reservada para la bolsa, si fuera el caso. Pone el nº de 
         * elementos de la bolsa a 0.De momento, como en este ejercicio estamos trabajando con arrays             
         * estáticos, esta función no hará nada con la memoria, pero sí reseteará el nº de elementos a 0 */

	void freeBag (BAG * pb); 


#endif	/* BAG_H */

