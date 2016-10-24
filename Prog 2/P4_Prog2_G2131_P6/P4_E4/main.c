/* 
 * File:   main.c
 * Author: María
 *
 * Created on 22 de abril de 2014, 17:29
 */

#include "order.h"

/*
 * 
 */
int main(int argc, char** argv) {

    FILE *file;
    char datos[LMAX],nombre[LMAX],nomcoin[LMAX];
    int limitep=0,limitec=0,valor=0,i,prefix=0,j;
    long numero=0;
    BAG monedero;
    BSTREE arbol,elemento;
    PERSON persona;
    COIN c;
    PHONE *telefono;
   if(argc!=2)
          return EXIT_FAILURE;
   file = fopen( argv[1], "r");
   if(!file)
       return EXIT_FAILURE;
   if(feof(file)!=0)/* si el fichero esta vacio para el programa*/
     {
        fprintf(stdout,"FICHERO VACIO \n");
        fclose(file);
        return (EXIT_SUCCESS);
     }
   if(createBSTree(&arbol)!=OK||iniBag (&monedero)!=OK)
     {
        fprintf(stdout,"ERROR CREAR ARBOL\n");
        fclose(file);
        return (EXIT_SUCCESS);
     }
   fscanf(file,"%s",datos);
   if( sscanf(datos,"%d",&limitep)!=0&&limitep!=0)/* Si el carcter leido no es un numero o es 0 evita que se ejute*/
      {
            for(i=0;i<limitep;i++)
             {
                fscanf(file,"%s",nombre);
                fscanf(file,"%s",datos);
                if(sscanf(datos,"%d",&limitec)==0)/* Evita que no pase un numero de monedas*/
                {
                    fprintf(stdout,"\nERROR NUMERO DE MONEDAS\n");
                    destroyBSTree(&arbol);
                    fclose(file);
                    return EXIT_FAILURE;
                }
       
                /* En el caso que se haya pasado mal el numero de personas 
                * y se termina el fichero antes, deja de coger personas e imprime las que se tiene*/
                if(feof(file)!=0)                   
               {
                   break;
               } 
                for(j=0,valor=0;j<limitec;j++)
                {
                    fscanf(file,"%d",&valor);
                    fscanf(file,"%s",nomcoin);
                    if(iniCoin(&c,valor,nomcoin)!=OK||insertElemBag (&monedero, &c)!=OK)
                    {
                        fprintf(stdout,"ERROR INICIALIZAR MONEDA O INSERTAR MONEDA");
                         freeBag(&monedero);
                       destroyBSTree(&arbol);
                        fclose(file);
                        return EXIT_FAILURE;
                    }     
                }
                fscanf(file,"%d %ld",&prefix,&numero);
                
                if(iniEmptyPerson(&persona,strlen(nombre)+1)!=OK)
                {
                    fprintf(stdout,"ERROR INICIALIZAR PERSONA VACIA");
                         freeBag(&monedero);
                     destroyBSTree(&arbol);
                        fclose(file);
                        return EXIT_FAILURE;
                }
                
                telefono=iniPhone(prefix,numero);
                        
              if(iniPersonWithName(&persona,nombre,&monedero,telefono)!=OK)
                  {
                    fprintf(stdout,"ERROR INICIALIZAR PERSONA");
                         freeBag(&monedero);
                     destroyBSTree(&arbol);
                        fclose(file);
                        return EXIT_FAILURE;
                }
                
              if(insertBSTree(&arbol,(ELEBTREE*)&persona))               {
                    fprintf(stdout,"ERROR INSERTAR EN EL ARBOL");
                         freeBag(&monedero);
                        destroyBSTree(&arbol);
                        fclose(file);
                        return EXIT_FAILURE;
                }
                freeBag(&monedero);
                freePerson(&persona);
                freePhone(telefono);
            }
   }
        
    printf("\nNodos en PreOrder: ");
    preOrderToFile(stdout,&arbol);
    printf("\nNodos en inOrder: ");
    inOrderToFile(stdout, &arbol);
    printf("\nNodos en PreOrder: ");
    postOrderToFile(stdout, &arbol);
   
    do{
        printf("\n Introduce el numero");
        printf("\n prefijo: ");
        scanf("%d",&prefix);
        if(prefix)
          {  
            printf("\n numero: ");
            scanf("%ld",&numero);
                     
            telefono=iniPhone(prefix,numero);
            iniEmptyPerson(&persona,4);
            iniPersonWithName(&persona,"Per",&monedero,telefono);
            if(!(elemento=lookBSTree(&arbol,(ELEBTREE*)&persona)))
              {
                printf("\nNo encontrado");
                
                freePhone(telefono);
                freePerson(&persona);
              }
            else{
                printf("\nEncontrado: ");
                printEleBTree(stdout,INFO(elemento));   
                freePhone(telefono);
                 freePerson(&persona);
              }
                    
          }
      }while(prefix);
      
   destroyBSTree(&arbol);
   fclose(file);
   return (EXIT_SUCCESS);
}
