/**
 *
 * Descripcion: Funciones de cabecera para busqueda
 *
 * Fichero: busqueda.h
 * Autor: Oscar Garcia de Lara, Jaime Lopez
 * Grupo: 1271
 * Version: 1.0
 * Fecha: 22-09-2011
 *
 */

#ifndef BUSQUEDA_H_
#define BUSQUEDA_H_

typedef struct nodo {
    int info;
    struct nodo *izq;
    struct nodo *der;
} NODO, *PNODO;


typedef struct diccionario {
  int n_datos;  /* numero de datos en el arbol */
  PNODO arbol;  /* arbol binario */
} DICC, *PDICC;


/* TAD Diccionario */


PDICC ini_diccionario (void);
PNODO create_nodo (int clave);

int nodo_vacio (PNODO pnodo);
void libera_diccionario(PDICC pdicc);
void libera_nodo (PNODO *pnodo);
int inserta_diccionario(PDICC pdicc, int clave);
int inserta_nodo (PNODO *pnodo, int clave);
int insercion_masiva_diccionario (PDICC pdicc,int *claves, int tamanio);
int busca_diccionario(PDICC pdicc, int clave, PNODO *ppos);
int busca_nodo (PNODO pnodo, int clave, PNODO *ppos);
int imprime_diccionario(PDICC pdicc);
int imprime_nodo (PNODO pnodo);
int imprime_nodo_info (PNODO pnodo);


short tiempo_medio_creacion(int tamanio,int n_perms, PTIEMPO ptiempo);
short tiempo_medio_busqueda(int tamanio,int n_perms, PTIEMPO ptiempo);
short genera_tiempos_creacion(char* fichero,int num_min, int num_max,int incr, int n_perms);
short genera_tiempos_busqueda(char* fichero,int num_min, int num_max,int incr, int n_perms);


#endif
