/**
 *
 * Descripcion: Funciones de cabecera para ordenacion
 *
 * Fichero: ordenar.h
  Autores: Oscar Garcia de Lara Parreño
 y Jaime Lopez Llompart
 * Version: 2.0
 * Fecha: 11-11-2014
 *
 */

#ifndef ORDENA_H
#define ORDENA_H

/* constantes */

#define ERR -1
#define OK (!(ERR))

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <limits.h>

/* definiciones de tipos */

typedef struct tiempo {
  int n_perms;     /* numero de permutaciones */
  int tamanio;     /* tamanio de las permutaciones */
  double tiempo;   /* tiempo promedio */
  double medio_ob; /* numero premedio de veces que se ejecuta la OB */
  int min_ob;      /* minimo de ejecuciones de la OB */
  int max_ob;      /* maximo de ejecuciones de la OB */
} TIEMPO, *PTIEMPO;

typedef int (* pfunc_ordena)(int*, int, int);

/* Funciones */

int aleat_num(int inf, int sup);
int* genera_perm(int n);
int** genera_permutaciones(int n_perms, int tamanio);
int SelectSort(int* tabla, int ip, int iu);
int SelectSortInv(int* tabla, int ip, int iu);
short tiempo_medio_ordenacion(pfunc_ordena metodo, int n_perms,int tamanio, PTIEMPO ptiempo);
short genera_tiempos_ordenacion(pfunc_ordena metodo, char* fichero, int num_min, int num_max, int incr, int n_perms);
short guarda_tabla_tiempos(char* fichero, PTIEMPO tiempo, int N);
int merge(int *tabla, int ip, int iu, int imedio);
int mergesort (int *tabla, int ip, int iu);
int quicksort1 (int *tabla, int ip, int iu);
int partir1(int *tabla, int ip, int iu,int *ob);
int medio(int *tabla, int ip, int iu);
int medio_stat(int *tabla, int ip, int iu);
int quicksort2 (int *tabla, int ip, int iu);
int partir2(int *tabla, int ip, int iu,int *ob);
#endif
