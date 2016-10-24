/*
 * File:   tablashash.h
 * Author: oscar
 *
 * Created on 14 de octubre de 2014, 10:43
 */

#ifndef TABLASHASH_H
#define	TABLASHASH_H

#ifdef	__cplusplus
extern "C" {
#endif
#include "alfa.h"
    typedef struct {
      char lexema[MAX_LONG_ID+1];
      int categoria;
      int clase;
      int tipo;
      int tamano;
      int valor_entero;
      int numero_variables_locales;
      int posicion_variable_local;
      int numero_parametros;
      int posicion_parametros;
    }elem;
    typedef elem **TablaHash;

    TablaHash crearTablaHash();
    void destruirTablaHash(TablaHash t);
    int Hash (char *cad);
    int Localizar (char *x,TablaHash t) ;
    int Localizar1 (char *x,TablaHash t) ;
    int MiembroHash (char *cad,TablaHash t)  ;
    BOOL actualizarFuncionHash (TablaHash t,char *cad,int numero_parametros);
    BOOL InsertarHash (char *cad,int categoria,int clase,int tipo,int tamano,int numero_variables_locales,int posicion_variable_local,int numero_parametros,int posicion_parametros,TablaHash t) ;
    void BorrarHash (char *cad,TablaHash t) ;
    int returnValorHash (char *cad,TablaHash t);
    int returnCategoriaHash (char *cad,TablaHash t);
    int returnTipoHash (char *cad,TablaHash t);
    int returnClaseHash (char *cad,TablaHash t);
    int returnTamanoHash (char *cad,TablaHash t);
    int returnNumParamHash (char *cad,TablaHash t);
    int returnNumVarLocalHash (char *cad,TablaHash t);
    int returnPosParHash (char *cad,TablaHash t);
    int returnPosVarHash (char *cad,TablaHash t);
#ifdef	__cplusplus
}
#endif

#endif	/* TABLASHASH_H */
