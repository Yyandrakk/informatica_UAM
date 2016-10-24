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
      if (!strcmp(t[aux]->lexema,x))
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
      if (!strcmp(t[aux]->lexema,x))
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
      return(!strcmp(t[pos]->lexema,cad));
}
/* SOlo usar si antes se ha usado MiembroHash y ha dado positiva*/
int returnCategoriaHash (char *cad,TablaHash t)
{
   return  t[Localizar(cad,t)]->categoria;
}
int returnTipoHash (char *cad,TablaHash t)
{
   return  t[Localizar(cad,t)]->tipo;
}
int returnClaseHash (char *cad,TablaHash t)
{
   return  t[Localizar(cad,t)]->clase;
}
int returnTamanoHash (char *cad,TablaHash t)
{
   return  t[Localizar(cad,t)]->tamano;
}
int returnNumParamHash (char *cad,TablaHash t)
{
   return  t[Localizar(cad,t)]->numero_parametros;
}
int returnNumVarLocalHash (char *cad,TablaHash t)
{
   return  t[Localizar(cad,t)]->numero_variables_locales;
}
int returnPosParHash (char *cad,TablaHash t)
{
   return  t[Localizar(cad,t)]->posicion_parametros;
}
int returnPosVarHash (char *cad,TablaHash t)
{
   return  t[Localizar(cad,t)]->posicion_variable_local;
}
BOOL actualizarFuncionHash (TablaHash t,char *cad,int numero_parametros)
{
  int pos;
  if (MiembroHash(cad,t))
    {
      pos=Localizar1(cad,t);
         t[pos]->numero_parametros=numero_parametros;
         return TRUE;
    }

  return FALSE;
}
BOOL InsertarHash (char *cad,int categoria,int clase,int tipo,int tamano,int numero_variables_locales,int posicion_variable_local,int numero_parametros,int posicion_parametros,TablaHash t)
{
   int pos;

   if (!MiembroHash(cad,t)) {
       pos=Localizar1(cad,t);
       if (t[pos]==NULL ) {
          t[pos]=(elem*)malloc(sizeof(t[pos][0]));
          strcpy(t[pos]->lexema,cad);
          t[pos]->categoria=categoria;
          t[pos]->clase=clase;
          t[pos]->tipo=tipo;
          t[pos]->tamano=tamano;
          t[pos]->numero_variables_locales=numero_variables_locales;
          t[pos]->posicion_variable_local=posicion_variable_local;
          t[pos]->numero_parametros=numero_parametros;
          t[pos]->posicion_parametros=posicion_parametros;
          return TRUE;
       } else {
          return FALSE;
       }
   }
   return FALSE;
}

void BorrarHash (char *cad,TablaHash t)
{
   int pos = Localizar(cad,t);

   if (t[pos]!=NULL ) {
      if (!strcmp(t[pos]->lexema,cad)) {
         free(t[pos]);
         t[pos]=NULL;
      }
   }
}
