/**
 *
 * Descripcion: Implementacion de funciones de ordenacion 
 *
 * Fichero: ordenar.c
 * Autores: Oscar Garcia de Lara Parreño          
 * y Jaime Lopez Llompart                         
 * Version: 1.0
 * Fecha: 14-10-2014
 *
 */


#include "ordenar.h"

/***************************************************/
/* Funcion: aleat_num Fecha:                       */
/* Autores: Oscar Garcia de Lara Parreño           */
/* y Jaime Lopez Llompart                          */
/*                                                 */
/* Rutina que genera un numero aleatorio           */
/* entre dos numeros dados                         */
/*                                                 */
/* Entrada:                                        */
/* int inf: limite inferior                        */
/* int sup: limite superior                        */
/* Salida:                                         */
/* int: numero aleatorio                           */
/***************************************************/
int aleat_num(int inf, int sup)
{
	return rand()%(sup-inf+1)+inf;
}

/***************************************************/
/* Funcion: genera_perm Fecha:                     */
/* Autores: Oscar Garcia de Lara Parreño           */
/* y Jaime Lopez Llompart                          */
/*                                                 */
/* Rutina que realiza un SWAP entre dos int        */
/*                                                 */
/*                                                 */
/* Entrada:                                        */
/* int *a: primer elemento                         */
/* int *b: segundo elemento                        */
/* Salida:                                         */
/* Nada                                            */
/***************************************************/
void swap (int *a, int *b)
{
	int swap=*a;
	*a=*b;
	*b=swap;
	return;
}
/***************************************************/
/* Funcion: genera_perm                            */
/* Autores: Oscar Garcia de Lara Parreño           */
/* y Jaime Lopez Llompart                          */
/*                                                 */
/* Rutina que genera una permutacion               */
/* aleatoria                                       */
/*                                                 */
/* Entrada:                                        */
/* int n: Numero de elementos de la                */
/* permutacion                                     */
/* Salida:                                         */
/* int *: puntero a un array de enteros            */
/* que contiene a la permutacion                   */
/* o NULL en caso de error                         */
/***************************************************/
int* genera_perm(int n)/*REVISAR CON APUNTES POSIBLE ERROR*/
{
 	int *perm=(int*)malloc(sizeof(perm[0])*n),i;

	if(!perm)
		return NULL;

	for(i=1;i<=n;i++)
		perm[i-1]=i;
	
	for (i= 0;i<n; i++)
		swap(&perm[i], &perm[aleat_num(i,n-1)]);
	
	return perm;
}

/***************************************************/
/* Funcion: genera_permutaciones Fecha:            */
/* Autores: Oscar Garcia de Lara Parreño           */
/* y Jaime Lopez Llompart                          */
/*                                                 */
/* Funcion que genera n_perms permutaciones        */
/* aleatorias de tamanio elementos                 */
/*                                                 */
/* Entrada:                                        */
/* int n_perms: Numero de permutaciones            */
/* int tamanio: Numero de elementos de cada        */
/* permutacion                                     */
/* Salida:                                         */
/* int**: Array de punteros a enteros              */
/* que apuntan a cada una de las                   */
/* permutaciones                                   */
/* NULL en caso de error                           */
/***************************************************/
int** genera_permutaciones(int n_perms, int tamanio)
{
	int **perms=malloc (n_perms*sizeof (perms[0])), j=0; 

	if (!perms)
		return NULL;
	for (j=0; j<n_perms; j++)
	{
		perms[j]=genera_perm (tamanio);
		if (perms[j]==NULL)
		{
			int i;
			for (i=0; i<j; i++)
				free (perms[i]);
			free (perms);
			return NULL;
		}
	}
	return perms;
}

/***************************************************/
/* Funcion: SelectSort    Fecha:                   */
/* Autores: Oscar Garcia de Lara Parreño           */
/* y Jaime Lopez Llompart                          */
/*                                                 */
/* Funcion que ordena una tabla de menor a mayor   */
/* 				                   */
/*                                                 */
/* Entrada:                                        */
/* int* tabla: Tabla a ordenar		            */
/* int ip: Indice de comienzo la tabla             */
/* int iu: Indice final de la tabla                */
/* Salida:                                         */
/* int: numero de operaciones basica               */
/* ERR en caso de error                           */
/***************************************************/
int SelectSort(int* tabla, int ip, int iu)
{
	int min=0,principio=0,contador=0;
	if(!tabla||ip>iu)
		return ERR;

	for(principio=ip;principio<iu;principio++)
	{
		int j=0;	
		min=principio;
		for (j=principio+1;j<=iu;j++)
			{	
				contador++;
				if(tabla[j]<tabla[min])
					min=j;
			}
		swap(&tabla[principio],&tabla[min]);
		
	}
	return contador;
}

/***************************************************/
/* Funcion: SelectSort                             */
/* Autores: Oscar Garcia de Lara Parreño           */
/* y Jaime Lopez Llompart                          */
/*                                                 */
/* Funcion que ordena una tabla de mayor a menor   */
/* 				                   */
/*                                                 */
/* Entrada:                                        */
/* int* tabla: Tabla a ordenar		           */
/* int ip: Indice de comienzo la tabla             */
/* int iu: Indice final de la tabla                */
/* Salida:                                         */
/* int: numero de operaciones basica               */
/* ERR en caso de error                            */
/***************************************************/
int SelectSortInv(int* tabla, int ip, int iu)
{
  int max=0,principio=0,contador=0;
	if(!tabla||ip>iu)
		return ERR;

	for(principio=ip;principio<iu;principio++)
	{
		int j=0;		
		max=principio;
		for (j=principio+1;j<=iu;j++)
			{	
				contador++;
				if(tabla[j]>tabla[max])
					max=j;
			}
		swap(&tabla[principio],&tabla[max]);
	}
	return contador;
}


/***************************************************/
/* Funcion: tiempo medio ordenacion                */
/* Autores: Oscar Garcia de Lara Parreño           */
/* y Jaime Lopez Llompart                          */
/*                                                 */
/* Funcion para obtener los datos de tiempo        */
/* de una funcion de ordenacion	                   */
/*                                                 */
/* Entrada:                                        */
/* pfunc_ordena: Puntero de la funcion de ordenacion*/
/* int n_perms: numero de permutaciones             */
/* int tamanio: tamano de las permutaciones        */
/* Salida:                                         */
/* int: OK si todo es correcto                     */
/* ERR en caso de error                            */
/***************************************************/
short tiempo_medio_ordenacion(pfunc_ordena metodo, int n_perms,int tamanio,PTIEMPO ptiempo)
{
        int **perms=NULL, i=0, operacion_b=0, total=0,num_min=INT_MAX, num_max=0;
	clock_t t1, t2;

	if (!metodo || n_perms <0 || tamanio <0 || ptiempo==NULL)
		return ERR;

	perms =genera_permutaciones(n_perms, tamanio);
	if(!perms)
		return ERR;
	
	t1 = clock ();
	/* comprobamos que el tiempo esta cogido correctamente */
	if (t1==-1)
		return ERR;

	/* comprobamos que en cada elemento de la tabla perms se haya rellenado*/
	for (i=0; i<n_perms; i++){
		operacion_b = metodo (perms[i], 0, tamanio-1);
		total +=operacion_b;
		 if (operacion_b < num_min)
			num_min = operacion_b;
		else if (operacion_b > num_max)
			num_max = operacion_b;
		free(perms[i]);
	 }
		free(perms);
	t2 = clock ();
	/* comprobamos que el tiempo esta cogido correctamente*/
	if (t2==-1)
		return ERR;

	/* asignamos a cada valor de ptiempo su valor */
	ptiempo->tiempo = (t2 -t1)/(double)CLOCKS_PER_SEC / n_perms;
	ptiempo->n_perms = n_perms;
	ptiempo->tamanio = tamanio;
	ptiempo->min_ob = num_min;
	ptiempo->max_ob = num_max;
	ptiempo->medio_ob = (double)(total/n_perms);

	return OK;


}
/***************************************************/
/* Funcion: genera tiempos de ordenacion          */
/* Autores: Oscar Garcia de Lara Parreño           */
/* y Jaime Lopez Llompart                          */
/*                                                 */
/* Funcion para obtener los datos de tiempo        */
/* de una funcion de ordenacion	                   */
/*                                                 */
/* Entrada:                                        */
/* pfunc_ordena: Puntero de la funcion de ordenacion*/
/* char* fichero: nombre del fichero               */
/* int num_min: numero minimo                      */
/* int num_max: numero maximo                      */
/* Salida:                                         */
/* short: OK si todo es correcto                     */
/* ERR en caso de error                            */
/***************************************************/

short genera_tiempos_ordenacion(pfunc_ordena metodo, char* fichero, int num_min, int num_max, int incr, int n_perms)
{
		int tamano,i;
	PTIEMPO ptiempo=(PTIEMPO)malloc((((num_max-num_min)/incr)+1)*sizeof(ptiempo[0]));

	
	if(!fichero||!ptiempo)
		{
			if(ptiempo)
				free(ptiempo);
			return ERR;
		}

	for(tamano=num_min,i=0;tamano<=num_max;tamano+=incr,i++)
		 {
			if (tiempo_medio_ordenacion(metodo,n_perms,tamano, &ptiempo[i])!=OK)
				{
					free(ptiempo);
					return ERR;
				}	
		 }
	
		if(guarda_tabla_tiempos(fichero,ptiempo, i)!=OK)
			{
				free(ptiempo);
				return ERR;
			}

		free(ptiempo);
		return OK;
}

/***************************************************/
/* Funcion: genera tiempos de ordenacion           */
/* Autores: Oscar Garcia de Lara Parreño           */
/* y Jaime Lopez Llompart                          */
/*                                                 */
/* Funcion para obtener los datos de tiempo        */
/* de una funcion de ordenacion	                   */
/*                                                 */
/* Entrada:                                        */
/* char* fichero: nombre del fichero               */
/* PTEIMPO tiempo: Array con todos los datos de las pruebas*/
/* int N: Tamaño de la array tiempo                 */
/* Salida:                                         */
/* short: OK si todo es correcto                   */
/* ERR en caso de error                            */
/***************************************************/
short guarda_tabla_tiempos(char* fichero, PTIEMPO tiempo, int N)
{	
	int i;
	FILE *salida=fopen(fichero,"w");
	
	if(!tiempo||!salida)
	{
		if(salida)
			fclose(salida);
		return ERR;
	}

	for(i=0;i<N;i++)
		fprintf(salida,"%d %f %f %d %d\n",tiempo[i].tamanio,tiempo[i].tiempo,tiempo[i].medio_ob,tiempo[i].max_ob,tiempo[i].min_ob);

	fclose(salida);		
  	return OK;
}
