/* 
 * File:   main.c
 * Author: oscar
 *
 * Created on 20 de marzo de 2014, 13:34
 */

#include "list.h"

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

int main (int argc, char** argv)
{
  FILE *file;
  LIST l;
  ELELIST e;
  char nombre[LMAX],nomcoin[LMAX],datos[LMAX];
  BAG monedero;
  VALUE valor;
  int i,j,limitep=0,limitec=0;
  double total=0;
  COIN c;
  
  if(argc!=2)
    return EXIT_FAILURE;
  
  file=fopen(argv[1],"r");
  
  if(!file||iniList(&l)!=OK||iniBag(&monedero)!=OK)
    {
    if(file)
      fclose(file);
    return EXIT_FAILURE;
    }
 
   fscanf(file,"%s",datos);
   
   if(feof(file)!=0)/* si el fichero esta vacio para el programa*/
     {
        fprintf(stdout,"FICHERO VACIO \n");
        fclose(file);
        return (EXIT_SUCCESS);
     }
   if( sscanf(datos,"%d",&limitep)!=0&&limitep!=0)/* Si el carcter leido no es un numero o es 0 evita que se ejute*/
      {
            for(i=0;i<limitep;i++)
             {
                fscanf(file,"%s",nombre);
                fscanf(file,"%s",datos);
                if(sscanf(datos,"%d",&limitec)==0)/* Evita que no pase un numero de monedas*/
                {
                    fprintf(stdout,"\nERROR NUMERO DE MONEDAS\n");
                    freeList(&l);
                    fclose(file);
                    return EXIT_FAILURE;
                }
       
                /* En el caso que se haya pasado mal el numero de personas 
                * y se termina el fichero antes, deja de coger personas e imprime las que se tiene*/
                if(feof(file)!=0)                   
               {
                   break;
               } 
                for(j=0,valor=0;j<limitec;j++)
                {
                    fscanf(file,"%d",&valor);
                    fscanf(file,"%s",nomcoin);
                    if(iniCoin(&c,valor,nomcoin)!=OK||insertElemBag (&monedero, &c)!=OK)
                    {
                        fprintf(stdout,"ERROR INICIALIZAR MONEDA O INSERTAR MONEDA");
                         freeBag(&monedero);
                        freeList(&l);
                        fclose(file);
                        return EXIT_FAILURE;
                    }     
                } 
      
                if(iniEleList (&e,strlen(nombre)+1)!=OK)
                  {
                    freeBag(&monedero);
                    freeList(&l);
                    fclose(file);
                    return EXIT_FAILURE;
                  }  
      
                if(iniPersonWithName( &e, nombre,&monedero)!=OK)
                   {
                     freeEleList (&e);
                     freeBag(&monedero);
                     freeList(&l);
                     fclose(file);
                     return EXIT_FAILURE;
                   }
                if(insertFirstEleList (&l, &e)!=OK)
                   {
                     freeEleList (&e);
                     freeBag(&monedero);
                     freeList(&l);
                     fclose(file);
                     return EXIT_FAILURE;
                    }
                freeBag(&monedero);
                freeEleList (&e);
           }
     
  fclose(file);
    
  while(extractFirstEleList(&l,&e)==OK)
    {
      printEleList (stdout, &e);
      while(extractElemBag (getWallet (&e),&c)==OK)
        {
          total=total+devValorMoneda(&c);
        }
      freeEleList(&e);
      fprintf(stdout,"\nTotal: %.2f\n" ,total);
      total=0;
    }
}
  else
    {
      fprintf(stdout,"FICHERO VACIO( PASADO UN UNA LETRA O UN CERO) \n");
      fclose(file);
    } 
  
  return (EXIT_SUCCESS);
}

