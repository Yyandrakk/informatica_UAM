/**
*@brief El ejercicio 4a de la Practica 1 SOPER
*
*@file ej4a.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 18-02-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#define NUM_PROC 3
/**
*@brief Crea procesos
*Crea 8 procesos y muestras sus PID
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main (void){
	int pid;
	int i;

	for (i=0; i < NUM_PROC; i++){
		if ((pid=fork()) <0 ){
			printf("Error al emplear fork\n");
			exit(EXIT_FAILURE);
		}else if (pid ==0){
			printf("HIJO %d\nPID PADRE %d\n", getpid(), getppid());
			sleep(20);
		}else{
			printf ("PADRE %d \n", getpid());
			/*Aqui pondriamos el sleep para que de tiempo a terminar a los procesos hijo*/
		}
	}

	exit(EXIT_SUCCESS);
}
