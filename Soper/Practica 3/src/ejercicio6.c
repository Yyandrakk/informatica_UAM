/**
*@brief El ejercicio 6 de la Practica 3 SOPER
*
*@file ejercicio6.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 28-03-2016
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
#include "semaforos.h"

#define FILEKEY "/bin/cat" /*!< Fichero para sacar la key*/
#define KEY 1300 /*!< Numero para sacar la key*/
#define N 100 /*!< Numero de procesos a crear*/

/**
* @brief Variables compartidas
*
* Esta estructura sirve para poder compartir variables entre procesos
*/
typedef struct{
	int cVa; /*!< cuenta Va*/
	int cVi; /*!< cuenta Vi*/
}info;

/**
*@brief cruzando
*Imprime por pantalla cuando empieza y termina de usar el recurso
*
*@param pid pid del proceso
*@param dir dirrecion de donde parte el proceso
*/
void cruzando(pid_t pid,int dir){
  printf("Dir:%d Entrando al puente %d\n",dir,pid );
	fflush(stdout);
  sleep(1);
  printf("Dir:%d Saliendo del puente %d\n",dir,pid );
	fflush(stdout);
}
/**
*@brief lightSwitchOn
*Para pedir el uso del recurso
*
*@param idMutex id del semaforo mutex
*@param idRecurso id del semaforo del recurso
*@param *buffer direccion para acceder a las variables compartidas
*@param dir dirrecion de donde parte el proceso
*/
void lightSwitchOn(int idMutex,int idRecurso, info *buffer,int dir)
 {

   if(dir==0){
     /*down (mutex);*/
		 Down_Semaforo(idMutex, 0,SEM_UNDO);
     buffer->cVa++;
     if ( buffer->cVa == 1){
			 /*down (recurso);*/
			  Down_Semaforo(idRecurso, 0,SEM_UNDO);
		 }

		Up_Semaforo(idMutex, 0,SEM_UNDO);
     /*up (mutex);*/
   }else{
		 /*down (mutex);*/
		 Down_Semaforo(idMutex, 1,SEM_UNDO);
		 buffer->cVi++;
		 if ( buffer->cVi == 1){
			 /*down (recurso);*/
				Down_Semaforo(idRecurso, 0,SEM_UNDO);
		 }

		  Up_Semaforo(idMutex, 1,SEM_UNDO);
		 /*up (mutex);*/
   }

 }
 /**
 *@brief lightSwitchOff
 *Indicar que ya has usado el recurso
 *
 *@param idMutex id del semaforo mutex
 *@param idRecurso id del semaforo del recurso
 *@param *buffer direccion para acceder a las variables compartidas
 *@param dir dirrecion de donde parte el proceso
 */
 void lightSwitchOff(int idMutex,int idRecurso, info *buffer,int dir)
  {
    /*down (mutex);
    *cuentaRec--;
    if ( *cuentaRec == 0)
       up (recurso);
    up (mutex);*/

		if(dir==0){
			/*down (mutex);*/
			Down_Semaforo(idMutex, 0,SEM_UNDO);
			buffer->cVa--;
			if ( buffer->cVa == 0){
				/*up (recurso);*/
				 Up_Semaforo(idRecurso, 0,SEM_UNDO);
			}

		 Up_Semaforo(idMutex, 0,SEM_UNDO);
			/*up (mutex);*/
		}else{
			/*down (mutex);*/
			Down_Semaforo(idMutex, 1,SEM_UNDO);
			buffer->cVi--;
			if ( buffer->cVi == 0){
				/*up (recurso);*/
				 Up_Semaforo(idRecurso, 0,SEM_UNDO);
			}

		 Up_Semaforo(idMutex, 1,SEM_UNDO);
			/*up (mutex);*/
		}
  }
	/**
	*@brief coche
	*Lo que realiza cada proceso simula que es un coche y quiere cruzar un puente(recurso)
	*
	*@param idMutex id del semaforo mutex
	*@param idRecurso id del semaforo del recurso
	*@param *buffer direccion para acceder a las variables compartidas
	*@param dir dirrecion de donde parte el proceso
	*/
  coche(int idMut,int idRec,info *buffer,int dir)
  {
   lightSwitchOn(idMut,idRec,buffer,dir);
   cruzando(getpid(),dir);
   lightSwitchOff(idMut,idRec,buffer,dir);

  }


	/**
	*@brief Varios procesos compiten por un recurso
	* Se creean 100 procesos, 50 se les asigna una direccion y los otros la otra, y compiten por el uso de un recurso
	*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
	**/
int main(int argc, char *argv[]){
/*dir = 0 va, si es 1 viene*/
int key,dev,pid,dir=0,id_zone,i;
/* mutex tendra dos semaforos el 0 va y el 1 viene*/
int mutex,rec;
info *buffer;
unsigned short array[]={1,1};

/*Creamos memoria compartida*/
key = ftok(FILEKEY, KEY-200);
if (key == -1) {
  fprintf (stderr, "Error con key \n");
  exit(EXIT_FAILURE);
}

id_zone = shmget (key, sizeof(info)*1, IPC_CREAT | SHM_R | SHM_W);

if (id_zone == -1) {
	  fprintf (stderr, "Error con id_zone \n");
	  exit(EXIT_FAILURE);
}

buffer = shmat (id_zone, (char *)0, 0);
if (buffer == NULL) {
  fprintf (stderr, "Error reservando memoria compartida\n");
  exit(EXIT_FAILURE);
}

buffer->cVa=buffer->cVi=0;


/*creamos e inicializamos el mutex*/
key = ftok(FILEKEY, KEY);
if (key == -1) {
  fprintf (stderr, "Error con key \n");
  exit(EXIT_FAILURE);
}

 dev=Crear_Semaforo(key, 2,&mutex);

if(dev==1){
  printf("Ya existe el mutex \n" );
  return EXIT_FAILURE;
}else if(dev==ERROR){
  printf("Error al crear el mutex \n" );
  return EXIT_FAILURE;
}

if(Inicializar_Semaforo(mutex,array)==ERROR){
  printf("Error al Inicializar el mutex \n" );
  return EXIT_FAILURE;
}
/* Creamos e inicializamos el recurso */
key = ftok(FILEKEY, KEY+200);
if (key == -1) {
  fprintf (stderr, "Error con key \n");
  exit(EXIT_FAILURE);
}

 dev=Crear_Semaforo(key, 1,&rec);

if(dev==1){
  printf("Ya existe el recurso \n" );
    exit(EXIT_FAILURE);
}else if(dev==ERROR){
  printf("Error al crear el recurso \n" );
    exit(EXIT_FAILURE);
}

if(Inicializar_Semaforo(rec,array)==ERROR){
  printf("Error al Inicializar el mutex \n" );
  exit(EXIT_FAILURE);
}

for(i=0;i<N;i++){
  if ((pid=fork()) <0 ){
    printf("Error haciendo fork\n");
    exit(EXIT_FAILURE);
  }else if (pid !=0){
    if(i%2==0){
      dir=0;
    }else{
      dir=1;
    }
    break;
  }
}
srand(getpid());
sleep(random() %20);

coche(mutex,rec,buffer,dir);

wait(NULL);
/*
if(getpid()==padre){
	shmctl (id_zone, IPC_RMID, (struct shmid_ds *)NULL);
}*/

	exit(EXIT_SUCCESS);
}
