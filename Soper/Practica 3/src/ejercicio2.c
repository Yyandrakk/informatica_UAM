/**
*@brief El ejercicio 2 de la Practica 3 SOPER
*
*@file ejercicio2.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 10-03-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <errno.h>
#include <sys/shm.h>
#include <signal.h>

#define FILEKEY "/bin/cat"
#define KEY 1300

struct info{
	char nombre[80];
	int id;
};

struct info *buffer;

/**
*@brief manejador_SIGUSR1
*Imprime por pantalla el contenido del buffer
*
*@param sig Señal de entrada
*/
void manejador_SIGUSR1(int sig){
	printf("nombre: %s\nid: %d\n", buffer->nombre, buffer->id);
	signal(sig, manejador_SIGUSR1);
}

/**
*@brief Varios procesos usan memoria compartida
* Un proceso padre lee el contenido de la memoria compartida tras recibir una señal de sus procesos hijos que escriben en esa memoria.
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main(int argc, char *argv[]){
	int key, id_zone, num, i;
	int pid=1;
if(argc!=2){
	fprintf(stderr, "Fallo en el numero de paramentros de entrada ./ejercicio2 num\n" );
	return EXIT_FAILURE;
}
	key = ftok(FILEKEY, KEY);
	if (key == -1) {
		fprintf (stderr, "Error con key \n");
		exit(EXIT_FAILURE);
	}

	id_zone = shmget (key, sizeof(struct info)*1, IPC_CREAT | SHM_R | SHM_W);
	if (id_zone == -1) {
		fprintf (stderr, "Error con id_zone \n");
		exit(EXIT_FAILURE);
	}

	buffer = shmat (id_zone, (char *)0, 0);
	if (buffer == NULL) {
		fprintf (stderr, "Error reservando memoria compartida\n");
		exit(EXIT_FAILURE);
	}

	if(signal(SIGUSR1, manejador_SIGUSR1)==SIG_ERR){
		fprintf(stderr, "Error al inicializar un manejador de señales\n");
		exit(EXIT_FAILURE);
	}

	buffer->id=0;
	for(i=0; i<atoi(argv[1]); i++){
		if(pid!=0){
			if ((pid=fork()) <0 ){
				fprintf(stderr, "Error haciendo fork\n");
				exit(EXIT_FAILURE);
			}
		}

		if(pid==0){
			srand(getpid());
			num=rand()%11;
			sleep(num);

			fprintf(stdout, "Introduzca el nombre del cliente que quiere dar de alta (proceso %d):\n", i+1);
			scanf("%s", buffer->nombre);
			buffer->id++;

			kill(getppid(), SIGUSR1);
			exit(EXIT_SUCCESS);

		}
	}

	while(wait(NULL)!=-1);

	shmdt ((char *)buffer);
	shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
	exit(EXIT_SUCCESS);
}
