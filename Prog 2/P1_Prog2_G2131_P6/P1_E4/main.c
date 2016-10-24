/* 
 * File:   main.c
 * Author: oscar y maria
 * Pareja: 6
 *
 * Created on 30 de enero de 2014, 13:40
 */

#include "bag.h"

int main(int argc, char** argv) {

    FILE *fread, *fwrite;
    VALUE valor=0;
    int limite=0,i;
    char pais[LMAX];
    ELEMBAG elemento;
    BAG bolsa1, bolsa2;
      
      if(argc!=3)
      {
      	printf("ERROR LEER COMANDOS");
      	return EXIT_FAILURE;
      }
    
    fread=fopen(argv[1],"r");
    fwrite=fopen(argv[2],"w");
    
    if (fread==NULL||fwrite==NULL||iniBag(&bolsa1)!=OK||iniBag(&bolsa2)!=OK) 
        return EXIT_FAILURE;
        
    fscanf (fread, "%d",&limite); /* leemos el numero de elementos*/
    
    /* En el siguiente bucle leemos el valor y el pais, con ello lo inicializamos
     en un elemento y lo insertamos en la bolsa*/
    for (i=0;i<limite;i++)
    {
        fscanf(fread,"%d",&valor);
        fscanf(fread,"%s",pais);
        if(iniCoin(&elemento,valor, pais)!=OK||insertElemBag (&bolsa1, &elemento)!=OK)
            return EXIT_FAILURE;
    }
    
    if(copyBag (&bolsa2, &bolsa1)!=OK)
        return EXIT_FAILURE;
    
    printBag(fwrite,&bolsa1);
    
    printBag(fwrite,&bolsa2);
   
    /* El bucle extrae elementos hasta que return ERROR, que solo pasa cuando esta vacia la bolsa*/
    while(extractElemBag (&bolsa1,&elemento)==OK);
      
    printBag(fwrite,&bolsa1);
    
    printBag(fwrite,&bolsa2);
   
    
    freeBag(&bolsa2);

    
    printBag(fwrite,&bolsa1);
    
    printBag(fwrite,&bolsa2);
   
    fclose(fread);
    fclose(fwrite);
    
    return (EXIT_SUCCESS);
}

