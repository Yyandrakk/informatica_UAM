/**
*@brief El ejercicio 6 de la Practica 2 SOPER
*
*@file ejercicio6.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 29-02-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <signal.h>

/**
*@brief Finalizador de procesos
*Finaliza un proceso hijo en bucle tras 30 segundos
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main (void){
	clock_t tiempo;
	int pid;
	int num, i;
	
	if ((pid=fork()) <0 ){
		printf("Error haciendo fork\n");
		exit(EXIT_FAILURE);
	}
	else if (pid ==0){
		while(1){		
			printf("Soy el proceso hijo con PID: %d\n", getpid());
			sleep(5);
		}
	}
	else{
		sleep(30);
		kill(pid, SIGTERM);
	}
	
	while(wait(NULL)!=-1);

	exit(EXIT_SUCCESS);
}
