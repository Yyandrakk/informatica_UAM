/**
*@brief El ejercicio 3 apartado b) de la Practica 2 SOPER
*
*@file ejercicio3b.c
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
#include <pthread.h>

/**
*@brief imprime_aleat
*
*Imprime un numero aleatorio
*@param parametro de tipo ARG
*/
void* imprime_aleat(void *arg){
	int num,i;

	num=rand();
	printf("%d\n", num);
  pthread_exit(&i);
}

/**
*@brief Calculador de tiempo de hilos
*Calcula el tiempo que tarda en crearse 100 hilos que imprimen un numero aleatorio
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main (void){
	clock_t tiempo;
	int i;
	pthread_t h1;

	tiempo=clock();
	srand(pthread_self());


	for(i=0; i<100; i++){
		pthread_create(&h1, NULL, imprime_aleat, NULL);
	}

	pthread_join(h1, NULL);
	printf("%f s\n", (clock()-tiempo)/(double)CLOCKS_PER_SEC);

	exit(EXIT_SUCCESS);
}
