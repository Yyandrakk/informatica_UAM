/* 
 * File:   main.c
 * Author: oscar y maria
 *
 * Created on 13 de febrero de 2014, 13:11
 */

#include "stack.h"

int main(int argc, char** argv) {

    int nenteros=0,i,errordato=1;
    char valor[20];
    ELESTACK ele;
    FILE *write=stdout,*read=stdin;
    STACK pila;

    if(argc!=2||iniStack(&pila)!=OK)
        return EXIT_FAILURE;
    
    nenteros = atoi(argv[1]);
    
    for (i=1;i<=nenteros;i++)
    {
        do{
            if(!errordato)
                  fprintf(write,"\n Error, escribe un numero.");
            fprintf(write,"\nEscribe el %dº elemento\n",i);
            fscanf(read,"%s",valor);
        }while((errordato=sscanf(valor,"%d",&ele))==0);
        fprintf(write,"\nInserta el elemento %d = ",i);
        printEleStack(write,&ele);
        if( push(&pila,&ele)!=OK)
          {
            fprintf(write,"Pila llena o argumentos pasados a NULL");
            return EXIT_FAILURE;
          }  
         
    }
    
    while(pop(&pila, &ele)==OK)
    {
        printEleStack(write,&ele);
    }   
    
    destroyEleStack(&ele);
    if(destroyStack (&pila)!=OK)
        return EXIT_FAILURE;
    return (EXIT_SUCCESS);
}

