#include "tablashash.h"

    TablaHash crearTablaHash()
    {
        int i;
        TablaHash t=(TablaHash)malloc(TAMANO_HASH*sizeof(t[0]));
        if(!t)
            return t;
        for(i=0;i<TAMANO_HASH;i++)
            t[i]=NULL;
        return t;
        
    }
    void destruirTablaHash(TablaHash t)
    {
        int i;
        for(i=0;i<TAMANO_HASH;i++)
        {
            if(t[i]!=NULL)
                free(t[i]);
        }
        free(t);
        t=NULL;
    }
    int Hash (char *cad) 
{
   int valor;
   unsigned char *c;	
  
   for (c=(unsigned char*)cad, valor=0; *c; c++)
   	  valor += (int)*c;

   return (valor%TAMANO_HASH);
}

int Localizar (char *x,TablaHash t) 

/* Devuelve el sitio donde esta x  o donde deberia de estar. */ 
/* No tiene en cuenta los borrados.                          */

{
   int ini,i,aux;

   ini=Hash(x);

   for (i=0;i<TAMANO_HASH;i++) {
      aux=(ini+i)%TAMANO_HASH;
      if (t[aux]==NULL)
         return aux;
      if (!strcmp(t[aux]->id,x))
         return aux;
   }
   return ini;
}

int Localizar1 (char *x,TablaHash t) 

/* Devuelve el sitio donde podriamos poner x  */

{
   int ini,i,aux;

   ini=Hash(x);

   for (i=0;i<TAMANO_HASH;i++) {
      aux=(ini+i)%TAMANO_HASH;
      if (t[aux]==NULL)
         return aux;
      if (!strcmp(t[aux]->id,x))
         return aux;
   }

   return ini;
}

int MiembroHash (char *cad,TablaHash t)  
{
   int pos=Localizar(cad,t);

   if (t[pos]==NULL)
      return 0;
   else
      return(!strcmp(t[pos]->id,cad));
}
/* SOlo usar si antes se ha usado MiembroHash y ha dado positiva*/
int returnValorHash (char *cad,TablaHash t)  
{
   return  t[Localizar(cad,t)]->num;
}
void InsertarHash (char *cad,int num,TablaHash t) 
{
   int pos;

   if (!MiembroHash(cad,t)) {
       pos=Localizar1(cad,t);
       if (t[pos]==NULL ) {
          t[pos]=(elem*)malloc(sizeof(t[pos][0]));
          strcpy(t[pos]->id,cad);
          t[pos]->num=num;
       } else {
          printf("Tabla Llena. \n");
       }
   }
}

void BorrarHash (char *cad,TablaHash t) 
{
   int pos = Localizar(cad,t);

   if (t[pos]!=NULL ) {
      if (!strcmp(t[pos]->id,cad)) {
         free(t[pos]);
         t[pos]=NULL;
      }
   }
}
