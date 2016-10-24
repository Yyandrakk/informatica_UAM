#ifndef PROFESOR_H
#define PROFESOR_H
#include "semaforos.h"

void manejador_SIGALRM_5(int sig);
void gestion_profesor(int pid, Aula *aula, int num_aula, int id_cola, int idMutex);
void gestion_profesor_examen(int pid, Aula *aula, int num_aula, int id_cola, int idMutex);
int comprobacion_aula(Aula *aula);


#endif
