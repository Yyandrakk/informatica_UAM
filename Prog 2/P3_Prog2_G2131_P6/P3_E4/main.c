/* 
 * File:   main1.c
 * Author: María
 *
 * Created on 13 de marzo de 2014, 14:26
 */

#include "list.h"
#define LMAX 30
int main(int argc, char** argv) {

  /*  lee del fichero
    inserta en la lista
    imprime la lista
    extrae de la lista
    lista vacia*/
    LIST lista;
    ELELIST elem=iniEleList(30);
    char datos[LMAX];
    FILE *file;
    int limite, i;
    
    if(argc!=2||!elem)
          return EXIT_FAILURE;
        
	file = fopen( argv[1], "r");
        if (!file || iniList(&lista) == ERROR){
            if (file)
                fclose (file);
            return EXIT_FAILURE;
        }
        fscanf (file, "%s", datos);
        if(sscanf(datos,"%d",&limite)==1)
          {
            for (i=0; i<limite; i++)
              {
                fscanf (file, "%s", elem);
                insertFirstEleList (&lista, &elem);
              }
        
            printList(stdout, &lista);
            printf ("\n\n");
        
            while (extractFirstEleList (&lista, &elem) == OK)
                {
                    printEleList (stdout, &elem);
                    printf("\n");
                }
            if (isEmptyList(&lista)== TRUE )
                 printf("\nla lista esta vacia\n");
           }
        
        freeEleList(&elem);
        fclose(file);
    return (EXIT_SUCCESS);
}
