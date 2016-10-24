/* 
 * File:   main.c
 * Author: oscar
 *
 * Created on 6 de marzo de 2014, 12:05
 */


#include "list.h"

/*
 * 
 */
int
main (int argc, char** argv)
{
  int limite=0,i,control;
  char cadena[20];
  ELELIST s;
  LIST l;
  if(argc!=2)
    return EXIT_FAILURE;
  
  limite=atoi(argv[1]);
  
  if(!limite)
    return EXIT_SUCCESS;
  
  iniList(&l);
  
  for(i=0,control=1;i<limite;i++)
    {
      do{
           if(!control)
              printf("ERROR: Inserte un numero: ");
            printf("intruduce un numero: ");
            scanf ("%s", cadena);
            control=sscanf(cadena,"%d",&s);
         }while(!control);
         
       if(s%2==0)  
         {
           if(insertFirstEleList (&l, &s)!=OK)
             return EXIT_FAILURE;
           printf("El elemento insertado: ");
           printEleList (stdout, &s);
           printf("\n");
           
           printf("La lista contiene %d elementos: ",numElemsList(&l));
           printList(stdout,&l);
           printf("\n");
           
           
         }
       else
         {
           if(insertLastEleList  (&l, &s)!=OK)
             return EXIT_FAILURE;
            printf("El elemento insertado: ");
           printEleList (stdout, &s);
           printf("\n");
           
           printf("La lista contiene %d elementos: ",numElemsList(&l));
           printList(stdout,&l);
           printf("\n");
         }
      
    }
    
  for(i=0;isEmptyList(&l)==FALSE;i++)
      if(i<limite/2)  
         {
           if(extractFirstEleList (&l, &s)!=OK)
             return EXIT_FAILURE;
           printf("El elemento extraido: ");
           printEleList (stdout, &s);
           printf("\n");
           
           printf("La lista contiene %d elementos: ",numElemsList(&l));
           printList(stdout,&l);
           printf("\n");
           
           
         }
       else
         {
           if(extractLastEleList  (&l, &s)!=OK)
             return EXIT_FAILURE;
            printf("El elemento extraido: ");
           printEleList (stdout, &s);
           printf("\n");
           
           printf("La lista contiene %d elementos: ",numElemsList(&l));
           printList(stdout,&l);
           printf("\n");
         }
    
  
  return (EXIT_SUCCESS);
}

