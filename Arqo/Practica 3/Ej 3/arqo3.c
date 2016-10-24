#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#include "arqo3.h"

num ** generateMatrix(int size);
void freeMatrix(num **matrix);

num ** generateMatrix(int size)
{
	num *array=NULL;
	num **matrix=NULL;
	int i=0,j=0;

	matrix=(num **)malloc(sizeof(num *)*size);
	array=(num *)malloc(sizeof(num)*size*size);
	if( !array || !matrix)
	{
		printf("Error when allocating matrix of size %d.\n",size);
		if( array )
			free(array);
		if( matrix )
			free(matrix);
		return NULL;
	}

	srand(0);
	for(i=0;i<size;i++)
	{
		matrix[i] = &array[i*size];
		for(j=0;j<size;j++)
		{
			matrix[i][j] = (1.0*rand()) / (RAND_MAX/10);
		}
	}

	return matrix;
}

num ** generateEmptyMatrix(int size)
{
	num *array=NULL;
	num **matrix=NULL;
	int i=0;

	matrix=(num **)malloc(sizeof(num *)*size);
	array=(num *)malloc(sizeof(num)*size*size);
	if( !array || !matrix)
	{
		printf("Error when allocating matrix of size %d.\n",size);
		if( array )
			free(array);
		if( matrix )
			free(matrix);
		return NULL;
	}

	for(i=0;i<size;i++)
	{
		matrix[i] = &array[i*size];
	}

	return matrix;
}


void freeMatrix(num **matrix)
{
	if( matrix && matrix[0] )
		free(matrix[0]);
	if( matrix )
		free(matrix);
	return;
}
