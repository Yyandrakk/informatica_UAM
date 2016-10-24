#ifndef ALFA_H
#define ALFA_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LONG_ID 100
#define MAX_TAMANIO_VECTOR 64
typedef enum {
FALSE = 0,
TRUE = 1
} BOOL;
typedef struct
{
char lexema[MAX_LONG_ID+1];
int tipo;
int valor_entero;
BOOL valor_boolean;
int es_direccion;
int etiqueta;
}tipo_atributos;

/* CATEGORIA */
#define VARIABLE 1
#define PARAMETRO 2
#define FUNCION 3
/* TIPO */
#define BOOLEAN 1
#define INT 2
/* CLASE */
#define ESCALAR 1
#define VECTOR 2

#define TAMANO_HASH 757
#define TAMANO 100
#define BORRADO ''''

typedef enum {
  SUMA = 0,
  RESTA = 1,
  MULTI = 2,
  DIV = 3,
  MENOS = 4,
  AND=5,
  OR=6,
  NOT=7,
  IGUAL=8,
  DESIGUAL=9,
  MAYORIGUAL=10,
  MENORIGUAL=11,
  MAYOR=12,
  MENOR=13
}CASOS;

#endif
