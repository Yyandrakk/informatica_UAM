/**
*@brief El ejercicio 8a de la Practica 1 SOPER
*
*@file ej8a.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 18-02-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
/**
*@brief Ejecucion de comandos de la shell
*Ejecutamos el comando du -h para saber el tamaño del programa de ejecucion
*@param argc numero de argumentos de entrada
*@param argv array de argumentos de entrada
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main (int argc, char **argv){
	int pid=1;
	int i;
	char *arg[]={"du", "-h", argv[0], NULL};

	execvp("du", arg);
	perror("Error en execlp\n");

	exit(EXIT_FAILURE);
}
