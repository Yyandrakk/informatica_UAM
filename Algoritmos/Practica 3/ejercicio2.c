/***********************************************************/
/* Programa: ejercicio2 Fecha:                             */
/* Autores:                                                */
/*                                                         */
/* Programa que escribe en un fichero                      */
/* los tiempos medios del algoritmo de                     */
/* busqueda                                                */
/*                                                         */
/* Entrada: Linea de comandos                              */
/* -num_min: numero minimo de elementos de la tabla        */
/* -num_max: numero minimo de elementos de la tabla        */
/* -incr: incremento                                       */
/* -fclaves: numero de claves a buscar                     */
/* -numP: Introduce el numero de permutaciones a promediar */
/* -fichSalida: Nombre del fichero de salida               */
/*                                                         */
/* Salida: 0 si hubo error                                 */
/*        -1 en caso contrario                             */
/***********************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "ordenar.h"
#include "busqueda.h"

int main(int argc, char** argv)
{
  int i=0, num_min=0, num_max=0, incr=0, n_perms=0;
  char nombre_creacion[256];
  char nombre_busqueda[256];
  short ret;

  srand(time(NULL));

  if (argc != 13) {
    fprintf(stderr, "Error en los parametros de entrada:\n\n");
    fprintf(stderr, "%s -num_min <int> -num_max <int> -incr <int>\n", argv[0]);
    fprintf(stderr, "\t\t -numP <int> -fichSalidaCrear <string> -fichSalidaBuscar <string> \n");
    fprintf(stderr, "Donde:\n");
    fprintf(stderr, "-num_min: numero minimo de elementos de la tabla\n");
    fprintf(stderr, "-num_max: numero minimo de elementos de la tabla\n");
    fprintf(stderr, "-incr: incremento\n");
    fprintf(stderr, "-numP: Introduce el numero de permutaciones a promediar\n");
    fprintf(stderr, "-fichSalidaCrear: Nombre del fichero de salida con tiempos de creacion\n");
    fprintf(stderr, "-fichSalidaBuscar: Nombre del fichero de salida con tiempos de busqueda\n");
    exit(-1);
  }

  printf("Practica numero 3, apartado 2\n");
  printf("Realizada por: Oscar y Jaime\n");
  printf("Grupo: 1272\n");

  /* comprueba la linea de comandos */
  for(i = 1; i < argc ; i++) {
    if (strcmp(argv[i], "-num_min") == 0) {
      num_min = atoi(argv[++i]);
    } else if (strcmp(argv[i], "-num_max") == 0) {
      num_max = atoi(argv[++i]);
    } else if (strcmp(argv[i], "-incr") == 0) {
      incr = atoi(argv[++i]);
    } else if (strcmp(argv[i], "-numP") == 0) {
      n_perms = atoi(argv[++i]);
    } else if (strcmp(argv[i], "-fichSalidaCrear") == 0) {
      strcpy(nombre_creacion, argv[++i]);
    } else if (strcmp(argv[i], "-fichSalidaBuscar") == 0) {
      strcpy(nombre_busqueda, argv[++i]);
    } else {
      fprintf(stderr, "Parametro %s es incorrecto\n", argv[i]);
      exit(-1);
    }
  }

  /* calculamos los tiempos */

  ret = genera_tiempos_creacion(nombre_creacion, num_min, num_max, incr, n_perms);
  if (ret == ERR) {
    printf("Error en la funcion genera_tiempos_creacion\n");
    exit(-1);
  }

  ret = genera_tiempos_busqueda(nombre_busqueda, num_min, num_max, incr, n_perms);
  if (ret == ERR) {
    printf("Error en la funcion genera_tiempos_busqueda\n");
    exit(-1);
  }

  printf("Salida correcta \n");

  return 0;
}
