/* 
 * File:   main.c
 * Author: Oscar y Maria
 * Pareja: 6
 *
 */

#include "coin.h"

/*
 * 
 */
int main() {
    COIN esp,ale;
    char *nomPais;
    if(iniCoin (&esp, 5,"España")!=OK)
        return EXIT_FAILURE;
    if(iniCoin (&ale, 2,"Alemania")!=OK) 
        return EXIT_FAILURE;
    
    printCoin (stdout, &esp);
    printCoin (stdout, &ale);
    
    printf("\nEl valor de la primera moneda es: %d \n",getValueCoin (&esp));
    
    nomPais=getCountryCoin (&ale);
    
    if (nomPais== NULL)
        return EXIT_FAILURE;
    
    printf("El pais de la segunda moneda es: %s \n",nomPais);
    
    if(copyCoin (&ale, &esp)!=OK) 
        return EXIT_FAILURE;
    
    printCoin (stdout, &esp);
    printCoin (stdout, &ale);
    
    freeCoin(&esp);
    freeCoin(&ale);
    
    return (EXIT_SUCCESS);
}

