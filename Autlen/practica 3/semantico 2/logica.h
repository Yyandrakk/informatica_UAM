#ifndef LOGICA_H
#define LOGICA_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef enum
{
  C0=0,
  C1=1,
  C2=2,
  C3=3
}CONJUNTO;

typedef enum
{
  FALSE=0,
  TRUE=1
}BOOL;
typedef struct
{
  char variable[100];
  char letra;
  BOOL valor;
  CONJUNTO conj;
}tipo_atributos;
#endif
