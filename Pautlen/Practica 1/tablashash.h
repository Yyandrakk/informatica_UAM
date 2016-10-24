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
#include "simbandinclude.h"
    typedef struct {
        char id[TAMANO];
        int num;
    }elem;
    typedef elem **TablaHash;
    
    TablaHash crearTablaHash();
    void destruirTablaHash(TablaHash t);
    int Hash (char *cad);
    int Localizar (char *x,TablaHash t) ;
    int Localizar1 (char *x,TablaHash t) ;
    int MiembroHash (char *cad,TablaHash t)  ;
    void InsertarHash (char *cad,int num,TablaHash t) ;
    void BorrarHash (char *cad,TablaHash t) ;
    int returnValorHash (char *cad,TablaHash t);  

#ifdef	__cplusplus
}
#endif

#endif	/* TABLASHASH_H */

