#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>
#include "odbc.h"


int main(int argc, char *argv[]){

    SQLHENV env;
    SQLHDBC dbc;
    CONSULTA con;
    SQLRETURN ret;
    int i = 0, opcion = 0;

    srand(time(NULL));

    if(argc!=5 && argc!=3){
	imprime_resultadoargcusuario();
    return;}

   if(argc== 5){
	for(i = 1; i < argc ; i++) {
    	   if (strcmp(argv[i], "+") == 0) {
     		 opcion = 1;i++;
    	   strcpy(con.nombre,argv[i]);
	   i++;
	   strcpy(con.sexo,argv[i]);
	   i++;
	   con.edad =atoi(argv[i]);
      	   }
       }
  }else if(argc == 3){
	for(i = 1; i < argc ; i++) {
	      if (strcmp(argv[i], "-") == 0) {
     		 opcion = 2;i++;
    	         con.id = atoi(argv[i]);
              }
        }
  } 
    switch(opcion){
        case 1:
  
	  
	  con.activado = 1;
          ret = odbc_connect(&env, &dbc);
          
	  do{
	  con.id=aleat_num(1000,99999);
	  con.consulta = (char *)malloc(strlen(EXISTE_USUARIO)+50*sizeof(con.consulta[0]));
	  sprintf(con.consulta,EXISTE_USUARIO,con.id); 
	  i = comprobar(con,dbc); 
	  }while(i == 1);
	  free(con.consulta);

	  con.consulta = (char *)malloc(strlen(CREAR_USUARIO)+50*sizeof(con.consulta[0]));
	  sprintf(con.consulta,CREAR_USUARIO,con.id,con.nombre,con.sexo,con.edad,con.activado);
	  i = crear_tupla(con,dbc);	  
	  if(i == 0){
	    free(con.consulta);
	    printf("Error interno, adios\n");
	    ret = odbc_disconnect(env, dbc);}
            
	   free(con.consulta);
	   printf("Usuario creado con exito, su uid es: %d\n",con.id);
	  ret = odbc_disconnect(env, dbc);
          

        break;
        case 2:
	 
	  ret = odbc_connect(&env, &dbc);
           
 	  con.consulta = (char *)malloc(strlen(EXISTE_USUARIO)+50*sizeof(con.consulta[0]));
	  sprintf(con.consulta,EXISTE_USUARIO,con.id);
	  i = comprobar(con,dbc); 
	  if(i == 0){ 
	    free(con.consulta);
	    printf("Usuario incorrecto, adios\n");
	    ret = odbc_disconnect(env, dbc);
          }
	  free(con.consulta);
	  
	  con.activado = 0;
	  con.consulta = (char *)malloc(strlen(ELIMINAR_USUARIO)+50*sizeof(con.consulta[0]));
	  sprintf(con.consulta,ELIMINAR_USUARIO,con.activado,con.id);
	  i = actualizar(con,dbc);  
	   if(i == 0){ 
	    free(con.consulta);
	    printf("Error interno, adios\n");
	    ret = odbc_disconnect(env, dbc);
           }
	  free(con.consulta);	  
	  printf("Operación realizada con exito\n");
	  ret = odbc_disconnect(env, dbc);
        break;
	
}
return;}





