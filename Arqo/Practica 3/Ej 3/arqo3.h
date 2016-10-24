#ifndef _ARQO_P3_H_
#define _ARQO_P3_H_

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#if __x86_64__
	typedef double num;
#else
	typedef float num;
#endif

num ** generateMatrix(int);
num ** generateEmptyMatrix(int);
void freeMatrix(num **);

#endif /* _ARQO_P3_H_ */
