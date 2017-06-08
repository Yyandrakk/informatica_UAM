/***********************************************************
 crearCDF.c
 Primeros pasos para implementar y validar la funcion crearCDF(). Est funcion debe devolver
 un fichero con dos columnas, la primera las muestras, la segunda de distribucion de
 probabilidad acumulada.

 Autor: Oscar Garcia de Lara y Santiago Gomez
 2016 EPS-UAM
***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
#include <ctype.h>

#define OK 0
#define ERROR 1

void desplazarCadena(unsigned int posicion, char * string) {
	int i;
	for (i = posicion; i < strlen(string) - 1; i++) {
		string[i] = string[i + 1];
	}
	string[strlen(string) - 1] = '\0';
}

void quitarPrimerosEspacios(char * string) {
	while (isspace(string[0])) {
		desplazarCadena(0, string);
	}
}

int crearCDF(const char* filename_data,const char* filename_cdf);
int main(int argc, char const *argv[]) {

		switch (argc) {
			case 2:
					return crearCDF(argv[1],"salida.txt");
			break;
			case 3:
 					return crearCDF(argv[1],argv[2]);
			break;
			default:
				printf("Error de parametros: ./crearCDF ficheroEntrada [ficheroSalida]\n" );
			break;
		}

		return ERROR;
}

int crearCDF(const char* filename_data,const char* filename_cdf) {
	char comando[255]; char linea[255]; char aux[255];
	int num_lines=0,num_rep=0,num_ele=0;
	double divi=0,tam=0;
	char filename_aux[20],filename_auxU[20];
	strcpy(filename_aux,"auxCDF.txt");
	strcpy(filename_auxU,"auxCDFU.txt");
	FILE *f,*out;
//sin control errores
	sprintf(comando,"wc -l %s 2>&1",filename_data); //wc cuenta lineas acabadas por /n
	printf("Comando en ejecucion: %s\n",comando);
	f = popen(comando, "r");
	if(f == NULL){
		printf("Error ejecutando el comando\n");
		return ERROR;
	}
	fgets(linea,255,f);
	printf("Retorno: %s\n",linea);
	sscanf(linea,"%d %s",&num_lines,aux);
	pclose(f);

	sprintf(comando,"sort -n < %s > %s 2>&1",filename_data,filename_aux);
	printf("Comando en ejecucion: %s\n",comando);
	f = popen(comando, "r");
	if(f == NULL){
		printf("Error ejecutando el comando\n");
		return ERROR;
	}
	bzero(linea,255);
	fgets(linea,255,f);
	printf("Retorno: %s\n",linea);
	pclose(f);

//crear CDF
sprintf(comando,"uniq -c %s > %s",filename_aux,filename_auxU);
printf("Comando en ejecucion: %s\n",comando);
f = popen(comando, "r");
if(f == NULL){
	printf("Error ejecutando el comando\n");
	return ERROR;
}
bzero(linea,255);
fgets(linea,255,f);
printf("Retorno: %s\n",linea);
pclose(f);

printf("Creadondo el fichero ecdf\n");
f = fopen(filename_auxU,"r");
if(f == NULL){
	printf("Error abrir el fichero %s\n",filename_auxU);
	return ERROR;
}
out = fopen(filename_cdf,"w");
if(out == NULL){
	printf("Error abrir el fichero %s\n", filename_cdf);
	fclose(f);
	return ERROR;
}
fprintf(out, "0 0.0\n");
	do {
			  fscanf(f,"%[^\n]\n",linea);
				quitarPrimerosEspacios(linea);
				sscanf(linea,"%d %lf",&num_rep,&tam);
				num_ele=num_ele+num_rep;
				divi=(double) num_ele/num_lines;
				fprintf(out, "%lf %.4f\n",tam,divi);

	} while (!feof(f));
	fclose(f);
	fclose(out);
	return OK;
}
