 /* 
 * File:   main.c
 * Author: oscar y maria
 *
 * Created on 25 de febrero de 2014, 14:51
 */

#include "queue.h"

int main(int argc, char*argv[])
{
	int i = -8;
	QUEUE cola;
	ELEQUEUE elem;
	FILE *file = NULL;

        if(argc!=2)
          return EXIT_FAILURE;

	file = fopen( argv[1], "r");

 	if(!file||iniQueue(&cola)!=OK)
          return EXIT_FAILURE;

 	printf("se abre la caja\n");

	do {
		fscanf(file, "%d", &i);
		if(!feof(file))/*Evita que se inserte dos veces el ultimo coche*/
                  {
                    if (i != 0){
			elem = i;
                        printf("\nSe inserta al automovil: ");
                        printEleQueue (stdout, &elem);
			if(insertQueue(&cola, &elem)!=OK)
                          {
                            printf("Error insertar coche");
                            return EXIT_FAILURE;
                          }
                    }else if (i == 0) {
			extractQueue(&cola, &elem);
			printf ("\nSe cobra al automovil: ");
			printEleQueue (stdout, &elem);
                    }/*fin del if*/
                  }
	}  while (!feof(file));

	printf ("\n\nSe cierra la caja\n");

	while (isEmptyQueue(&cola) == FALSE) {
		extractQueue (&cola, &elem);
		printf ("\nSe pasa a otra caja al automovil: ");
		printEleQueue (stdout, &elem);
	}/*fin del while*/

        fclose(file);
        destroyQueue(&cola);
        return EXIT_SUCCESS;
} /*fin del main*/
