/* 
 * File:   main.c
 * Author: oscar
 *
 * Created on 14 de octubre de 2014, 10:05
 */

#include "tablashash.h"

/*
 * 
 */
int main(int argc, char** argv) {

    TablaHash global = NULL, local = NULL;
    FILE *entrada, *salida;
    int  num = 0, numarg = 0;
    BOOL lopen = FALSE;
    char cadent[TAMANO];
    if (argc != 3)
        return ERROR;
    if ((global = crearTablaHash()) == NULL)
        return ERROR;

    if ((entrada = fopen(argv[1], "r")) == NULL) {
        destruirTablaHash(global);
        return ERROR;
    }
    if ((salida = fopen(argv[2], "w")) == NULL) {
        fclose(entrada);
        destruirTablaHash(global);
        return ERROR;
    }
    while (feof(entrada) == 0) {
	numarg = fscanf(entrada, "%s %d", cadent, &num);	
	        
        if (lopen == FALSE) {
            if (numarg == 1) {
                if (!MiembroHash(cadent, global))
                    fprintf(salida, "%s   -1\n", cadent);
                else {
                    fprintf(salida, "%s    %d\n", cadent, returnValorHash(cadent, global));
                }
            } else if (numarg == 2) {
                if (num >= 0) {
                    if (!MiembroHash(cadent, global)) {
                        InsertarHash(cadent, num, global);
                        fprintf(salida, "%s\n", cadent);
                    } else {
                        fprintf(salida, "-1   %s\n", cadent);
                    }

                } else {
                    if (!MiembroHash(cadent, global)) {
                        InsertarHash(cadent, num, global);
                        if ((local = crearTablaHash()) == NULL) {
                            fclose(salida);
                            fclose(entrada);
                            destruirTablaHash(global);
                            printf("ERROR CREAR AMBITO LOCAL");
                            return ERROR;
                        }

                        InsertarHash(cadent, num, local);
                        fprintf(salida, "%s\n", cadent);
                        lopen = TRUE;
                    } else
                        fprintf(salida, "-1   %s\n", cadent);
                }
            }
        } else {
            if (numarg == 1) {
                if (!MiembroHash(cadent, local)) {
                    if (!MiembroHash(cadent, global))
                        fprintf(salida, "%s   -1\n", cadent);
                    else {
                        fprintf(salida, "%s    %d\n", cadent, returnValorHash(cadent, global));
                    }
                }
                else {
                    fprintf(salida, "%s    %d\n", cadent, returnValorHash(cadent, local));
                }
            } else if (numarg == 2) {
                if (num >= 0) {
                    if (!MiembroHash(cadent, local)) {
                        InsertarHash(cadent, num, local);
                        fprintf(salida, "%s\n", cadent);
                    } else {
                        fprintf(salida, "-1   %s\n", cadent);
                    }
                } else {
                    destruirTablaHash(local);
                    fprintf(salida, "%s\n", cadent);
                    lopen = FALSE;
                }
            } else {
                fclose(salida);
                fclose(entrada);
                destruirTablaHash(global);
                printf("ERROR EN LA LECTURA DE PARAMETROS2");
                return ERROR;
            }



        }
    }
    fclose(salida);
    fclose(entrada);
    destruirTablaHash(global);


    return (EXIT_SUCCESS);
}

