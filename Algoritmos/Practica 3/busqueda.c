/**
 *
 * Descripcion: Implementacion funciones para busqueda
 *
 * Fichero: busqueda.c
 * Autor:
 * Version: 1.0
 * Fecha: 11-11-2011
 *
 */


#include <stdlib.h>
#include <math.h>

#include "ordenar.h"
#include "busqueda.h"

PDICC ini_diccionario (void){
  PDICC pdicc;
  pdicc = (PDICC) malloc (sizeof(pdicc[0]));
  if(pdicc==NULL)
    return pdicc;
  pdicc->arbol=NULL;
  pdicc->n_datos=0;
  return pdicc;
}

PNODO create_nodo (int clave){
  PNODO pnodo;

  pnodo = (PNODO) malloc (sizeof (pnodo[0]));

  if (pnodo==NULL)
    return NULL;
  pnodo->info=clave;
  pnodo->izq = pnodo->der = NULL;
  return pnodo;
}

int nodo_vacio (PNODO pnodo){
  return pnodo==NULL;
}

void libera_diccionario(PDICC pdicc){
  libera_nodo (&pdicc->arbol);
  pdicc->n_datos = 0;
  free (pdicc);
}


void libera_nodo (PNODO *pnodo){
  if(*pnodo==NULL)
    return;
  libera_nodo(&(*pnodo)->izq);
  libera_nodo(&(*pnodo)->der);
  free(*pnodo);
}


int inserta_diccionario(PDICC pdicc, int clave){
  pdicc->n_datos++;
  return inserta_nodo (&pdicc->arbol, clave);
}

int inserta_nodo (PNODO *pnodo, int clave){
  int ob;
  if (*pnodo==NULL){
    *pnodo=create_nodo(clave);
    if(*pnodo==NULL)
      return ERR;
    return 1;
  }
  if (clave <(*pnodo)->info){
    ob=inserta_nodo (&(*pnodo)->izq, clave);
    if (ob==ERR)
      return ERR;
    return 1 + ob;
  }
  else{
    ob=inserta_nodo (&(*pnodo)->der, clave);
    if (ob==ERR)
      return ERR;
    return 1 + ob;
  }
}


int insercion_masiva_diccionario (PDICC pdicc,int *claves, int tamanio){
  int i=0, obs=0,ob=0;

  for (i=0; i<tamanio; i++)
    ob=inserta_diccionario (pdicc, claves[i]);
    if(ob==ERR)
      return ERR;
    obs+=ob;

  return obs;
}

int busca_diccionario(PDICC pdicc, int clave, PNODO *ppos){
  if (pdicc==NULL)
    return 0;
  if (nodo_vacio (pdicc->arbol)==1)
    return 0;
    *ppos=NULL;
  return busca_nodo (pdicc->arbol, clave, ppos);
}

int busca_nodo (PNODO pnodo, int clave, PNODO *ppos){
  if (pnodo==NULL)
    return 0;
  if ((pnodo)->info==clave){
    *ppos=pnodo;
    return 1;
  }
  if (clave <(pnodo)->info)
      return 1 + busca_nodo ((pnodo)->izq, clave,ppos);
  else
      return 1 + busca_nodo ((pnodo)->der, clave,ppos);
}

int imprime_diccionario(PDICC pdicc){
  printf ("Hay %d elementos: \n",pdicc->n_datos);
  return imprime_nodo (pdicc->arbol);
}

int imprime_nodo (PNODO pnodo){
  if (pnodo==NULL)
    return OK;
  imprime_nodo (pnodo->izq);
  imprime_nodo_info (pnodo);
  imprime_nodo (pnodo->der);
  return OK;
}

int imprime_nodo_info (PNODO pnodo){

  printf ("%d\n", pnodo->info);
  return OK;
}


short tiempo_medio_creacion(int tamanio,int n_perms, PTIEMPO ptiempo)
{
  int *perm=NULL, i=0, operacion_b=0, total=0,num_min=INT_MAX, num_max=0;
  clock_t t1, acct=0;
  PDICC dicc;
  for (i=0; i<n_perms; i++)
    {
      perm=genera_perm(tamanio);
      t1 = clock ();
      dicc=ini_diccionario ();
      if(dicc==NULL)
        {
          free(perm);
          return ERR;
        }
      operacion_b=insercion_masiva_diccionario (dicc,perm,tamanio);
      acct +=  clock ()-t1;
      total +=operacion_b;
      if (operacion_b < num_min)
        num_min = operacion_b;
      else if (operacion_b > num_max)
        num_max = operacion_b;
      libera_diccionario(dicc);
      free(perm);
    }

/* asignamos a cada valor de ptiempo su valor */
ptiempo->tiempo = (double) acct/CLOCKS_PER_SEC / n_perms;
ptiempo->n_perms = n_perms;
ptiempo->tamanio = tamanio;
ptiempo->min_ob = num_min;
ptiempo->max_ob = num_max;
ptiempo->medio_ob = (double)(total/n_perms);

return OK;
}

short tiempo_medio_busqueda(int tamanio,int n_perms, PTIEMPO ptiempo)
{
  int *perm=NULL, i=0,j=0, operacion_b=0, total=0,num_min=INT_MAX, num_max=0;
  clock_t t1, acct=0;
  PDICC dicc;
  PNODO pnodo;



for (i=0; i<n_perms; i++)
  {
    perm=genera_perm(tamanio);

    dicc=ini_diccionario ();
    if(dicc==NULL)
      {
        free(perm);
        return ERR;
      }
      insercion_masiva_diccionario (dicc,perm,tamanio) ;
      t1 = clock ();
    for(j=1;j<=tamanio;j++)
      {
        operacion_b=busca_diccionario(dicc,j,&pnodo);
        total +=operacion_b;
        if (operacion_b < num_min)
          num_min = operacion_b;
        else if (operacion_b > num_max)
          num_max = operacion_b;
      }
    acct +=  clock ()-t1;
    libera_diccionario(dicc);
    free(perm);
  }

ptiempo->tiempo = (double) acct/CLOCKS_PER_SEC / n_perms / tamanio;
ptiempo->n_perms = n_perms;
ptiempo->tamanio = tamanio;
ptiempo->min_ob = num_min;
ptiempo->max_ob = num_max;
ptiempo->medio_ob = (double)(total/(n_perms*tamanio));

return OK;
}

short genera_tiempos_creacion(char* fichero,int num_min, int num_max,int incr, int n_perms)
{
  int tamano,i;
  PTIEMPO ptiempo=(PTIEMPO)malloc((((num_max-num_min)/incr)+1)*sizeof(ptiempo[0]));

  if(ptiempo==NULL)
    return ERR;

  for(tamano=num_min,i=0;tamano<=num_max;tamano+=incr,i++)
   {
    if (tiempo_medio_creacion(tamano,n_perms,&ptiempo[i])==ERR)
      {
        free(ptiempo);
        return ERR;
      }
   }

  if(guarda_tabla_tiempos(fichero,ptiempo, i)==ERR)
    {
      free(ptiempo);
      return ERR;
    }

  free(ptiempo);
  return OK;
}

short genera_tiempos_busqueda(char* fichero,int num_min, int num_max,int incr, int n_perms)
{
  int tamano,i;
  PTIEMPO ptiempo=(PTIEMPO)malloc((((num_max-num_min)/incr)+1)*sizeof(ptiempo[0]));

    return ERR;
  if(ptiempo==NULL)

  for(tamano=num_min,i=0;tamano<=num_max;tamano+=incr,i++)
   {
    if (tiempo_medio_busqueda(tamano,n_perms,&ptiempo[i])==ERR)
      {
        free(ptiempo);
        return ERR;
      }
   }
  if(guarda_tabla_tiempos(fichero,ptiempo,i)==ERR)
    {
      free(ptiempo);
      return ERR;
    }

  free(ptiempo);
  return OK;
}
