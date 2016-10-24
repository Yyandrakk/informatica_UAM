#include "semaforos.h"

/***************************************************************
Nombre:
Inicializar_Semaforo.
Descripcion:
Inicializa los semaforos indicados.
Entrada:
int semid: Identificador del semaforo.
unsigned short *array: Valores iniciales.
Salida:
int: OK si todo fue correcto, ERROR en caso de error.
************************************************************/
int Inicializar_Semaforo(int semid, unsigned short *array){
  union semun {
      int val;
      struct semid_ds *semstat;
      unsigned short *array;
    } arg;
    arg.array=array;
  if(semctl (semid,0, SETALL, arg)==-1)return ERROR;
  return OK;
}
/***************************************************************
Nombre: Borrar_Semaforo.
Descripcion: Borra un semaforo.
Entrada:
int semid: Identificador del semÃ¡foro.
Salida:
int: OK si todo fue correcto, ERROR en caso de error.
***************************************************************/
int Borrar_Semaforo(int semid){
  if(semctl (semid, 0, IPC_RMID, 0)==-1)return ERROR;
  return OK;

}
/***************************************************************
Nombre: Crear_Semaforo.
Descripcion: Crea un semaforo con la clave y el tamaño
especificado. Lo inicializa a 0.
Entrada:
key_t key: Clave precompartida del semaforo.
int size: Tamaño del semaforo.
Salida:
int *semid: Identificador del semaforo.
int: ERROR en caso de error,
0 si ha creado el semaforo,
1 si ya estaba creado.
**************************************************************/
int Crear_Semaforo(key_t key, int size, int *semid){
  int errno;
  unsigned short *array;
  *semid = semget(key,size,IPC_CREAT| SHM_R | SHM_W);
  if((*semid == -1) && (errno == EEXIST)){
    return 1;
  }
  else if(*semid==-1){
    return ERROR;
  }

  if((array=(unsigned short *)calloc(size,sizeof(unsigned short)))==NULL) return ERROR;

  if( Inicializar_Semaforo(*semid, array)==ERROR){
    free(array);
    return ERROR;
  }
  free(array);
  return 0;
}
/*********************************************************
Nombre:Down_Semaforo
Descripcion:Baja el semaforo indicado
Entrada:
int semid: Identificador del semaforo.
int num_sem: Semaforo dentro del array.
int undo: Flag de modo persistente pese a finalización
abrupta.
Salida:
int: OK si todo fue correcto, ERROR en caso de error.
***************************************************************/
int Down_Semaforo(int id, int num_sem, int undo){
  struct sembuf sem_oper;
  sem_oper.sem_num = num_sem; /* Actuamos sobre el semáforo 0 de la lista */
  sem_oper.sem_op =-1; /* Decrementar en 1 el valor del semáforo */
  sem_oper.sem_flg = undo; /* Para evitar interbloqueos si un proceso acaba inesperadamente */
  return semop (id, &sem_oper, 1);
}
/***************************************************************
Nombre: DownMultiple_Semaforo
Descripcion: Baja todos los semaforos del array indicado
por active.
Entrada:
int semid: Identificador del semaforo.
int size: Numero de semaforos del array.
int undo: Flag de modo persistente pese a finalización
abrupta.
int *active: Semaforos involucrados.
Salida:
int: OK si todo fue correcto, ERROR en caso de error.
***************************************************************/
int DownMultiple_Semaforo(int id,int size,int undo,int *active){
  int i;
  for(i=0;i<size;i++){
    if(Down_Semaforo(id,active[i],  undo)==ERROR){
      return ERROR;
    }
  }
  return OK;
}
/**************************************************************
Nombre:Up_Semaforo
Descripcion: Sube el semaforo indicado
Entrada:
int semid: Identificador del semaforo.
int num_sem: Semaforo dentro del array.
int undo: Flag de modo persistente pese a finalizacion
abupta.
Salida:
int: OK si todo fue correcto, ERROR en caso de error.
***************************************************************/
int Up_Semaforo(int id, int num_sem, int undo){
  struct sembuf sem_oper;
  sem_oper.sem_num = num_sem; /* Actuamos sobre el semáforo 0 de la lista */
  sem_oper.sem_op =1; /* Incrementamos en 1 el valor del semáforo */
  sem_oper.sem_flg = undo; /* Para evitar interbloqueos si un proceso acaba inesperadamente */
  return semop (id, &sem_oper, 1);
}
/***************************************************************
Nombre: UpMultiple_Semaforo
Descripcion: Sube todos los semaforos del array indicado
por active.
Entrada:
int semid: Identificador del semaforo.
int size: Numero de semaforos del array.
int undo: Flag de modo persistente pese a finalización
abrupta.
int *active: Semaforos involucrados.
Salida:
int: OK si todo fue correcto, ERROR en caso de error.
***************************************************************/
int UpMultiple_Semaforo(int id,int size, int undo, int *active){
  int i;
  for(i=0;i<size;i++){
    if(Up_Semaforo(id,active[i],undo)==ERROR){
      return ERROR;
    }
  }
  return OK;
}
