/**
*@brief Utilidades para el uso de semaforos
*
* Este modulo contiene los prototipos de las funciones para el uso de semaforos
*@file semaforos.h
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 28-03-2016
**/
#ifndef SEMAFOROS_H
#define SEMAFOROS_H

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
/**
* @brief Lista de posibles errores
*/
enum STATUS {
  OK=0, /*!< No hay error */
  ERROR=-1 /*!< Error */
};

/**
*@brief Inicializar_Semaforo.
*Inicializa los semaforos indicados.
*
*@param semid Identificador del semaforo.
*@param *array Valores iniciales
*@return *int: OK si todo fue correcto, ERROR en caso de error.
*/
int Inicializar_Semaforo(int semid, unsigned short *array);
/**
*@brief Borrar_Semaforo.
* Borra un semaforo.
*@param semid Identificador del semaforo.
*@return OK si todo fue correcto, ERROR en caso de error.
*/
int Borrar_Semaforo(int semid);
/**
*@brief Crear_Semaforo.
*Crea un semaforo con la clave y el tamaño especificado. Lo inicializa a 0.
*
*@param key_t key Clave precompartida del semaforo.
*@param int size Tamaño del semaforo.
*@return *int *semid: Identificador del semaforo.
*int: ERROR en caso de error,
*0 si ha creado el semaforo,
*1 si ya estaba creado.
*/
int Crear_Semaforo(key_t key, int size, int *semid);
/**
*@brief Down_Semaforo
*Baja el semaforo indicado
*
*@param semid Identificador del semaforo.
*@param num_sem Semaforo dentro del array.
*@param undo Flag de modo persistente pese a finalización abrupta.
*@return int OK si todo fue correcto, ERROR en caso de error.
***************************************************************/
int Down_Semaforo(int id, int num_sem, int undo);
/**
*@brief DownMultiple_Semaforo
*Baja todos los semaforos del array indicado por active.
*
*@param semid Identificador del semaforo.
*@param size Numero de semaforos del array.
*@param undo Flag de modo persistente pese a finalización abrupta.
*@param *active Semaforos involucrados.
*@return int: OK si todo fue correcto, ERROR en caso de error.
*/
int DownMultiple_Semaforo(int id,int size,int undo,int *active);
/**
*@brief Up_Semaforo
*Sube el semaforo indicado
*@param semid Identificador del semaforo.
*@param num_sem Semaforo dentro del array.
*@param undo Flag de modo persistente pese a finalizacion abupta.
*@return int: OK si todo fue correcto, ERROR en caso de error.
*/
int Up_Semaforo(int id, int num_sem, int undo);
/**
*@brief UpMultiple_Semaforo
*Sube todos los semaforos del array indicado por active.
*
*@param semid Identificador del semaforo.
*@param size Numero de semaforos del array.
*@param undo Flag de modo persistente pese a finalización abrupta.
*@param *active Semaforos involucrados.
*@return int: OK si todo fue correcto, ERROR en caso de error.
*/
int UpMultiple_Semaforo(int id,int size, int undo, int *active);

#endif
