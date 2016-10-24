#include <stdio.h>
#include <stdlib.h>
#include <string.h>


unsigned int far minimoComunMultiplo (unsigned int a,unsigned int b);
int far calculaMediana(int a, int b, int c, int d);
int far esFibonacci(int a);
int far divisiblePor4(int a);
void far calculaChecksum(char* inStr, char* Check);
void far calculaLetraDNI(char* inStr, char* letra);
void far enteroACadenaHexa (int num, char* outStr);
int main()
{
	int opcion=0,resultado=0, a[4],i;
	unsigned int resul=0,b[2];
	char salida[10],entrada[30];

	do
	{
		printf("\n ------------------------------- \n \t \t MENU \n -------------------------------");
		printf("\n \t 1º MINIMO COMUN MULTIPLO\n \t 2º MEDIANA\n \t 3º SUCESION DE FIBONACCI\n \t 4º DIVISIBLE POR 4\n \t 5º ENTERO A ASCII\n \t 6º CALCULA CHECKSUM\n \t 7ºLETRA DEL DNI \n \t 0º Terminar programa");
		printf("\n \t INGRESE OPCION: ");
		scanf("%d",&opcion);
		switch (opcion)
		{

			case 0:
				printf("\n Terminando programa");
			break;

			case 1:

				for(i=0;i<2;i++)
					{
					printf("\nEscribe el %u  numero para el mcm: ",i+1);
					scanf("%u",&b[i]);
					}

				resul = minimoComunMultiplo (b[0], b[1]);

			printf("\n El minimo comun multiplo de %u y %u es %u",b[0],b[1],resul);
			break;

			case 2:

				for(i=0;i<4;i++)
					{
					printf("\nEscribe el %d  numero para la mediana: ",i+1);
					scanf("%d",&a[i]);
					}


				resultado = calculaMediana(a[0],a[1],a[2],a[3]);

				printf("\nLa mediana de %d, %d, %d, %d es %d",a[0],a[1],a[2],a[3],resultado);

			break;

			case 3:


				printf("\nEscribe el  numero para la succesion: ");
				scanf("%d",&a[0]);

				resultado=esFibonacci(a[0]);

				if(resultado==0)
					printf("El numero %d no pertenece a la sucesion de Fibonacci",a[0]);
				else
					printf("El numero %d pertenece a la sucesion de Fibonacci",a[0]);

			break;

			case 4:

				printf("\nEscribe el numero para comprobar si es divisible por 4: ");
				scanf("%d",&a[0]);

				resultado=divisiblePor4(a[0]);

				if(resultado==0)
					printf("El numero %d no es divisible por 4",a[0]);
				else
					printf("El numero %d es divisible por 4",a[0]);
			break;

			case 5:
				printf("\nEscribe el numero que quieres pasar a la cadena: ");
				scanf("%d",&a[0]);

				enteroACadenaHexa (a[0],salida);

				printf("\nEl numero es %d y la cadena contiene %s",a[0],salida);
				break;

			case 6:
				printf("\nEscribe la cadena de bytes: ");
				scanf("%s",entrada);

				calculaChecksum(entrada,salida);

				printf("\nLa cadena de entrada es %s y el cheksum %s",entrada,salida);
				break;

			case 7:
				printf("\nEscribe los numeros de tu DNI: ");
				scanf("%s",entrada);

				calculaLetraDNI(entrada, salida);

				printf("\nTu DNI es %s y su letra es %s",entrada,salida);
				break;
			default:
			printf("\n OPCION NO ENCONTRADA \n");
			break;

		}



	}while(opcion!=0);

	return 0;



}
