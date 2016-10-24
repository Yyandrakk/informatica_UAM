/**
*@brief El ejercicio 3 apartado a) de la Practica 2 SOPER
*
*@file ejercicio3a.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 22-02-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

/**
*@brief Calculador de tiempo de procesos
*Calcula el tiempo que tarda en crearse 100 procesos que imprimen un numero aleatorio
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main (void){
	clock_t tiempo;
	int pid=1;
	int num, i;

	tiempo=clock();


	for(i=0; i<100; i++){
		if ((pid=fork()) <0 ){
			printf("Error haciendo fork\n");
			exit(EXIT_FAILURE);
		}
		else if (pid ==0){
			srand(getpid());
			num=rand();
			printf("%d\n", num);
			break;
		}
	}

	while(wait(NULL)!=-1);

	if(pid!=0)
		printf("%f s\n", (clock()-tiempo)/(double)CLOCKS_PER_SEC);

	exit(EXIT_SUCCESS);
}
