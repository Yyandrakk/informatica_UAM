/**
*@brief El ejercicio 4b de la Practica 1 SOPER
*
*@file ej4b.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 18-02-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>

#define NUM_PROC 3
/**
*@brief Crea procesos
*Crea 8 procesos y muestras sus PID para crear procesos huerfanos.
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main (void){
	int pid;
	int i;

	for (i=0; i < NUM_PROC; i++){
		if ((pid=fork()) <0 ){
			printf("Error haciendo fork\n");
			exit(EXIT_FAILURE);
		}else if (pid ==0){
			printf("HIJO %d\nPID PADRE %d\n", getpid(), getppid());
			sleep(10);
		}else{
			printf ("PADRE %d\n", getpid());
		}
	}

	wait(NULL);
	exit(EXIT_SUCCESS);
}
