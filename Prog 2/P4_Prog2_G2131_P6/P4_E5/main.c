/* 
 * File:   main.c
 * Author: oscar
 *
 * Created on 9 de abril de 2014, 17:17
 */

#include "order.h"

/*
 * 
 */
int
main (int argc, char** argv)
{ 
   FILE *entrada, *salida;
   BSTREE arbol;
   LIST l;
   ELEBTREE * ele;
   PHONE * phone;
   int p;
   long n;

   if (argc != 3)
       return EXIT_FAILURE;
   
   entrada = fopen( argv[1], "r");
   salida = fopen(argv[2],"w");
   if (entrada == NULL||!salida)
   {
       if(entrada)
         fclose(entrada);
       printf ("error al abrir file");
       return EXIT_FAILURE;
   }
   
   /* crear arbol*/
   if (createBSTree (&arbol) == ERROR)
       return EXIT_FAILURE;
  
   if (iniList (&l) == ERROR)
       return EXIT_FAILURE;
   /* leer del arbol */
    
    while(fscanf (entrada, "%d %ld", &p, &n)== 2)
    {
        phone = iniPhone(p, n);
        ele = createEleBTree(phone);
        insertBSTree(&arbol, ele);
        freePhone(phone);
        destroyEleBTree(ele);        
    }  
  if(preOrderToList(&l,&arbol)!=OK)
    return EXIT_FAILURE;
            
    fprintf(salida,"\nArbol en preOrder: ");
    preOrderToFile(salida,&arbol);
    fprintf(salida,"\n\nLista en preOrder: ");
    printList(salida,&l);
    
    destroyBSTree(&arbol);
    freeList(&l);
    fclose(entrada);
    fclose(salida);
  return (EXIT_SUCCESS);
}

