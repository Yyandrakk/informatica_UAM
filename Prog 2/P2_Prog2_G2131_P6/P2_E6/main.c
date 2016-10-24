/* 
 * File:   main.c
 * Author: oscar y maria
 *
 * Created on 5 de marzo de 2014, 15:14
 */

#include "queue.h"
#define MAXCOINQUEUE 7
/**------------------------------------------------------------------
@name: devValorMoneda
@brief Retorna el valor de la moneda en centimos.
@param moneda.
@return int-> Valor de la moneda.
------------------------------------------------------------------*/
double devValorMoneda(COIN *moneda)
{
  VALUE valor=getValueCoin(moneda);
  switch (valor)
    {
    case 5:
      return 0.05;
      break;
    case 10:
      return 0.1;
      break;
    case 20:
      return 0.2;
      break;
    case 50:
      return 0.5;
      break;
    case 1:
      return 1;
      break;
    case 2:
      return 2;
      break;
    }
  return 0;
}
/**------------------------------------------------------------------
@name: retornarCambio
@brief Cuando se le da el cambio al usuario, se saca de la cola y se devuelve a su pila.
@param q, cola y pila[] array de pilas
@return 
------------------------------------------------------------------*/
void retornarCambio(QUEUE q[])
{
   VALUE valor=0;
   COIN moneda;
   while(extractQueue (&q[0],&moneda)==OK){
 
       valor=getValueCoin(&moneda);
     switch (valor)
             {
                case 5:
          
                insertQueue(&q[1],&moneda);
                break;
       
                case 10:
        
                insertQueue(&q[2],&moneda);
                break;
          
                case 20:
          
                insertQueue(&q[3],&moneda);
                break;  
          
                case 50:
            
                insertQueue(&q[4],&moneda);
                break;
          
                case 1:
          
                insertQueue(&q[5],&moneda);    
                break;  
        
                case 2:
          
               insertQueue(&q[6],&moneda);
                 break;  
            }
     }
}

/**------------------------------------------------------------------
@name: iniArrayPila
@brief Inicializa la array de pilas.
@param pila[], array de pilas.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS iniArrayCola(QUEUE q[]){
  int i;
  for(i=0;i<MAXCOINQUEUE;i++)
    {
      if(iniQueue(&q[i])!=OK)
        return ERROR;
    }
  return OK;
}
/**------------------------------------------------------------------
@name: freeArrayCola
@brief Elimina el array de pilas.
@param pila[], array de pilas.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/

STATUS freeArrayCola(QUEUE q[]){
  int i;
  for(i=0;i<MAXCOINQUEUE;i++)
    {
      if(destroyQueue(&q[i])!=OK)
        return ERROR;
    }
  return OK;
}

STATUS llenarBolsa(QUEUE q[], FILE *entrada)
{
    VALUE valor=0;
    int limite=0,i;
    char pais[LMAX];
    ELEQUEUE elemento;
  
    fscanf (entrada, "%d",&limite); /* leemos el numero de elementos*/
    if(limite<=0)
      return ERROR;
    /* En el siguiente bucle leemos el valor y el pais, con ello lo inicializamos
     en un elemento y lo insertamos en la bolsa*/
    for (i=0;i<limite;i++)
    {
        fscanf(entrada,"%d",&valor);
        fscanf(entrada,"%s",pais);
        if(iniCoin(&elemento,valor, pais)!=OK||insertQueue (&q[0], &elemento)!=OK)
            return ERROR;
     }
    
    return OK;
}

int main (int argc, char** argv)
{
  int i,parte_entera=0,parte_decimal=0;
  QUEUE cola[MAXCOINQUEUE];
  FILE *entrada;
  ELEQUEUE moneda;
  double total=0;
  if(argc!=2)
    return EXIT_FAILURE;
  
  entrada=fopen(argv[1], "r");
  
  if(entrada==NULL||iniArrayCola(cola)!=OK)
      return EXIT_FAILURE;
  
  if(llenarBolsa(cola,entrada)!=OK)
    {
      fclose(entrada);
      freeArrayCola(cola);
      return EXIT_FAILURE;
    }
  
  fclose(entrada);
  retornarCambio(cola);
  for(i=1;i<MAXCOINQUEUE;i++)
    {
      switch(i)
        {
        case 1:
          printf("\n Imprimiendo cola de 5 ");
             while(extractQueue (&cola[i],&moneda)==OK)
                 {
                 printEleQueue(stdout,&moneda);
                 total=total+devValorMoneda(&moneda);
                 }
             break;
             case 2:
               printf("\n Imprimiendo cola de 10 ");
             while(extractQueue (&cola[i],&moneda)==OK)
                 {
                 printEleQueue(stdout,&moneda);
                 total=total+devValorMoneda(&moneda);
                 }
             break;
             case 3:
               printf("\n Imprimiendo cola de 20 ");
             while(extractQueue (&cola[i],&moneda)==OK)
                 {
                 printEleQueue(stdout,&moneda);
                 total=total+devValorMoneda(&moneda);
                 }
             break;
             case 4:
               printf("\n Imprimiendo cola de 50 ");
             while(extractQueue (&cola[i],&moneda)==OK)
                 {
                 printEleQueue(stdout,&moneda);
                 total=total+devValorMoneda(&moneda);
                 }
             break;
             case 5:
               printf("\n Imprimiendo cola de 1 ");
             while(extractQueue (&cola[i],&moneda)==OK)
                 {
                 printEleQueue(stdout,&moneda);
                 total=total+devValorMoneda(&moneda);
                 }
             break;
             case 6:
               printf("\n Imprimiendo cola de 2 ");
             while(extractQueue (&cola[i],&moneda)==OK)
                 {
                 printEleQueue(stdout,&moneda);
                 total=total+devValorMoneda(&moneda);
                 }
             break;
        }
    }
  parte_entera=total/1;
  parte_decimal=(total-parte_entera)*100;
  printf("\nEl valor de la caja asciende a %d euros y %d centimos",parte_entera,parte_decimal);
  freeArrayCola(cola);
  return (EXIT_SUCCESS);
}