#ifndef _ARQO_P3_H_
#define _ARQO_P3_H_

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <omp.h>

#define N 1000ull
#define M 1000000ull
#if __x86_64__
    typedef double num;
#else
    typedef float num;
#endif
num ** generateMatrix(int);
num ** generateEmptyMatrix(int);
void freeMatrix(num **);
float * generateVector(int);
float * generateEmptyVector(int);
int * generateEmptyIntVector(int);
void freeVector(void *);

#endif /* _ARQO_P3_H_ */
