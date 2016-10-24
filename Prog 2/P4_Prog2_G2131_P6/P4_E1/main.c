/* 
 * File:   main.c
 * Author: oscar
 *
 * Created on 27 de marzo de 2014, 13:09
 */

#include "bSTree.h"

/*
 * 
 */
int
main (int argc, char** argv)
{
   
   FILE * file;
   BSTREE arbol;
   ELEBTREE * ele;
   PHONE * phone;
   int i, p,numnodos=0,profundidad=0;
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
    
    for (i = 0; fscanf (file, "%d %ld", &p, &n)== 2; i++)
    {
        phone = iniPhone(p, n);
        ele = createEleBTree(phone);
        insertBSTree(&arbol, ele);
        printEleBTree(stdout, ele);
        printf("\n");
        freePhone(phone);
        destroyEleBTree(ele);        
    }  
   numnodos=numNodesBSTree(&arbol);
   printf("\nNumero de nodos: %d", numnodos);
   profundidad=depthBSTree(&arbol);
   printf("\nProfundidad: %d",profundidad);
   
   destroyBSTree(&arbol);
   fclose(file);
           
  return (EXIT_SUCCESS);
}

