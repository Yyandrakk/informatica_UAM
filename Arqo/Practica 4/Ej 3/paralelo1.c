#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <omp.h>
#include "arqo4.h"

float multiplicaNormal(num **A,num **B, num **C,int n){
	struct timeval fin,ini;
	int i,j,k;
	float aux=0;

	gettimeofday(&ini,NULL);
	for(i = 0;  i<n; i++){
		for( j = 0;  j<n; j++ ){
	aux=0;
			#pragma omp parallel for reduction(+:aux)
			for( k = 0;  k<n; k++ ){
			
			aux=aux+A[i][k]*B[k][j];
			}

			C[i][j]=aux;
		}
	}
	gettimeofday(&fin,NULL);
	return ((fin.tv_sec*1000000+fin.tv_usec)-(ini.tv_sec*1000000+ini.tv_usec))*1.0/1000000.0;
}




int main( int argc, char *argv[])
{
	int hilo,i,j;
	num **A=NULL,**B=NULL,**C=NULL;
	float res_normal=0;

	printf("Word size: %ld bits\n",8*sizeof(num));

	if( argc!=2 )
	{
		printf("Error: ./%s <matrix size>\n", argv[0]);
		return -1;
	}
	
	hilo=atoi(argv[1]);
	#ifdef _OPENMP
	omp_set_dynamic(0); 
	omp_set_num_threads(hilo);
	#endif
	A=generateMatrix(N);
	B=generateMatrix(N);
	C=generateEmptyMatrix(N);

	if( !A || !B || !C )
	{
		return -1;
	}

	res_normal = multiplicaNormal(A,B,C,N);


	
	printf("Execution time: %f\n", res_normal);
	freeMatrix(C);
	freeMatrix(A);
	freeMatrix(B);
	return 0;
}


