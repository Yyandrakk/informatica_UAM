#include "odbc.h"

/* REPORT OF THE MOST RECENT ERROR USING HANDLE handle */
void odbc_extract_error(char *fn, SQLHANDLE handle, SQLSMALLINT type) {
    SQLINTEGER i = 0;
    SQLINTEGER native;
    SQLCHAR state[ 7 ];
    SQLCHAR text[256];
    SQLSMALLINT len;
    SQLRETURN ret;

    fprintf(stderr, "\nThe driver reported the following diagnostics whilst running %s\n\n", fn);

    do {
        ret = SQLGetDiagRec(type, handle, ++i, state, &native, text, sizeof(text), &len );
        if (SQL_SUCCEEDED(ret)) {
            printf("%s:%d:%d:%s\n", state, i, native, text);
        }
    } while( ret == SQL_SUCCESS );
}

/* STANDARD CONNECTION PROCEDURE */
int odbc_connect(SQLHENV* env, SQLHDBC* dbc) {
    SQLRETURN ret;

    /* Allocate an environment handle */
    ret = SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, env);
    if (!SQL_SUCCEEDED(ret)) {
        odbc_extract_error("", *env, SQL_HANDLE_ENV);
        return ret;
    }

    /* We want ODBC 3 support */
    ret = SQLSetEnvAttr(*env, SQL_ATTR_ODBC_VERSION, (void *) SQL_OV_ODBC3, 0);
    if (!SQL_SUCCEEDED(ret)) {
        odbc_extract_error("", *env, SQL_HANDLE_ENV);
        return ret;
    }

    /* Allocate a connection handle */
    ret = SQLAllocHandle(SQL_HANDLE_DBC, *env, dbc);
    if (!SQL_SUCCEEDED(ret)) {
        odbc_extract_error("", *dbc, SQL_HANDLE_DBC);
        return ret;
    }

    /* Connect to the DSN mydsn */
    /* You will need to change mydsn to one you have created and tested */
    ret = SQLDriverConnect(*dbc, NULL, (SQLCHAR*) CONNECTION_PARS, SQL_NTS, NULL, 0, NULL, SQL_DRIVER_COMPLETE);
    if (!SQL_SUCCEEDED(ret)) {
        odbc_extract_error("", *dbc, SQL_HANDLE_DBC);
        return ret;
    }

    return ret;
}

/* STANDARD DISCONNECTION PROCEDURE */
int odbc_disconnect(SQLHENV env, SQLHDBC dbc) {
    SQLRETURN ret;

    /* Disconnect from database */
    ret = SQLDisconnect(dbc);
    if (!SQL_SUCCEEDED(ret)) {
        odbc_extract_error("", dbc, SQL_HANDLE_DBC);
        return ret;
    }

    /* Free connection handle */
    ret = SQLFreeHandle(SQL_HANDLE_DBC, dbc);
    if (!SQL_SUCCEEDED(ret)) {
        odbc_extract_error("", dbc, SQL_HANDLE_DBC);
        return ret;
    }

    /* Free environment handle */
    ret = SQLFreeHandle(SQL_HANDLE_ENV, env);
    if (!SQL_SUCCEEDED(ret)) {
        odbc_extract_error("", env, SQL_HANDLE_ENV);
        return ret;
    }

    return ret;
}


int comprobar(CONSULTA con,SQLHDBC dbc){
	
	SQLHSTMT stmt;
	int c;
	
	SQLAllocHandle(SQL_HANDLE_STMT, dbc, &stmt);
	SQLExecDirect(stmt, (SQLCHAR*) con.consulta, SQL_NTS);
        c = SQL_SUCCEEDED(SQLFetch(stmt));
        SQLFreeHandle(SQL_HANDLE_STMT, stmt);

return c;
}

int info_libro(CONSULTA con,SQLHDBC dbc){

	SQLHSTMT stmt;
	SQLSMALLINT columnas;
	int numdis=0;	
	SQLRETURN ret;
	char buff[2000];

	SQLAllocHandle(SQL_HANDLE_STMT, dbc, &stmt);
	SQLExecDirect(stmt, (SQLCHAR*) con.consulta, SQL_NTS);
	
	SQLNumResultCols(stmt, &columnas);	
	if(columnas != 7){
	   SQLFreeHandle(SQL_HANDLE_STMT, stmt);
	   return -1;
	}
	
	if(!SQL_SUCCEEDED(ret = SQLFetch(stmt))) 
      		return -1;

	SQLGetData(stmt, 7, SQL_C_CHAR,buff, sizeof(buff), NULL);
	numdis = atoi(buff);	
	SQLFreeHandle(SQL_HANDLE_STMT, stmt);
	
	
return numdis;}

int crear_tupla(CONSULTA con,SQLHDBC dbc){

	SQLHSTMT stmt;
	SQLRETURN ret;
	
	SQLAllocHandle(SQL_HANDLE_STMT, dbc, &stmt);
	ret = SQLExecDirect(stmt, (SQLCHAR*) con.consulta, SQL_NTS);
	SQLFreeHandle(SQL_HANDLE_STMT, stmt);
	return (ret == SQL_SUCCESS || ret == SQL_SUCCESS_WITH_INFO);

return 1;
}

int actualizar(CONSULTA con,SQLHDBC dbc){

	SQLHSTMT stmt;
	SQLRETURN ret;
	

	SQLAllocHandle(SQL_HANDLE_STMT, dbc, &stmt);
	ret = SQLExecDirect(stmt, (SQLCHAR*) con.consulta, SQL_NTS);
	SQLFreeHandle(SQL_HANDLE_STMT, stmt);
	     	
	return (ret == SQL_SUCCESS || ret == SQL_SUCCESS_WITH_INFO);
}

int aleat_num(int inf, int sup) {
    int random;

    random = rand() % (sup - inf + 1) + inf;
    return random;
}

void imprime_resultadoargcusuario(){
	fprintf(stderr,"Error en los argumentos de entrada\n\n");
	fprintf(stderr,"usuario + <nombre> <sexo(H o M)> <edad>\n");
	fprintf(stderr,"usuario - <uid>\n");
}

void imprime_resultadoargcprestamo(){
	fprintf(stderr,"Error en los argumentos de entrada\n\n");
	fprintf(stderr,"prestamo + <uid> <isbn> <puntuacion>\n");
	fprintf(stderr,"prestamo - <uid> <isbn>\n");
}

int imprimir(CONSULTA con,SQLHDBC dbc){

	SQLHSTMT stmt;	
	SQLRETURN ret;
	SQLSMALLINT columnas;
	char buff[2000];
	int cont = 1;

	SQLAllocHandle(SQL_HANDLE_STMT, dbc, &stmt);
	SQLExecDirect(stmt, (SQLCHAR*) con.consulta, SQL_NTS);
	
	SQLNumResultCols(stmt, &columnas);	
	if(columnas != 1){
	   SQLFreeHandle(SQL_HANDLE_STMT, stmt);
	   return -1;
	}

	SQLBindCol(stmt, 1, SQL_C_CHAR, buff, sizeof(buff), NULL);
	
	while (SQL_SUCCEEDED(ret = SQLFetch(stmt))) {
            printf("%d = %s\n", cont,buff);
            cont++;}

	SQLFreeHandle(SQL_HANDLE_STMT, stmt);
return 1;}


