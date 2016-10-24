/***********************************************/
/* Programa: ejercicio1     Fecha:             */
/* Autores:                                    */
/*                                             */
/* Programa que comprueba el funcionamiento de */
/* la busqueda lineal                          */
/*                                             */
/* Entrada: Linea de comandos                  */
/*   -tamanio: numero elementos diccionario    */
/*   -clave:   clave a buscar                  */
/*                                             */
/* Salida: 0: OK, -1: ERR                      */
/***********************************************/

#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include<time.h>

#include "ordenar.h"
#include "busqueda.h"

int main(int argc, char** argv)
{
  int i, nob;
  PNODO pos;
  unsigned int clave, tamanio;
  PDICC pdicc;
  int *perm;

  srand(time(NULL));

  if (argc != 5) {
    fprintf(stderr, "Error en los parametros de entrada:\n\n");
    fprintf(stderr, "%s -tamanio <int> -clave <int>\n", argv[0]);
    fprintf(stderr, "Donde:\n");
    fprintf(stderr, " -tamanio : numero elementos de la tabla.\n");
    fprintf(stderr, " -clave : clave a buscar.\n");
    exit(-1);
  }

  printf("Practica numero 3, apartado 1\n");
  printf("Realizada por: Vuestros nombres\n");
  printf("Grupo: Vuestro grupo\n");

  /* comprueba la linea de comandos */
  for(i = 1; i < argc; i++) {
    if (strcmp(argv[i], "-tamanio") == 0) {
      tamanio = atoi(argv[++i]);
    } else if (strcmp(argv[i], "-clave") == 0) {
      clave = atoi(argv[++i]);
    } else {
      fprintf(stderr, "Parametro %s es incorrecto\n", argv[i]);
    }
  }

  pdicc = ini_diccionario();
  if (pdicc == NULL) {
    /* error */
    printf("Error: No se puede Iniciar el diccionario\n");
    exit(-1);
  }

  perm = genera_perm(tamanio);
  if (perm == NULL) {
    /* error */
    printf("Error: No hay memoria\n");
    libera_diccionario(pdicc);
    exit(-1);
  }

  nob = insercion_masiva_diccionario(pdicc, perm, tamanio);
  free(perm);
  if (nob == ERR) {
    /* error */
    printf("Error: No se pueden insertar claves en el diccionario\n");
    libera_diccionario(pdicc);
    exit(-1);
  }
  
  nob=imprime_diccionario(pdicc);
  if (nob == ERR) {
    /* error */
    printf("Error: No se puede imprimir el diccionario\n");
    libera_diccionario(pdicc);
    exit(-1);
  }


  nob = busca_diccionario(pdicc,clave,&pos);
  if(nob==ERR){
    printf("Error al buscar la clave %d\n",clave);
  } else if (pos!=NULL) {
    printf("Clave %d encontrada en %d op. basicas\n",clave,nob);
  } else {
    printf("La clave %d no se encontro en la tabla\n",clave);
  }

  libera_diccionario(pdicc);

  return 0;
}

