/**
*@brief El alumno del proyecto de la Practica 4 SOPER
*
*@file alumno.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 29-04-2016
**/
#include "alumno.h"

/**
*@brief Manejador para SIGTERM
* Hace que el alumno termine
**/
void manejador_SIGTERM (int sig)
{
	printf("El alumno %d ha salido del examen\n",getpid());
	fflush(stdout);
	exit(EXIT_SUCCESS);
}

/**
*@brief simula realizacion el examen
* El alumno avisa cuando empeiza, duerme alatoriamente y avisa cuando despierta
**/
void realizar_examen(){
	printf("El alumno %d ha empezado el examen\n",getpid());
	fflush(stdout);
        int num=(rand()%(350-120+1)+120);
 	sleep(num);
	printf("El alumno %d ha terminado el examen\n",getpid());
}

/**
*@brief Alumno
*Gestiona lo que realiza el proceso alumno
*
*@param pid pid del proceso
*@param id_cola id de la cola de mensajes
*/
void gestion_alumno(int pid, int id_cola){

	int  tipo=(rand()%2)+1;
	mensaje msg1;

	msg1.pid=pid;
	msg1.id=tipo;

        signal(SIGTERM, manejador_SIGTERM);
	printf("El alumno %d ha solicitado entrar en una aula\n",getpid());
	fflush(stdout);
	msgsnd(id_cola, (struct msgbuf *) &msg1, sizeof(mensaje) - sizeof(long), IPC_NOWAIT);

	msgrcv(id_cola, (struct msgbuf*)&msg1, sizeof(mensaje)-sizeof(long), pid, 0);
	realizar_examen();

	msg1.id=msg1.aula+3;
	msgsnd (id_cola, (struct msgbuf *) &msg1, sizeof(mensaje) - sizeof(long), IPC_NOWAIT);

	pause();
}
