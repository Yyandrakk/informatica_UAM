/**
*@brief El ejercicio 8 de la Practica 2 SOPER
*
*@file ejercicio8.c
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
#include <signal.h>
#define NUM_PROC 4
/**
*@brief manejador de SIGUSR1
*
*Imprime la señal que es y el pid del proceso que la ha recibido
*@param señal que recibe
*/
void manejador_SIGUSR1 (int sig){
	signal(sig, SIG_IGN);
	printf("Señal SIGUSR1 recibida en %d\n",getpid());
	signal(sig, manejador_SIGUSR1);
}
/**
*@brief manejador de SIGUSR2
*
*Imprime la señal que es y el pid del proceso que la ha recibido
*@param señal que recibe
*/
void manejador_SIGUSR2 (int sig){
	signal(sig, SIG_IGN);
	printf("Señal SIGUSR2 recibida en %d\n",getpid());
	signal(sig, manejador_SIGUSR2);
}
/**
*@brief manejador de SIGUSTERM
*
*Imprime la señal que es y el pid del proceso que la ha recibido
*@param señal que recibe
*/
void manejador_SIGTERM (int sig)
{
printf("Terminación del proceso %d a petición del usuario \n",getpid( ));
}

/**
*@brief crea hijos y envian señales
*Crea todos los procesos de forma secuencial y se envian señales entre ellos
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main (void){

	pid_t pid;
	int i,j;
	pid_t raiz=getpid();
	pid_t final=0;
	signal(SIGTERM, manejador_SIGTERM);
	signal(SIGUSR1, manejador_SIGUSR1);
	signal(SIGUSR2, manejador_SIGUSR2);
	for (i=0; i < NUM_PROC; i++){
		if ((pid=fork()) <0 ){
			printf("Error haciendo fork\n");
			exit(EXIT_FAILURE);
		}else if (pid ==0){
			if(i==NUM_PROC-1){
				sleep(5);
				printf("El ultimo hijo envia la señal\n");
				final=getpid();
				kill(getppid(),SIGUSR1);
			}
		}else{
			break;
		}
	}


	if(getpid()!=final){
	 pause();
	 sleep(2);
	 if(getpid()==raiz){
		 kill(pid,SIGUSR2);
	 }else{
   	kill(getppid(),SIGUSR1);
 	 }
}

for(j=0;j<3;j++){
		pause();
		if(getpid()!=final){
				sleep(1);
				if(j==2&&raiz==getpid()){

				}else{
					kill(pid,SIGUSR2);
				}

		}else{
			sleep(1);
				kill(raiz,SIGUSR2);
		}

	}

if(getpid()!=final){

		if(raiz==getpid()){

			kill(pid,SIGTERM);
			pause();
		}else{
			pause();
			kill(pid,SIGTERM);
			sleep(1);
		}
		exit (EXIT_SUCCESS);
}else{
	pause();
		kill(raiz,SIGTERM);
		sleep(1);
			exit (EXIT_SUCCESS);
}

return EXIT_SUCCESS;
}
