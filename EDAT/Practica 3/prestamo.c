#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>
#include "odbc.h"



int main(int argc, char *argv[]){

	int i=0;
	CONSULTA con;
	SQLHENV env;
        SQLHDBC dbc;	
	SQLRETURN ret;
	int opcion =0;

    if(argc!=5 && argc!=4){
	imprime_resultadoargcprestamo();
    return;}

     if(argc== 5){
	for(i = 1; i < argc ; i++) {
    	   if (strcmp(argv[i], "+") == 0) {
     		 opcion = 1;i++;
    	   con.id = atoi(argv[i]);
	   i++;
	   con.isbn = atoi(argv[i]);
	   i++;
	   con.puntuacion =atoi(argv[i]);
           }
	}
      }else if(argc == 4){
	for(i = 1; i < argc ; i++) {
	      if (strcmp(argv[i], "-") == 0) {
     		 opcion = 2;i++;
    	         con.id = atoi(argv[i]);
	         i++;
	         con.isbn = atoi(argv[i]);
              }
        }
       } 
	
	switch(opcion)
	{
	  case 1:/*DEVOLVER UN LIBRO*/
	   
	   ret = odbc_connect(&env, &dbc);
           if (!SQL_SUCCEEDED(ret)) {
           return EXIT_FAILURE;}
           /*COMPROBAMOS QUE EL USUARIO EXISTE*/
	   con.consulta = (char *)malloc(strlen(EXISTE_USUARIO)+20*sizeof(con.consulta[0]));
	   sprintf(con.consulta,EXISTE_USUARIO,con.id);
	   i = comprobar(con,dbc);
	   if(i == 0){	
		free(con.consulta);
	   	printf("Usuario incorrecto o inexistente, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
           }
	   free(con.consulta);
	   /*COMPROBAMOS QUE EL LIBRO EXISTE*/
	   con.consulta = (char *)malloc(strlen(EXISTE_LIBRO)+20*sizeof(con.consulta[0]));
	   sprintf(con.consulta,EXISTE_LIBRO,con.isbn);
	   i = comprobar(con,dbc);
	   if(i == 0){
		free(con.consulta);
	   	printf("El libro no existe, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
	   }
	   free(con.consulta);
	   /*COMPROBAMOS QUE LO TIENE*/
	   con.consulta = (char *)malloc(strlen(COMPROBAR_POSESION)+20*sizeof(con.consulta[0]));
	   con.devuelto = 0;
	   sprintf(con.consulta,COMPROBAR_POSESION,con.id,con.isbn,con.devuelto);
	   i = comprobar(con,dbc);
	   if(i == 0){
		free(con.consulta);
	   	printf("No puedes devolver un libro que no tienes, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
           }
	   free(con.consulta);
	  
	   /*CONSEGUIMOS INFORMACION DEL LIBRO*/
	   con.consulta = (char *)malloc(strlen(INFO_LIBRO)+50*sizeof(con.consulta[0]));
 	   sprintf(con.consulta,INFO_LIBRO,con.isbn);
	   i = info_libro(con,dbc);
	   if(i == -1){
		free(con.consulta);
	        printf("Ha habido un error tecnico, adios\n");
	        ret = odbc_disconnect(env, dbc);
	        if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}}
	   /*DEVOLVEMOS EL LIBRO*/
	   con.ejemplares = i;
	   con.devuelto = 1;
	   con.consulta = (char *)malloc(strlen(DEVOLVER_LIBRO)+50*sizeof(con.consulta[0]));
	   sprintf(con.consulta,DEVOLVER_LIBRO,con.devuelto,con.puntuacion,con.id,con.isbn);
	   i = actualizar(con,dbc);
	   if(i == -1){
		free(con.consulta);
	   	printf("Error al devolver el libro, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
           }
	   free(con.consulta);
	  	   
	   con.ejemplares++;
	   /*ACTUALIZAMOS EL LIBRO*/
	   con.consulta = (char *)malloc(strlen(ACTUALIZAR_LIBRO)+20*sizeof(con.consulta[0]));
	   sprintf(con.consulta,ACTUALIZAR_LIBRO,con.ejemplares,con.isbn);
	   i = actualizar(con,dbc);
	   if(i == 0){
		free(con.consulta);
	   	printf("Error al actualizar el libro, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
           }
	   free(con.consulta);	

	   ret = odbc_disconnect(env, dbc);
           if (!SQL_SUCCEEDED(ret)) {
           return EXIT_FAILURE;}	
 	printf("Devolucion realizada con exito, gracias");
	
	break;
	case 2:/*SACAR PRESTADO UN LIBRO*/

	   ret = odbc_connect(&env, &dbc);
           if (!SQL_SUCCEEDED(ret)) {
           return EXIT_FAILURE;}
           
	    /*COMPROBAMOS QUE EL USUARIO EXISTE*/
	   con.consulta = (char *)malloc(strlen(EXISTE_USUARIO)+50*sizeof(con.consulta[0]));
	   sprintf(con.consulta,EXISTE_USUARIO,con.id);
	   i = comprobar(con,dbc);
	   if(i == 0){
		free(con.consulta);
	   	printf("Usuario incorrecto, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
           }
	   free(con.consulta);
	   
	   /*COMPROBAMOS QUE EL LIBRO EXISTE*/
	   con.consulta = (char *)malloc(strlen(EXISTE_LIBRO)+50*sizeof(con.consulta[0]));
	   sprintf(con.consulta,EXISTE_LIBRO,con.isbn);
	   i = comprobar(con,dbc);
	   if(i == 0){
		free(con.consulta);	   	
		printf("Libro incorrecto, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
	   }
	   free(con.consulta);
	   /*COMPROBAMOS QUE NO LO TIENE*/
	   con.consulta = (char *)malloc(strlen(COMPROBAR_POSESION)+50*sizeof(con.consulta[0]));
	   con.devuelto = 0;
	   sprintf(con.consulta,COMPROBAR_POSESION,con.id,con.isbn,con.devuelto);
	   i = comprobar(con,dbc);
	   if(i == 1){
	   	free(con.consulta);
	        printf("No puedes coger un libro que tienes, adios\n");
	        ret = odbc_disconnect(env, dbc);
           	if (!SQL_SUCCEEDED(ret)) {
           		return EXIT_FAILURE;}
           }
	   free(con.consulta);
	   /*CONSEGUIMOS INFORMACION DEL LIBRO*/
	   con.consulta = (char *)malloc(strlen(INFO_LIBRO)+50*sizeof(con.consulta[0]));
 	   sprintf(con.consulta,INFO_LIBRO,con.isbn);
	   i = info_libro(con,dbc);
	   con.ejemplares = i;	
	   
	   if(i == -1)
	   {
	        free(con.consulta);
	   	printf("Ha habido un error tecnico, adios\n");
	        ret = odbc_disconnect(env, dbc);
       	        if (!SQL_SUCCEEDED(ret)) 
           		return EXIT_FAILURE;
	   }
	   if(i == 0)
	   {
	        free(con.consulta);
	        printf("No hay ejemplares disponibles en este momento\n");
                ret = odbc_disconnect(env, dbc);
                /*free(con.consulta);*/
	        if (!SQL_SUCCEEDED(ret)) 
           		return EXIT_FAILURE;
           }
	   
	   /*EXTRAEMOS EL LIBRO*/
	   con.consulta = (char *)malloc(strlen(SACAR_LIBRO)+70*sizeof(con.consulta[0]));
 	   sprintf(con.consulta,SACAR_LIBRO,con.id,con.isbn,"2013-11-11",con.devuelto,-1);
	   i = crear_tupla(con,dbc);
	   if(i == 0)
	   {
	    printf("Error interno, adios\n");
	    ret = odbc_disconnect(env, dbc);
            if (!SQL_SUCCEEDED(ret)) {
          	return EXIT_FAILURE;}
           }
	   free(con.consulta);
	   /*ACTUALIZAMOS LA INFORMACION DEL LIBRO*/
	   con.ejemplares--;
	   con.consulta = (char *)malloc(strlen(ACTUALIZAR_LIBRO)+50*sizeof(con.consulta[0]));
 	   sprintf(con.consulta,ACTUALIZAR_LIBRO,con.ejemplares,con.isbn);
	   i = actualizar(con,dbc);
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
	printf("Extracion realizada con exito, gracias");	
	break;
	}
return 1;}
