/* 
 * File:   main.c
 * Author: oscar
 *
 * Created on 27 de marzo de 2014, 13:09
 */

#include "order.h"
#include <time.h>
/*
 * 
 */
int
main (int argc, char** argv)
{
   
   FILE *file;
   BSTREE arbol;
   ELEBTREE * ele;
   PHONE * phone;
   int p,numnodos=0,profundidad=0;
   clock_t tiempoIni=clock(),tiempo;
   long n;

   if (argc != 2)
       return EXIT_FAILURE;
   
   file = fopen( argv[1], "r");
   if (file == NULL)
   {
       printf ("error al abrir file");
       return EXIT_FAILURE;
   }
   
   /* crear arbol*/
   if (createBSTree (&arbol) == ERROR)
       return EXIT_FAILURE;
   
   /* leer del arbol */
    
    while(fscanf (file, "%d %ld", &p, &n)== 2)
    {
        phone = iniPhone(p, n);
        ele = createEleBTree(phone);
        if(insertBSTree(&arbol, ele)!=OK)
           {
            freePhone(phone);
        destroyEleBTree(ele); 
         destroyBSTree(&arbol);
       printf ("ERROR INSERTAR EN EL ARBOL");
       return EXIT_FAILURE;
   }
        freePhone(phone);
        destroyEleBTree(ele);        
    }  
   
   fclose(file);
   printf("\n El fichero es: %s",argv[1]);
   tiempo=clock();
   printf("\nTiempo: %ld segundos",(tiempo-tiempoIni)/CLOCKS_PER_SEC);
   numnodos=numNodesBSTree(&arbol);
   printf("\nNumero de nodos: %d", numnodos);
   profundidad=depthBSTree(&arbol);
   printf("\nProfundidad: %d",profundidad);
   /*printf("\nNodos en PreOrder: ");
    preOrderToFile(stdout,&arbol);
   printf("\nNodos en inOrder: ");
    inOrderToFile(stdout, &arbol);
    printf("\nNodos en PreOrder: ");
    postOrderToFile(stdout, &arbol);
   */
    do{
        printf("\n Introduce el numero");
        printf("\n prefijo: ");
        scanf("%d",&p);
        if(p)
          {  
            printf("\n numero: ");
            scanf("%ld",&n);
                      
            phone = iniPhone(p, n);
            ele = createEleBTree(phone);
            tiempoIni=clock();
            
            if(!lookBSTree(&arbol, ele))
              {
                printf("\nNo encontrado: ");
                printEleBTree(stdout,ele);
                tiempo=clock();
                printf("\nTiempo: %ld segundos",(tiempo-tiempoIni)/CLOCKS_PER_SEC);
              }
            else{
                printf("\nEncontrado: ");
                printEleBTree(stdout,ele); 
                tiempo=clock();
                printf("\nTiempo: %ld segundos",(tiempoIni-tiempo)/CLOCKS_PER_SEC);
              }
            freePhone(phone);
            destroyEleBTree(ele);        
          }
      }while(p);
      
   destroyBSTree(&arbol);
   
  return (EXIT_SUCCESS);
}

