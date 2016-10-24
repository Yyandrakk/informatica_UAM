/**
*@brief El ejercicio 8b de la Practica 1 SOPER
*
*@file ej8b.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 18-02-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <unistd.h>
/**
*@brief Ejecucion de comandos de la shell
*Ejecutamos un programa en Foreground o Background
*@param argc numero de argumentos de entrada
*@param argv array de argumentos de entrada
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main (int argc, char **argv){
	int pid=1;
	char *arg1[]={argv[1], NULL};

	if(strcmp("fg", argv[2])==0){
		printf("Foreground\n");
		execvp(argv[1], arg1);
		perror("Error en execvp\n");
		exit(EXIT_FAILURE);
	}
	else{

		if ((pid=fork()) <0 ){
			printf("Error haciendo fork\n");
			exit(EXIT_FAILURE);
		}else if (pid ==0){
			printf("Background\n");
			execvp(argv[1], arg1);
			perror("Error en execvp\n");
			exit(EXIT_FAILURE);
		}else{
			wait(NULL);

		}
	}

	exit(EXIT_SUCCESS);
}
