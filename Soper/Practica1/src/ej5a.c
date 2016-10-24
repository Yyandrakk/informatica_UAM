/**
*@brief El ejercicio 5a de la Practica 1 SOPER
*
*@file ej5a.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 18-02-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <unistd.h>

#define NUM_PROC 3
/**
*@brief crea hijos
*Crea todos los procesos de forma secuencial
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
		}else{
			printf ("PADRE %d\n", getpid());
			break;
		}
	}

	wait(NULL);
	exit(EXIT_SUCCESS);
}
