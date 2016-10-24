/* 
 * File:   main.c
 * Author: oscar
 *
 * Created on 13 de marzo de 2014, 13:14
 */

#include "queue.h"
#include "stack.h"

/*
 * 
 */
int main (int argc, char** argv)
{
  int limite=0,i,control;
  char cadena[20];
  ELELIST e;
  QUEUE q;
  STACK s;
  if(argc!=2)
    return EXIT_FAILURE;
  
  limite=atoi(argv[1]);
  
  if(!limite)
    return EXIT_SUCCESS;
  
 iniStack(&s);
 iniQueue(&q); 
  for(i=0,control=1;i<limite;i++)
    {
      do{
           if(!control)
              printf("ERROR: Inserte un numero: ");
            printf("intruduce un numero: ");
            scanf ("%s", cadena);
            control=sscanf(cadena,"%d",&e);
         }while(!control);
         if(push(&s, &e)!=OK)
           return EXIT_FAILURE;
    }
  printf("La pila contiene %d elementos: ",numElemsList(&s));
  printStack (stdout,&s);
  printf("\n");
  while(pop(&s,&e)==OK)
    {
       if(insertQueue(&q, &e)!=OK)
         return EXIT_FAILURE;
    }
   printf("La cola contiene %d elementos: ",sizeOfQueue(&q));    
  printQueue(stdout, &q);
  printf("\n");
  freeQueue(&q);
  return (EXIT_SUCCESS);
}
