/**
*@brief El ejercicio 5 de la Practica 3 SOPER
*
*@file ejercicio5.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 28-03-2016
**/
#include <string.h>
#include <signal.h>

#include "semaforos.h"

#define N 100
#define FILEKEY "/bin/cat"

typedef int item;
item *buffer;

/**
*@brief Test de prueba para la libreria semaforos
* Este test ejecuta el problema del productor-consumidor empleando las funciones de la libreria semaforos
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main(int argc, char *argv[]){
	item array[N];
	int mutex, vacio, lleno;
	int key, pid, id_zone, i;
	unsigned short valor_m[]={1}, valor_v[]={N}, valor_l[]={0};

	for(i==0; i<N; i++)
		array[i]=i+1;

	/*Crear memeoria compartida*/
	key = ftok(FILEKEY, 1400);
	if (key == -1) {
		fprintf (stderr, "Error con key \n");
		exit(EXIT_FAILURE);
	}

	id_zone = shmget (key, sizeof(item)*1, IPC_CREAT | SHM_R | SHM_W);
	if (id_zone == -1) {
		fprintf (stderr, "Error con id_zone \n");
		exit(EXIT_FAILURE);
	}	

	buffer = shmat (id_zone, (char *)0, 0);
	if (buffer == NULL) {
		fprintf (stderr, "Error reservando memoria compartida\n");
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	/*Incializar mutex*/
	key = ftok(FILEKEY, 1300);
	if (key == -1) {
		fprintf (stderr, "Error con key \n");
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	if(Crear_Semaforo(key, 1, &mutex)==ERROR){
		fprintf (stderr, "Error al crear mutex \n");
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	if(Inicializar_Semaforo(mutex, valor_m)==ERROR){
		fprintf (stderr, "Error al inicializar mutex \n");
		Borrar_Semaforo(mutex);
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	/*Incializar vacio*/
	key = ftok(FILEKEY, 1200);
	if (key == -1) {
		fprintf (stderr, "Error con key \n");
		Borrar_Semaforo(mutex);
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	if(Crear_Semaforo(key, 1, &vacio)==ERROR){
		fprintf (stderr, "Error al crear vacio \n");
		Borrar_Semaforo(mutex);
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	if(Inicializar_Semaforo(vacio, valor_v)==ERROR){
		fprintf (stderr, "Error al inicializar vacio \n");
		Borrar_Semaforo(mutex);
		Borrar_Semaforo(vacio);
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	/*Incializar lleno*/
	key = ftok(FILEKEY, 1100);
	if (key == -1) {
		fprintf (stderr, "Error con key \n");
		Borrar_Semaforo(mutex);
		Borrar_Semaforo(vacio);
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	if(Crear_Semaforo(key, 1, &lleno)==ERROR){
		fprintf (stderr, "Error al crear lleno \n");
		Borrar_Semaforo(mutex);
		Borrar_Semaforo(vacio);
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}

	if(Inicializar_Semaforo(lleno, valor_l)==ERROR){
		fprintf (stderr, "Error al inicializar lleno \n");
		Borrar_Semaforo(mutex);
		Borrar_Semaforo(vacio);
		Borrar_Semaforo(lleno);
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}
	
	if ((pid=fork()) <0 ){
		fprintf(stderr, "Error haciendo fork\n");
		Borrar_Semaforo(mutex);
		Borrar_Semaforo(vacio);
		Borrar_Semaforo(lleno);
		shmdt ((char *)buffer);
		shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
		exit(EXIT_FAILURE);
	}
	else if(pid!=0){
		/*Productor*/
		item itemp;

		for(i=0; i<N; i++){
			itemp=array[i];
			
			if(Down_Semaforo(vacio, 0, SEM_UNDO)==ERROR){
				fprintf (stderr, "Error en down vacio\n");
				Borrar_Semaforo(mutex);
				Borrar_Semaforo(vacio);
				Borrar_Semaforo(lleno);
				shmdt ((char *)buffer);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}

			if(Down_Semaforo(mutex, 0, SEM_UNDO)==ERROR){
				fprintf (stderr, "Error en down mutex\n");
				Borrar_Semaforo(mutex);
				Borrar_Semaforo(vacio);
				Borrar_Semaforo(lleno);
				shmdt ((char *)buffer);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}
			
			*buffer=itemp;
			printf("Se ha producido el item %d\n", *buffer);
			sleep(1);
			
			if(Up_Semaforo(mutex, 0, SEM_UNDO)==ERROR){
				fprintf (stderr, "Error en up mutex\n");
				Borrar_Semaforo(mutex);
				Borrar_Semaforo(vacio);
				Borrar_Semaforo(lleno);
				shmdt ((char *)buffer);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}

			if(Up_Semaforo(lleno, 0, SEM_UNDO)==ERROR){
				fprintf (stderr, "Error en up lleno\n");
				Borrar_Semaforo(mutex);
				Borrar_Semaforo(vacio);
				Borrar_Semaforo(lleno);
				shmdt ((char *)buffer);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}
			
		}

		kill(pid, SIGTERM);
		
	}
	else{
		/*Consumidor*/
		item itemc;

		while(1){
			if(Down_Semaforo(lleno, 0, SEM_UNDO)==ERROR){
				fprintf (stderr, "Error en down lleno\n");
				Borrar_Semaforo(mutex);
				Borrar_Semaforo(vacio);
				Borrar_Semaforo(lleno);
				shmdt ((char *)buffer);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}

			if(Down_Semaforo(mutex, 0, SEM_UNDO)==ERROR){
				fprintf (stderr, "Error en down mutex\n");
				Borrar_Semaforo(mutex);
				Borrar_Semaforo(vacio);
				Borrar_Semaforo(lleno);
				shmdt ((char *)buffer);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}

			itemc=*buffer;
			printf("Se ha consumido el item %d\n", itemc);
			itemc=NULL;

			if(Up_Semaforo(mutex, 0, SEM_UNDO)==ERROR){
				fprintf (stderr, "Error en up mutex\n");
				Borrar_Semaforo(mutex);
				Borrar_Semaforo(vacio);
				Borrar_Semaforo(lleno);
				shmdt ((char *)buffer);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}

			if(Up_Semaforo(vacio, 0, SEM_UNDO)==ERROR){
				fprintf (stderr, "Error en up vacio\n");
				Borrar_Semaforo(mutex);
				Borrar_Semaforo(vacio);
				Borrar_Semaforo(lleno);
				shmdt ((char *)buffer);
				shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
				exit(EXIT_FAILURE);
			}
		}

	}

	Borrar_Semaforo(mutex);
	Borrar_Semaforo(vacio);
	Borrar_Semaforo(lleno);
	shmdt ((char *)buffer);
	shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);

	exit(EXIT_SUCCESS);
}
