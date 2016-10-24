/**
*@brief El gestion del proyecto de la Practica 4 SOPER
*
*@file gestion.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 29-04-2016
**/
#include <string.h>
#include <sys/msg.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include "semaforos.h"

#define FILEKEY "/bin/cat"
#define KEY 1300

/**
*@brief Manejador para la alarma de 30 segundos
* Lanza un comando para generar un fichero
**/
void manejador_SIGALRM_30(int sig){
	signal(sig, SIG_IGN);
	char str[10],cadena[50];
	sprintf(str,"%d",getpid());
	sprintf(cadena,"SIGHUP_%d_lista_proc.txt",getpid());
  char *arg1[]={"ps", "-ef", "|", "grep", str ,"|" ,"grep", "-v", "grep",">",cadena, NULL};
	if(fork()==0){
		execvp(cadena, arg1);
		perror("Error en execvp\n");
		exit(EXIT_FAILURE);
	}

	alarm(30);
	signal(sig,manejador_SIGALRM_30);
}

/**
*@brief Proceso main(Gestion) del simulador
* Se encargade pedir el numero de asientos y alumnos de la simulacion, y lanzar todos los procesos.
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main(int argc, char *argv[]){

	int pid=1, key, id_zone, num, i, clave, id_cola,buffer,dev;
	int  mutex;
	int alumnos;
	unsigned short array_mutex[]={1,1};
	Aula *aula;

	clave = ftok ("/bin/ls", 2000); /*Misma clave que el proceso cooperante*/
	if (clave == (key_t)-1){
		perror("Error al obtener clave para cola mensajes \n");
		exit(EXIT_FAILURE);
	}
	/*
	 * Primera cola de mensaje para el proceso A y B
	 */
	id_cola= msgget (clave, 0600 | IPC_CREAT);
 	if (id_cola == -1){
	    	perror ("Error al obtener identificador para cola mensajes \n");
	    	exit(EXIT_FAILURE);
	}

	key = ftok(FILEKEY, KEY+600);
	if (key == -1) {
		fprintf (stderr, "Error con key \n");
		exit(EXIT_FAILURE);
	}

	id_zone = shmget (key, sizeof(Aula)*2, IPC_CREAT | SHM_R | SHM_W);
	if (id_zone == -1) {
		fprintf (stderr, "Error con id_zone \n");
		exit(EXIT_FAILURE);
	}

	aula = shmat (id_zone, (char *)0, 0);
	if (aula == NULL) {
		fprintf (stderr, "Error reservando memoria compartida\n");
		exit(EXIT_FAILURE);
	}

	key = ftok(FILEKEY, KEY+100);
	if (key == -1) {
	 	fprintf (stderr, "Error con key \n");
		shmdt ((char *)aula);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
	 	exit(EXIT_FAILURE);
	}

	dev=Crear_Semaforo(key, 2, &mutex);
	if(Inicializar_Semaforo(mutex, array_mutex)==ERROR){
		printf("Error al incializar mutex\n");
		shmdt ((char *)aula);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}


	printf("Introduzca numero de asientos disponibles en el aula 1:\n");
	scanf("%d", &aula[0].disponible);
	aula[0].total=aula[0].disponible;
	aula[0].asientos=(int *)calloc(aula[0].total, sizeof(int));
	if(aula[0].asientos==NULL){
		fprintf (stderr, "Error reservando memoria\n");
		shmdt ((char *)aula);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	printf("Introduzca numero de asientos disponibles en el aula 2:\n");
	scanf("%d", &aula[1].disponible);
	aula[1].total=aula[1].disponible;
	aula[1].asientos=(int *)calloc(aula[1].total, sizeof(int));
	if(aula[1].asientos==NULL){
		fprintf (stderr, "Error reservando memoria\n");
		shmdt ((char *)aula);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	do{
		printf("Introduzca el numero de alumnos (debe ser menor que el numero total de sitios disponibles y mayor que el numero de sitios del aula mas grande):\n");
		scanf("%d", &alumnos);
	}while(alumnos>(aula[0].disponible+aula[1].disponible) || alumnos<aula[0].disponible || alumnos<aula[1].disponible);

	/*Creamos profesores*/
	for(i=0; i<4; i++){
		if(pid!=0){
			if ((pid=fork()) <0 ){
				fprintf(stderr, "Error haciendo fork\n");
				shmdt ((char *)aula);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}
		}
		else{
			if(i%2==0){
				gestion_profesor(getpid(), aula, 0);
				exit(EXIT_SUCCESS);
			}
			else{
				gestion_profesor(getpid(), aula, 1);
				exit(EXIT_SUCCESS);
			}
		}
	}

	/*Creamos profesores_examen*/
	for(i=0; i<2; i++){
		if(pid!=0){
			if ((pid=fork()) <0 ){
				fprintf(stderr, "Error haciendo fork\n");
				shmdt ((char *)aula);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}
		}
		else{
			if(i%2==0){
				gestion_profesor_examen(getpid(), aula, 0);
				exit(EXIT_SUCCESS);
			}
			else{
				gestion_profesor_examen(getpid(), aula, 1);
				exit(EXIT_SUCCESS);
			}
		}
	}

	/*Creamos alumnos*/
	for(i=0; i<alumnos; i++){
		if(pid!=0){
			if ((pid=fork()) <0 ){
				fprintf(stderr, "Error haciendo fork\n");
				shmdt ((char *)aula);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}
		}
		else{
			srand(getpid());
			num=rand()%6;
			sleep(num);

			gestion_alumno(getpid());
			exit(EXIT_SUCCESS);
		}
	}
	signal(SIGALRM, manejador_SIGALRM_30);
	alarm(30);

	while(wait(NULL)!=0);
	shmdt ((char *)aula);
	shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
	msgctl(id_cola,IPC_RMID,(struct msqid_ds*)NULL);
	exit(EXIT_SUCCESS);
}
