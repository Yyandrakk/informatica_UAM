#ifndef AUX_H
#define AUX_H
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <sql.h>
#include <sqlext.h>
#include <time.h>

/* CONNECTION PARAMETERS, ADAPT TO YOUR SCENARIO */
#define CONNECTION_PARS "DRIVER=PostgreSQL Unicode;DATABASE=EDATOS;SERVER=localhost;PORT=5432;UID=postgres;PWD=postgres;"

#define OBTENER_DATOS "select uid from usuario where nombre = '%s' and sexo = '%s' and edad = '%d';"
#define LISTA_PRESTADOS "select libro from prestamo natural join libro where devuelto = 0;"
#define EXISTE_USUARIO "select uid from usuario where uid=%d and activado=1;"
#define ELIMINAR_USUARIO  "update usuario set activado=%d where uid=%d;"
#define CREAR_USUARIO "INSERT INTO usuario VALUES(%d,'%s','%s',%d,%d);"
#define DEVOLVER_LIBRO "update prestamo set devuelto=%d,puntuacion=%d where uid=%d and isbn=%d;"
#define ACTUALIZAR_LIBRO  "update libro set num_dis=%d where isbn=%d;"
#define SACAR_LIBRO "insert into prestamo values(%d,%d,date '%s',%d,%d);"
#define COMPROBAR_POSESION "select uid from prestamo where uid=%d and isbn=%d and devuelto=%d;"
#define INFO_LIBRO "select isbn,libro,fecha,idioma,genero,num_total,num_dis from libro where isbn = %d;"
#define EXISTE_LIBRO "select isbn from libro where isbn = %d;"

typedef struct{
int id;
char nombre[20];
char sexo[1];
int edad;
int activado;
int isbn;
int puntuacion;
int ejemplares;
char *consulta;
int devuelto;
}CONSULTA;

/* REPORT OF THE MOST RECENT ERROR USING HANDLE handle */
void odbc_extract_error(char *fn, SQLHANDLE handle, SQLSMALLINT type);

/* STANDARD CONNECTION PROCEDURE */
int odbc_connect(SQLHENV* env, SQLHDBC* dbc);

/* STANDARD DISCONNECTION PROCEDURE */
int odbc_disconnect(SQLHENV env, SQLHDBC dbc);
int actualizar(CONSULTA con ,SQLHDBC dbc);
int crear_tupla(CONSULTA ,SQLHDBC );
int info_libro(CONSULTA ,SQLHDBC);
int comprobar(CONSULTA ,SQLHDBC );
int aleat_num(int , int );
void imprime_resultadoargcusuario();
void imprime_resultadoargcprestamo();
int imprimir(CONSULTA ,SQLHDBC );

#endif
