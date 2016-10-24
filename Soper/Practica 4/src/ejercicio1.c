/**
*@brief El ejercicio 1 de la Practica 4 SOPER
*
*@file ejercicio1.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 29-04-2016
**/
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>

/**
* @brief Mensaje
*
* Esta estructura define un mensaje.
*/
typedef struct _Mensaje{
long id; /*!< Identificador del mensaje*/
char aviso[4*1024+1];/*!< Informacion que se quiere transmitir*/
}mensaje;

/**
*@brief Varios procesos se comunican a traves de colas de mensajes
* Los procesos se comunican entre si para pasar el contenido de un fichero a otro pero todos los caracteres a mayusculas.
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main(int argc, char const *argv[]) {

  int i,idAB,idBC,id1=1,id2=1;
  pid_t pid;
  FILE *entrada, *salida;
  key_t clave;
  mensaje msg1,msg2,msg3;
  if(argc!=3){
    fprintf(stderr, "./ejercicio1 f1 f2\n" );
    return EXIT_FAILURE;
  }
  clave = ftok ("/bin/ls", 2000); /*Misma clave que el proceso cooperante*/
  if (clave == (key_t)-1)
  {
    perror("Error al obtener clave para cola mensajes \n");
    exit(EXIT_FAILURE);
  }
  /*
  * Primera cola de mensaje para el proceso A y B
  */
  idAB= msgget (clave, 0600 | IPC_CREAT);
  if (idAB == -1)
  {
    perror ("Error al obtener identificador para cola mensajes \n");
    exit(EXIT_FAILURE);
  }

  clave = ftok ("/bin/ls", 1000); /*Misma clave que el proceso cooperante*/
  if (clave == (key_t)-1)
  {
    perror("Error al obtener clave para cola mensajes \n");
    exit(EXIT_FAILURE);
  }
/*
* Segundo cola de mensaje para el proceso B y C
*/
  idBC = msgget (clave, 0600 | IPC_CREAT);
  if (  idBC == -1)
  {
    perror ("Error al obtener identificador para cola mensajes \n");
    exit(EXIT_FAILURE);
  }

for(i=0;i<2;i++){

    if ((pid=fork()) <0 ){
      printf("Error haciendo fork\n");
      exit(EXIT_FAILURE);
    }else if (pid !=0){
      break;
    }
}

if(i==0){
  entrada=fopen(argv[1],"r");
  if(!entrada){
    fprintf(stderr, "Error abrir fichero lectura\n" );
    exit(EXIT_FAILURE);
  }
  while(!feof(entrada)){
    fread(msg1.aviso, sizeof(msg1.aviso),1, entrada);
    msg1.id=1;
    msgsnd (idAB, (struct msgbuf *) &msg1, sizeof(mensaje) - sizeof(long), IPC_NOWAIT);
  }
  fclose(entrada);
  msg1.id=2;
  msgsnd (idAB, (struct msgbuf *) &msg1, sizeof(mensaje) - sizeof(long), IPC_NOWAIT);
  wait(NULL);
  msgctl(idAB,IPC_RMID,(struct msqid_ds*)NULL);
  msgctl(idBC,IPC_RMID,(struct msqid_ds*)NULL);
  exit(EXIT_SUCCESS);
}else if(i==1){
    while(1){
      msgrcv (idAB, (struct msgbuf *)&msg2, sizeof(mensaje) - sizeof(long), 0, 0);
      if(msg2.id==1){
        for(i = 0; msg2.aviso[i]; i++)
            msg3.aviso[i] = toupper(msg2.aviso[i]);
        msg3.id=1;
        msgsnd (idBC, (struct msgbuf *) &msg3, sizeof(mensaje) - sizeof(long), IPC_NOWAIT);
      }else{
        msg3.id=2;
        msgsnd (idBC, (struct msgbuf *) &msg3, sizeof(mensaje) - sizeof(long), IPC_NOWAIT);
        wait(NULL);
        exit(EXIT_SUCCESS);
      }

    }
}else{
  salida=fopen(argv[2],"w");
  if(!salida){
    fprintf(stderr, "Error abrir fichero salida\n" );
    exit(EXIT_FAILURE);
  }
  while(1){
    msgrcv (idBC, (struct msgbuf *)&msg3, sizeof(mensaje) - sizeof(long), 0, 0);
    if(msg3.id==1){
        fwrite(msg3.aviso, strlen(msg3.aviso),1,salida);
    }else{
      fclose(salida);
      exit(EXIT_SUCCESS);
    }

   }
}

return 0;
}
