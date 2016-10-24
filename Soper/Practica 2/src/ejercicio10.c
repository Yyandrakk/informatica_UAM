/**
*@brief El ejercicio 10 de la Practica 2 SOPER
*
*@file ejercicio10.c
*@author Oscar Garcia de Lara Parreño
*@author Santiago Gomez Aguirre
*@version 1.0
*@date 6-03-2016
**/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <signal.h>
#include <unistd.h>

FILE *fichero=NULL;
char *buffer=NULL;
int hijoMuerto=1,contador=0;
pid_t pid;
long int pos;

/**
*@brief manejador_SIGTERM
*Libera la memoria y cierra los archivos antes de terminar la ejecucion
*
*@param sig Señal de entrada
*/
void manejador_SIGTERM(int sig){
	if(buffer!=NULL)free(buffer);
	if(fichero!=NULL)fclose(fichero);
	exit(EXIT_SUCCESS);
}

/**
*@brief manejador_SIGALRM
*Para el proceso padre cada vez que la alarma lanza la señal entra aca, lee una palabra del fichero, si es fin realanza el proceso hijo.
*
*@param
*/
void manejador_SIGALRM(int sig){
	signal(sig, SIG_IGN);
	char palabra[20]="";
	fseek(fichero,pos,SEEK_SET);
	fscanf(fichero,"%s",palabra);
	pos=ftell(fichero);
	printf("He leido la palabra %s, el contador va por %d\n",palabra,contador);
	fflush(stdout);

	if(strcmp(palabra, "FIN")==0){
		hijoMuerto=1;
		pos=0;
		fclose(fichero);
	}

	contador++;
	alarm(5);
	signal(sig,manejador_SIGALRM);
}

/**
*@brief Dos procesos uno lee del fichero y el otro escribe.
* Dos procesos uno lee del fichero y el otro escribe, hasta un limite de 50 señales de SIGALRM.
*@return EXIT_FAILURE en caso de error, EXIT_SUCCESS si funciona
**/
int main (void){
	int num=0;
	char *cadena[]={"EL","PROCESO","A","ESCRIBE","EN","UN","FICHERO","HASTA","QUE","LEE","LA","CADENA","FIN"};

	if(signal(SIGTERM,manejador_SIGTERM)==SIG_ERR){
		fprintf(stderr,"Error al inicializar un manejador de señales\n");
		exit(EXIT_FAILURE);
	}

	while(1){
		if(hijoMuerto==1){
			hijoMuerto=0;

			fichero=fopen("fichero.txt", "w+");
			if(fichero==NULL){
				printf("Error al abrir el fichero\n");
				exit(EXIT_FAILURE);
			}

			if ((pid=fork()) <0 ){
				printf("Error haciendo fork\n");
				exit(EXIT_FAILURE);
			}
			else if (pid ==0){
				srand(getpid());
				printf("El hijo empieza \n");

				while(1){
					num=rand()%13;
					buffer=strdup(cadena[num]);

					fseek(fichero,0,SEEK_END);
					fprintf(fichero, "%s\n", buffer);
					fflush(fichero);
					if(strcmp(buffer,"FIN")==0){
						if(buffer!=NULL)free(buffer);
						printf("EL hijo a terminado\n");
						exit(EXIT_SUCCESS);
					}

					if(buffer!=NULL)free(buffer);
					sleep(1);

				}
			}else{
				if(signal(SIGALRM,manejador_SIGALRM)==SIG_ERR){
					fprintf(stderr,"Error al inicializar un manejador de señales\n");
					exit(EXIT_FAILURE);
				}
				alarm(5);
			}
		}
			if(contador==50){
				kill(pid,SIGTERM);
				if(buffer!=NULL)free(buffer);
				if(fichero!=NULL)fclose(fichero);
				exit(EXIT_SUCCESS);
			}

		}

}
