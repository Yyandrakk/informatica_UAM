/**
*@brief El ejercicio 4 de la Practica 2 SOPER
*
*@file ejercicio4a.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 22-02-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <pthread.h>
/**
*@brief argumentos para hilos ARG
*
* Esta estructura contiene todos las variables necesitan pasarse a la funcion del hilo
*/
typedef struct{
  int matriz[3][3];
  int mult;
  int id;
}ARG;

/**
*@brief multiplicarMatriz
*
*Imprime la multiplicacion de un numero que recibe por cada una de las filas de la matriz que tambien recibe
*@param parametro de tipo ARG
*/
void* multiplicarMatriz(void *a){
  ARG *argumento=(ARG*)a;
  int i;
  printf("Realizando producto:\n" );
  for(i=0;i<3;i++){
    printf("Hilo %d multiplicando fila %d resultado %d %d %d\n",argumento->id,i,argumento->matriz[i][0]*argumento->mult,argumento->matriz[i][1]*argumento->mult,argumento->matriz[i][2]*argumento->mult);
    sleep(1);
  }
  pthread_exit(&i);
}
/**
*@brief Multiplicador de matrices por un numero lanzando hilos
* Recoje dos numeros para multiplicar dos matrices que tambien recoje por el teclado
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main(int argc, char *argv[]){
  ARG primera, segunda;
  int i,j,c;
  pthread_t h1,h2;
  char cadena[100];
  char *tok;
  printf("Introduzca el primer numero multiplicador: ");
  scanf("%d",&primera.mult);
  printf("Introduzca el segundo numero multiplicador: ");
  scanf("%d",&segunda.mult);
  printf("Introduzca los valores de la primera matriz: ");

  while((c=getchar())!='\n'&& c!=EOF);
  scanf("%[^\n]",cadena);
  tok=strtok(cadena," ");
  for(i=0;i<3;i++){
    for(j=0;j<3;j++){
      primera.matriz[i][j]=atoi(tok);
      tok=strtok(NULL," ");
    }
  }

  printf("Introduzca los valores de la segunda matriz: ");
  while((c=getchar())!='\n'&& c!=EOF);
  scanf("%[^\n]",cadena);
  tok=strtok(cadena," ");
  for(i=0;i<3;i++){
    for(j=0;j<3;j++){
      segunda.matriz[i][j]=atoi(tok);
      tok=strtok(NULL," ");
    }
  }
  primera.id=1;
  segunda.id=2;
  pthread_create(&h1,NULL,multiplicarMatriz,(void *)&primera);
  pthread_create(&h2,NULL,multiplicarMatriz,(void *)&segunda);

  pthread_join(h1,NULL);
  pthread_join(h2,NULL);

  return  EXIT_SUCCESS;
}
