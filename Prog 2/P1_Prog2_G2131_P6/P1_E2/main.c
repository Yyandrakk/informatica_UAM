/* 
 * File:   main.c
 * Author: Oscar y Maria
 * Pareja: 6
 */
#include "bag.h"

int main() {
   
    ELEMBAG e1=3, e2=6, e3=9;
    BAG b1, b2;
    
    printElemBag (stdout, &e1);     printf ("\n");    
    printElemBag (stdout, &e2);     printf ("\n");
    printElemBag (stdout, &e3);     printf ("\n");
    
    printf ("Inicializando bolsa...\n");
    iniBag (&b1);
    printBag (stdout, &b1);       
    
    printf ("\nInsertando elementos...\n");
    insertElemBag (&b1, &e1);
    printBag (stdout, &b1);
    
    insertElemBag (&b1, &e2); 
    printBag (stdout, &b1);
    
    insertElemBag (&b1, &e3); 
    printBag (stdout, &b1);
    
    if (insertElemBag (&b1, &e3) == ERROR) /* probamos a insertar en bolsa llena*/
        printf ("\nBolsa 1 llena\n");
    else
        printBag (stdout, &b1);
    
    printf ("Copiando bolsa 1 en bolsa 2...\n");
    copyBag (&b2, &b1);
    
    printf ("Extrayendo elementos de bolsa 1...\n");

    extractElemBag (&b1, &e1);
    printBag (stdout, &b1);
   
    extractElemBag (&b1, &e1);
    printBag (stdout, &b1);
   
    extractElemBag (&b1, &e1);
    printBag (stdout, &b1);
   
    if (extractElemBag (&b1, &e1) == ERROR)  /* probamos a extraer de bolsa vacía */
        printf ("\nBolsa 1 vacia\n");
    else
        printBag (stdout, &b1);
    
    printf ("Estado de la bolsa 2:\n");
    printBag (stdout, &b2);
    
    printf ("\nLiberando bolsa 2...\n");
    freeBag (&b2);
    printf ("Estado de la bolsa 2:\n");
    printBag (stdout, &b2);
    
        
    return (EXIT_SUCCESS);
}

