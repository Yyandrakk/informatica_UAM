/**
*@brief El profesor del proyecto de la Practica 4 SOPER
*
*@file profesor.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 29-04-2016
**/
#include "profesor.h"

Aula *aulag;
int num_aulag, idmutexg;
/**
*@brief Manejador para la alarma de 5 minutos
* Obliga a terminar el examen a los alumnos que lo estan realizando
**/
void manejador_SIGALRM_5(int sig){
	signal(sig, SIG_IGN);
	int i;

	Down_Semaforo(idmutexg, num_aulag, SEM_UNDO);
	for(i=0; i<aulag->total; i++){
		if(aulag[num_aulag].asientos[i]!=0){
			kill(aulag[num_aulag].asientos[i], SIGTERM);
			aulag[num_aulag].asientos[i]=0;
		}
	}
	Up_Semaforo(idmutexg, num_aulag, SEM_UNDO);

	exit(EXIT_SUCCESS);
}

/**
*@brief Profesor
*Gestiona lo que realiza el proceso profesor
*
*@param pid pid del proceso
*@param *aula array de aulas
*@param num_aula numero del aula en el que esta asignado (0 o 1)
*@param id_cola id de la cola de mensajes
*@param idMutex id del semafaro Mutex
*/
void gestion_profesor(int pid, Aula *aula, int num_aula, int id_cola, int idMutex){
	int i, num_aula2;
	mensaje msg;

	aulag=aula;
	num_aulag=num_aula;
	idmutexg=idMutex;

	if(num_aula==0)
		num_aula2=1;
	else num_aula2=0;

	while(1){
		msgrcv(id_cola, (struct msgbuf*)&msg, sizeof(mensaje)-sizeof(long), num_aula+1, 0);

		Down_Semaforo(idMutex, num_aula, SEM_UNDO);
		if(comprobacion_aula(aulag)==num_aula || comprobacion_aula(aulag)==2){
			for(i=0; i<aulag[num_aula].total; i++){
				if(aulag[num_aula].asientos[i]==0){
					aulag[num_aula].asientos[i]=msg.pid;
					msg.aula=num_aula;
					msg.id=msg.pid;
					msgsnd(id_cola, (struct msgbuf *) &msg, sizeof(mensaje) - sizeof(long), IPC_NOWAIT);
					break;
				}
			}
		}
		else if(comprobacion_aula(aulag)==num_aula2){
			msg.id=num_aula2+1;
			msgsnd(id_cola, (struct msgbuf*)&msg, sizeof(mensaje)-sizeof(long), IPC_NOWAIT);
		}
		else{
			/*ningun aula disponible*/
		}
		Up_Semaforo(idMutex, num_aula, SEM_UNDO);

	}

}

/**
*@brief Profesor_examen
*Gestiona lo que realiza el proceso profesor_examen
*
*@param pid pid del proceso
*@param *aula array de aulas
*@param num_aula numero del aula en el que esta asignado (0 o 1)
*@param id_cola id de la cola de mensajes
*@param idMutex id del semafaro Mutex
*/
void gestion_profesor_examen(int pid, Aula *aula, int num_aula, int id_cola, int idMutex){
	int i, num_aula2;
	mensaje msg;

	aulag=aula;
	num_aulag=num_aula;

	signal(SIGALRM, manejador_SIGALRM_5);
	alarm(60*5);

	if(num_aula==0)
		num_aula2=1;
	else num_aula2=0;

	while(1){
		msgrcv(id_cola, (struct msgbuf*)&msg, sizeof(mensaje)-sizeof(long), num_aula+3, 0);

		Down_Semaforo(idMutex, num_aula, SEM_UNDO);
		for(i=0; i<aulag[num_aula].total; i++){
			if(aulag[num_aula].asientos[i]==msg.pid){
				aulag[num_aula].asientos[i]=0;
				kill(msg.pid, SIGTERM);
				break;
			}
		}

	}

}
/**
*@brief Comprobacion_aula
* Comprueba que el aula este disponible
*
*@param *aula array de aulas

*/
int comprobacion_aula(Aula *aula){
	int baremo_a1 = aula[0].total*0.15;
	int baremo_a2 = aula[1].total*0.15;

	if(aula[0].disponible == 0 && aula[1].disponible == 0)
		return 3;
	else if((aula[0].disponible > baremo_a1 && aula[1].disponible > baremo_a2)
		|| (aula[0].disponible <= baremo_a1 && aula[1].disponible <= baremo_a2))
		return 2;
	else if(aula[0].disponible > baremo_a1)
		return 0;
	else if(aula[1].disponible > baremo_a2)
		return 1;
}
