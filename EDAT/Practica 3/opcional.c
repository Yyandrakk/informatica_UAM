#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>
#include "odbc.h"

int main(int argc, char *argv[]){

	CONSULTA con;
	SQLRETURN ret;
	SQLHENV env;
        SQLHDBC dbc;
	int i=0;
	int opcion = 0;

	if(argc== 5){
	for(i = 1; i < argc ; i++) {
    	   if (strcmp(argv[i], "informacion") == 0) {
     		 opcion = 2;i++;
    	   strcpy(con.nombre,argv[i]);
	   i++;
	   strcpy(con.sexo,argv[i]);
	   i++;
	   con.edad =atoi(argv[i]);
      	   }
        }
  	}else if(argc == 2){
	  for(i = 1; i < argc ; i++) {
	      if (strcmp(argv[i], "prestados") == 0) 
     		 opcion = 1;
          }
        }     	
	   	

	switch(opcion)
	{
	case 1:
	
	ret = odbc_connect(&env, &dbc);
	if (!SQL_SUCCEEDED(ret)) 
        return EXIT_FAILURE;
     
	con.consulta = (char *)malloc(strlen(LISTA_PRESTADOS)+20*sizeof(con.consulta[0]));
	sprintf(con.consulta,LISTA_PRESTADOS);
	i = imprimir(con,dbc);
	if(i == 0){	
		free(con.consulta);
	   	printf("Error interno, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
        }
	free(con.consulta);

	ret = odbc_disconnect(env, dbc);
           if (!SQL_SUCCEEDED(ret)) {
           return EXIT_FAILURE;}	
	break;
	case 2:
	
	ret = odbc_connect(&env, &dbc);
	if (!SQL_SUCCEEDED(ret)) 
        return EXIT_FAILURE;
     
	con.consulta = (char *)malloc(strlen(OBTENER_DATOS)+20*sizeof(con.consulta[0]));
	sprintf(con.consulta,OBTENER_DATOS,con.nombre,con.sexo,con.edad);
	i = imprimir(con,dbc);
	if(i == 0){	
		free(con.consulta);
	   	printf("Error interno, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
        }
	free(con.consulta);
 	
	ret = odbc_disconnect(env, dbc);
           if (!SQL_SUCCEEDED(ret)) {
           return EXIT_FAILURE;}	
	break;
	}

}
