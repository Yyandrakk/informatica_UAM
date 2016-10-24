/* 
 * File:   main.c
 * Author: oscar
 *
 * Created on 10 de marzo de 2014, 18:34
 */

#include "list.h"

int main ()
{
    LIST l;    
    ELELIST s;
    char cadena[20];
    int control=1;
    iniList(&l);
   
   do
     { 
       do{
           if(!control)
              printf("ERROR: Inserte un numero: ");
            printf("intruduce un numero: ");
            scanf ("%s", cadena);
            control=sscanf(cadena,"%d",&s);
         }while(!control);
       
         if(s)
          insertInOrderList (&l,&s); 
     
     }while(s);
     
      printList(stdout, &l);
      freeList(&l);
  return (EXIT_SUCCESS);
}

