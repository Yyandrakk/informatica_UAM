#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#include "arqo3.h"
num ** generaTranspuesta(num **B, int n){
	int i,j;
	num **matrix=generateEmptyMatrix(n);
	if(!n)
	{
		return NULL;
	}
	for(i = 0;i < n;i++){
      for(j = 0;j < n;j++){
           matrix[i][j] =B[j][i];
          }
  	}
	return matrix;


}
float multiplicaNormal(num **A,num **B, num **C,int n){
	struct timeval fin,ini;
	int i,j,k;

	gettimeofday(&ini,NULL);
	for(i = 0;  i<n; ++i){
		for( j = 0;  j<n; ++j ){
			for( k = 0;  k<n; ++k ){
			C[i][j]+=A[i][k]*B[k][j];
			}
		}
	}
	gettimeofday(&fin,NULL);
	return ((fin.tv_sec*1000000+fin.tv_usec)-(ini.tv_sec*1000000+ini.tv_usec))*1.0/1000000.0;
}

float multiplicaTrans(num **A,num **B, num **C,int n){
	struct timeval fin,ini;
		int i,j,k;
	num **Bt=NULL;
	gettimeofday(&ini,NULL);
	Bt=generaTranspuesta(B,n);
	for(i = 0;  i<n; ++i){
		for( j = 0;  j<n; ++j ){
			for( k = 0;  k<n; ++k ){
			C[i][j]+=A[i][k]*Bt[j][k];			
			}
		}
	}
	gettimeofday(&fin,NULL);
	return ((fin.tv_sec*1000000+fin.tv_usec)-(ini.tv_sec*1000000+ini.tv_usec))*1.0/1000000.0;
}



int main( int argc, char *argv[])
{
	int n;
	num **A=NULL,**B=NULL,**C=NULL;
	float res_trans=0;

	printf("Word size: %ld bits\n",8*sizeof(num));

	if( argc!=2 )
	{
		printf("Error: ./%s <matrix size>\n", argv[0]);
		return -1;
	}
	n=atoi(argv[1]);
	A=generateMatrix(n);
	B=generateMatrix(n);
	C=generateEmptyMatrix(n);

	if( !A || !B || !C )
	{
		return -1;
	}
	res_trans = multiplicaTrans(A,B,C,n);
	printf("Execution time: %f\n",res_trans);
	freeMatrix(C);
	freeMatrix(A);
	freeMatrix(B);
	return 0;
}


