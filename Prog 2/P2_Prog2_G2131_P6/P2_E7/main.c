/* 
 * File:   main.c
 * Author: oscar y maria
 *
 * Created on 1 de marzo de 2014, 11:33
 */

#include "stack.h"
#include "queue.h"

#define MAXCOINSTACK 6
/**------------------------------------------------------------------
@name: insertarMoneda
@brief Mete una moneda en su pila correspondiente
@param pila[] array de pilas, moneda.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS insetarMoneda(STACK pila[], COIN *moneda)
{
  VALUE valor=getValueCoin(moneda);
  switch (valor)
            {
                case 5:
          
                if(push(&pila[0],moneda)!=OK)
                    return ERROR;
                break;
       
                case 10:
        
                if(push(&pila[1],moneda)!=OK)
                    return ERROR;
                break;
          
                case 20:
          
                if(push(&pila[2],moneda)!=OK)
                    return ERROR;
                break;  
          
                case 50:
            
                if(push(&pila[3],moneda)!=OK)
                    return ERROR;
                break;
          
                case 1:
          
                if(push(&pila[4],moneda)!=OK)
                    return ERROR;
                break;  
        
                case 2:
          
                if(push(&pila[5],moneda)!=OK)
                    return ERROR;
                 break;  
            }
  return OK;
}
/**------------------------------------------------------------------
@name: devValorMoneda
@brief Retorna el valor de la moneda en centimos.
@param moneda.
@return int-> Valor de la moneda.
------------------------------------------------------------------*/
int devValorMoneda(COIN *moneda)
{
  VALUE valor=getValueCoin(moneda);
  switch (valor)
    {
    case 5:
      valor=5;
      break;
    case 10:
      valor=10;
      break;
    case 20:
      valor=20;
      break;
    case 50:
      valor=50;
      break;
    case 1:
      valor=100;
      break;
    case 2:
      valor=200;
      break;
    }
  return valor;
}
/**------------------------------------------------------------------
@name: retornarCambio
@brief Cuando se le da el cambio al usuario, se saca de la cola y se devuelve a su pila.
@param q, cola y pila[] array de pilas
@return 
------------------------------------------------------------------*/
void retornarCambio(QUEUE *q,STACK pila[])
{
   VALUE valor=0;
   COIN moneda;
   while(extractQueue (q,&moneda)==OK){
 
       valor=getValueCoin(&moneda);
     switch (valor)
             {
                case 5:
          
                push(&pila[0],&moneda);
                break;
       
                case 10:
        
                push(&pila[1],&moneda);
                break;
          
                case 20:
          
                push(&pila[2],&moneda);
                break;  
          
                case 50:
            
                push(&pila[3],&moneda);
                break;
          
                case 1:
          
                push(&pila[4],&moneda);    
                break;  
        
                case 2:
          
               push(&pila[5],&moneda);
                 break;  
            }
     }
}

/**------------------------------------------------------------------
@name: devIndice
@brief Retorna el indice de la array de pila donde esta esa moneda.
@param moneda.
@return -1 en caso de error, indice correspondiente.
------------------------------------------------------------------*/
int devIndice(COIN *moneda)
{
  VALUE valor;

  if(!moneda||(valor=getValueCoin(moneda))==-1)
    return -1;
  
  switch (valor)
    {
    case 5:
      return 0;
    case 10:
      return 1;
    case 20:
      return 2;
    case 50:
      return 3;
    case 1:
      return 4;
    case 2:
      return 5;
    }
      
  return -1;
}
/**------------------------------------------------------------------
@name: imprimirCambio
@brief Imprime la array de pilas en la salida que se le indique.
@param pila[], array de pilas y salida, fichero de salida.
@return 
------------------------------------------------------------------*/
void imprimirCambio(STACK pila[],FILE *salida)
{
  int i;
    
  fprintf(salida,"\n\nMostrando contenido de la pilas de cambio\n=============================");
  
  for (i=MAXCOINSTACK-1;i>=0;i--)
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
/**------------------------------------------------------------------
@name: leerCambio
@brief Inserta todas las monedas de cambio en su pila correspondiente.
@param pila[], array de pilas, entrada, fichero de entrada, salida, fichero de salida.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS leerCambio(STACK pila[],FILE *entrada ,FILE *salida)
{
  ELESTACK moneda;
  VALUE valor=0;
  int limite=0,i;
  char pais[LMAX];
  
  if(salida==NULL || entrada ==NULL)
    return ERROR;
  
    fscanf (entrada, "%d",&limite); /* leemos el numero de elementos*/
  
    if(limite<=0)
      return ERROR;
    
    /* En el siguiente bucle leemos el valor y el pais, con ello lo inicializamos
     en un elemento y lo insertamos en la bolsa*/
    
    for (i=0;i<limite;i++)
    {
        fscanf(entrada,"%d",&valor);
        fscanf(entrada,"%s",pais);
        if(iniCoin(&moneda,valor, pais)!=OK)
            return ERROR;
                  
        fprintf(salida,"\n\n Moneda leida del archivo: ");
        printEleStack(salida,&moneda);
      
         
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
/**------------------------------------------------------------------
@name: iniArrayPila
@brief Inicializa la array de pilas.
@param pila[], array de pilas.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/
STATUS iniArrayPila(STACK pila[]){
  int i;
  for(i=0;i<MAXCOINSTACK;i++)
    {
      if(iniStack(&pila[i])!=OK)
        return ERROR;
    }
  return OK;
}
/**------------------------------------------------------------------
@name: freeArrayPila
@brief Elimina la array de pilas.
@param pila[], array de pilas.
@return OK si todo va bien, ERR si no.
------------------------------------------------------------------*/

STATUS freeArrayPila(STACK pila[]){
  int i;
  for(i=0;i<MAXCOINSTACK;i++)
    {
      if(destroyStack(&pila[i])!=OK)
        return ERROR;
    }
  return OK;
}
int main (int argc, char** argv)
{
  QUEUE cola;
  STACK cambio[MAXCOINSTACK];
  FILE *fwrite=stdout,*fread;
  BOOL salir=FALSE,valida=TRUE,cambiobtenido=FALSE;
  VALUE valor=0;
  char pais[LMAX];
  int indice=0,i,total=0;
  COIN moneda;
  ELESTACK monedaext;
  
  if(argc!=2)
    {
     fprintf(fwrite,"ERROR PASAR ARGUMENTOS"); 
     return EXIT_FAILURE;
      
    }
 
  fread=fopen(argv[1],"r");
  
  /* Iniciamos las pilas y la cola*/
  if(fread==NULL||iniArrayPila(cambio)!=OK||iniQueue(&cola)!=OK)
    {
      fprintf(fwrite,"ERROR INICIAR LA COLA, LAS PILAS O FICHERO"); 
      return EXIT_FAILURE;
    }
  /*Metemos todas las monedas del archivo en las pilas*/
  if(leerCambio(cambio,fread,fwrite)!=OK)
  {
    fprintf(fwrite,"ERROR LEER EL CAMBIO"); 
    return EXIT_FAILURE;
  }
  
  fclose(fread);
  fread=stdin;
  
  /*
   1º do While sirve para salir del programa cuando se le inserta una moneda de valor 0
   */
  do 
  {
      cambiobtenido=FALSE;/*Para reiniciar la condicion el ultimo do while*/
      imprimirCambio(cambio,fwrite);
      do
       {/* 2º do While, evita meter mal datos a la moneda, solo te deja salir cuando lo haces bien o metes 0*/
         fprintf(fwrite,"\nInserte una moneda\n");
         fprintf(fwrite,"Valor:");
         fscanf(fread,"%d",&valor);
         if(valor==0)
           {
             salir=TRUE;
           }
       
        else
          { 
            fprintf(fwrite,"\n pais: ");
            fscanf(fread,"%s",pais);
            if(iniCoin(&moneda,valor, pais)!=OK)
                valida=FALSE;
            else
                valida=TRUE;
          }
      }while(valida==FALSE);
    
      if(salir==FALSE)/*Evita que se ejecute el programa cuando quieres salir*/
       {
        indice=devIndice(&moneda);          
        do/*3º do While sirve para en el caso que haya un error entre en el caso -1 obligatoriamente
            ya que devuelve la moneda y libera si es necesaria la cola*/
          {
            switch(indice)
              {
              case -1:
                fprintf(fwrite,"\nNo hay cambio disponible: Se devuelve la moneda ");
                printCoin(fwrite,&moneda);
                freeCoin(&moneda);
                if(isEmptyQueue(&cola)!=TRUE)
                  retornarCambio(&cola,cambio);
                cambiobtenido=TRUE;
                break;
              default:
                indice--;/*Tengo el indice de la pila de la moneda introducida pero necesito la de abajo*/
                valor=devValorMoneda(&moneda);/*El valor de la moneda introducida*/
                i=indice;/*Necesito un indice auxiliar ya que no puedo tocar el original*/
                total=0;/*reinicia el total en cada extracion*/
                while(valor!=total&&indice!=-1)/* Cuando valor sea igual a total o indice sea -1 se  sale*/
                  {
                    if(i<0)/* i nunca puede ser negativo*/
                      indice=-1;
                    /*Comprobamos que hay moneda en la pila y que sumando su valor no nos pasamos*/
                    else if(topStack(&cambio[i],&monedaext)!=OK||valor<total+getValueCoin(&monedaext))
                      i--;
                    /*Extraemos de la pila, sumamos e insertamos en la cola*/
                    else
                      {
                        pop(&cambio[i],&monedaext);
                        total=total+devValorMoneda(&monedaext);
                        if(insertQueue(&cola,&monedaext)!=OK)
                            indice=-1;
                      }
                  }
                /*En caso de que haya un error no insertamos la moneda*/
                if(indice!=-1)
                  {
                    if(insetarMoneda(cambio,&moneda)!=OK)
                        indice=-1;
                  }
                /*En caso de no poder insertar la moneda, se ha llenado esa pila, no le damos el cambio*/
                if(indice!=-1)
                  {
                    fprintf(fwrite,"Se cambio por: ");
                    while(extractQueue(&cola,&monedaext)==OK)
                      printEleQueue(fwrite,&monedaext);
                    cambiobtenido=TRUE;
                  }
                break;
              }
            
          }while(cambiobtenido==FALSE);
        
      }/*FINAL DEL SWITCH*/
              
  }while(salir==FALSE);  
  /*Apagamos la maquina liberando todo*/
  fprintf(fwrite,"\nSe apago la maquina de cambio\n");
  freeArrayPila(cambio);
  destroyQueue(&cola);
  freeCoin(&moneda);
  destroyEleStack(&monedaext);
  
  return (EXIT_SUCCESS);
}

