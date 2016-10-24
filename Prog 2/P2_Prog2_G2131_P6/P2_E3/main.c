/* 
 * File:   main.c
 * Author: oscar
 *
 * Created on 13 de febrero de 2014, 13:11
 */

#include "stack.h"

int main(int argc, char** argv) {
 
   
    
    int nenteros=0,i;
    VALUE valor=0;
    char pais[LMAX];
    ELESTACK ele;
    FILE *write=stdout,*read=stdin;
    STACK pila;

    if(argc!=2||iniStack(&pila)!=OK)
        return EXIT_FAILURE;
    
    nenteros = atoi(argv[1]);
    
    for (i=1;i<=nenteros;i++)
    {
        fprintf(write,"\nEscribe el %dº moneda\n",i);
        fprintf(write,"\nEscribe el valor de la moneda\n");
        fscanf(read,"%d",&valor);
        fprintf(write,"\nEscribe el pais de la moneda\n");
        fscanf(read,"%s",pais);
        fprintf(write,"\nInserta la moneda %d = ",i);
      
        if (iniCoin(&ele,valor,pais)!=OK)
          {
            printf("Error al inicializar la moneda");
            return EXIT_FAILURE;
          }  
        printEleStack(stdout,&ele);

        if( push(&pila,&ele)!=OK)
          {
            fprintf(write,"Pila llena o argumentos pasados a NULL");
            return EXIT_FAILURE;
          } 
    }
    printf("\n");
    printStack (stdout, &pila);
    destroyEleStack(&ele);
    if(destroyStack (&pila)!=OK)
        return EXIT_FAILURE;
 
    
    
    return (EXIT_SUCCESS);
}

