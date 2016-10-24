/* 
 * File:   main.c
 * Author: Oscar y Maria
 * Created on 22 de febrero de 2014, 17:32
 */

#include "bag.h"
#include "stack.h"
#define MAXCOINSTACK 6

void imprimirPilaMonedas(STACK pila[],FILE *salida)
{
  int i;
    
  fprintf(salida,"\n\nMostrando la clasificacion de las monedas\n=============================");
  
  for (i=0;i<MAXCOINSTACK;i++)
    {
     
      switch(i)
        {
        case 0:
          fprintf(salida,"\nmonedas de 5 centimos:");
           printStack (salida,&pila[i]);
          break;
        
        case 1:
          fprintf(salida,"\nmonedas de 10 centimos:");
           printStack (salida,&pila[i]);
          break;
          
         case 2:
          fprintf(salida,"\nmonedas de 20 centimos:");
           printStack (salida,&pila[i]);
          break;
          
         case 3:
          fprintf(salida,"\nmonedas de 50 centimos:");
           printStack (salida,&pila[i]);
          break;
          
         case 4:
          fprintf(salida,"\nmonedas de 1 euro:");
           printStack (salida,&pila[i]);
          break;
          
         case 5:
          fprintf(salida,"\nmonedas de 2 euros:");
           printStack (salida,&pila[i]);
          break;
        }
    }
}

STATUS ordenarMonedas(STACK pila[],BAG *bolsa, FILE *salida)
{
  ELESTACK moneda;
  VALUE valor=0;
    
  if(salida==NULL || bolsa ==NULL)
    return ERROR;
  fprintf(salida,"\n");
  while(extractElemBag (bolsa,&moneda)==OK)
    {
      fprintf(salida,"\nExtrayendo elemento de la hucha");
      printEleStack(salida,&moneda);
      
      if((valor=getValueCoin (&moneda))==-1)
        return ERROR;
         
      switch (valor)
        {
        case 5:
          
          if(push(&pila[0],&moneda)!=OK)
            return ERROR;
          fprintf(salida,"\nInsertando moneda en la pila de 5 centimos");
          break;
       
        case 10:
        
          if(push(&pila[1],&moneda)!=OK)
            return ERROR;
          fprintf(salida,"\nInsertando moneda en la pila de 10 centimos");
          break;
          
        case 20:
          
          if(push(&pila[2],&moneda)!=OK)
            return ERROR;
          fprintf(salida,"\nInsertando moneda en la pila de 20 centimos");
          break;  
          
        case 50:
            
          if(push(&pila[3],&moneda)!=OK)
            return ERROR;
          fprintf(salida,"\nInsertando moneda en la pila de 50 centimos");
          break;
          
        case 1:
          
          if(push(&pila[4],&moneda)!=OK)
            return ERROR;
          fprintf(salida,"\nInsertando moneda en la pila de 1 euro");
          break;  
        
        case 2:
          
          if(push(&pila[5],&moneda)!=OK)
            return ERROR;
          fprintf(salida,"\nInsertando moneda en la pila de 2 euros");
          break;  
        }
    }
  
  return OK;
}

STATUS iniArrayPila(STACK pila[]){
  int i;
  for(i=0;i<MAXCOINSTACK;i++)
    {
      if(iniStack(&pila[i])!=OK)
        return ERROR;
    }
  return OK;
}

STATUS freeArrayPila(STACK pila[]){
  int i;
  for(i=0;i<MAXCOINSTACK;i++)
    {
      if(destroyStack(&pila[i])!=OK)
        return ERROR;
    }
  return OK;
}

STATUS llenarBolsa(BAG *bolsa, FILE *entrada)
{
    VALUE valor=0;
    int limite=0,i;
    char pais[LMAX];
    ELEMBAG elemento;
  
    fscanf (entrada, "%d",&limite); /* leemos el numero de elementos*/
    if(limite<=0)
      return ERROR;
    /* En el siguiente bucle leemos el valor y el pais, con ello lo inicializamos
     en un elemento y lo insertamos en la bolsa*/
    for (i=0;i<limite;i++)
    {
        fscanf(entrada,"%d",&valor);
        fscanf(entrada,"%s",pais);
        if(iniCoin(&elemento,valor, pais)!=OK||insertElemBag (bolsa, &elemento)!=OK)
            return ERROR;
     }
    
    return OK;
}

int main (int argc, char** argv)
{
    FILE *fread, *fwrite=stdout;
    BAG bolsa;   
    STACK plmonedas[MAXCOINSTACK];
    
     if(argc!=2)
      {
      	printf("ERROR LEER COMANDOS");
      	return EXIT_FAILURE;
      }
    
    fread=fopen(argv[1],"r"); /* Fichero entrada */ 
        
    if (fread==NULL||iniBag(&bolsa)!=OK) 
        return EXIT_FAILURE;
    
    if(llenarBolsa(&bolsa,fread)!=OK)
      {       
         printf("Error Bolsa llena, inicializar moneda o fichero vacio");
         fclose(fread);
         return EXIT_FAILURE;
      }
    
    printBag(fwrite,&bolsa);
    
    if(iniArrayPila(plmonedas)!=OK)
      {
        printf("Error inicializar pila de monedas");
        fclose(fread);
        return EXIT_FAILURE;    
      }
    
    if(ordenarMonedas(plmonedas,&bolsa,fwrite)!=OK)
      {
        printf("Error ordenar pila de monedas");
        fclose(fread);
        return EXIT_FAILURE;    
      }
  
    imprimirPilaMonedas(plmonedas,fwrite);
  
    if(freeArrayPila(plmonedas)!=OK)
      {
        printf("Error borrar pila de monedas");
        fclose(fread);
        return EXIT_FAILURE;    
      }
  
    freeBag(&bolsa);
    fclose(fread);
    
  return (EXIT_SUCCESS);
}

