#ifndef PRINTNASM_H
#define PRINTNAMS_H

#include "tablashash.h"

void escribirSegmentBss (TablaHash t);
void escribirMain();
void escribirCabCodigo();
void escribirSegmentData();
void escribirErrores();
void insertarIdentPila(char *cad,int linea);
void insertarConst(int valor, int linea);
void operacionesExp(int caso, int dir1, int dir2);
void operacionesCmp (int caso, int dir1, int dir2, int etiqueta);
void escribirElemVector(int dir1,char *cad,TablaHash t);
void asignarIdent(char *cad, int dir);
void asignarIdentLocal(int dir);
void asignarElem (int dir1);
void escribirScanf (char * cad, int tipo);
void escribirScanfFuncion (int tipo);
void escribirPrint (int dir,int tipo);
void escribirif(int dir, int etiqueta);
void escribirifend(int etiqueta);
void escribirif_exp(int etiqueta);
void escribirelse(int etiqueta);
void escribirwhile( int etiqueta);
void escribirwhile_exp(int dir,int etiqueta);
void escribirwhile_fin(int etiqueta);
void escribirfuncionfirst(char *cad,int num_variable_local);
void escribirfuncionend();
void escribirllamadafuncion(char *cad, int num_parametros);
void escribirIdentificador(char *cad,int 	en_explit);
void escribirRetorno (int dir);
void escribirIdentificadorLocal (int categoria,int num_param, int pos_param, int pos_var,int llamada_dentro_funcion);



#endif
