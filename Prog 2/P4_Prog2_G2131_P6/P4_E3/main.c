/* 
 * Nombre: main.c
 * Author: Alejandro Bellogin y Fernando Diez
 *
 * Descripción: programa principal de P4_E3
 *
 * Fecha: 26-02-2014
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h> 

#include <sys/resource.h>

#include "order.h"

#define MAX_LINE 100

void printTreeStats(FILE*, BSTREE*);

int getNumberLines(FILE*);
void loadDataFromFile(FILE*, PHONE**);
void loadTreeFromData(PHONE*, BSTREE*, int);
void balance(PHONE*, BSTREE *, int, int);

int compare(const void* a, const void* b) {
    ELEBTREE *e1, *e2;
    e1 = (ELEBTREE *) a;
    e2 = (ELEBTREE *) b;
    return cmpEleBTree(e1, e2);
}

/*
 * 
 */
int main(int argc, char** argv) {

    FILE *pf_in, *pf_out;
    BSTREE t;
    time_t time;
    double time_in_secs;
    PHONE* data;
    int n;

    if (argc < 3) {
        fprintf(stderr, "Usage: %s fichero_entrada fichero_salida", argv[0]);
        return EXIT_FAILURE;
    }

    pf_in = fopen(argv[1], "r");
    pf_out = fopen(argv[2], "w");
    fprintf(pf_out, "Abriendo %s\n", argv[1]);
    /* Balancear el árbol usando un procesamiento adecuado de los datos */
    n = getNumberLines(pf_in);
    fclose(pf_in);

    fprintf(pf_out, "%d líneas leídas\n", n);

    data = (PHONE*) malloc(n * sizeof (PHONE));
    pf_in = fopen(argv[1], "r");
    loadDataFromFile(pf_in, &data);
    fclose(pf_in);

    fprintf(pf_out, "Memoria reservada\n");

    qsort(data, n, sizeof (PHONE), &compare);

    fprintf(pf_out, "Datos ordenados\n");

    time = clock();
    loadTreeFromData(data, &t, n);
    time = clock() - time;
    time_in_secs = ((float) time) / CLOCKS_PER_SEC;
    free(data);

    /* obtener estadísticas del árbol */
    fprintf(pf_out, "\nTiempo de creación del árbol: %ld ticks (%f segundos)\n", time, time_in_secs);
    printTreeStats(pf_out, &t);

    fclose(pf_out);
    destroyBSTree(&t);

    return (EXIT_SUCCESS);
}

void printTreeStats(FILE* pf, BSTREE* t) {
    PHONE* paux;
    ELEBTREE eaux;
    NODEBTREE* pnaux;
    int i;
    int lookup_prefixes[] = {-1, 100, 100, 50, 50};
    long lookup_numbers[] = {1, 10000000, 9000000, 4999999, 10000000};
    time_t time;
    double time_in_secs;

    fprintf(pf, "Número de nodos: %d\n", numNodesBSTree(t));
    fprintf(pf, "Profundidad: %d\n", depthBSTree(t));
    fprintf(pf, "\nPre-orden: ");
    preOrderToFile(pf, t);
    fprintf(pf, "\nIn-orden: ");
    inOrderToFile(pf, t);
    fprintf(pf, "\nPost-orden: ");
    postOrderToFile(pf, t);
    fprintf(pf, "\n\n");
    for (i = 0; i < 5; i++) {
        paux = iniPhone(lookup_prefixes[i], lookup_numbers[i]);
        copyEleBTree(&eaux, paux);
        time = clock();
        pnaux = lookBSTree(t, &eaux);
        time = clock() - time;
        time_in_secs = ((float) time) / CLOCKS_PER_SEC;
        fprintf(pf, "Buscando %d-%ld... ", lookup_prefixes[i], lookup_numbers[i]);
        if (pnaux == NULL) {
            fprintf(pf, "No encontrado!");
        } else {
            fprintf(pf, "Encontrado!");
        }
        fprintf(pf, " %ld ticks (%f segundos)\n", time, time_in_secs);
        freePhone(paux);
    }
}

int getNumberLines(FILE* pf) {
    char line[MAX_LINE];
    int n = 0;

    while (fgets(line, MAX_LINE, pf) != NULL) {
        n++;
    }
    return n;
}

void loadDataFromFile(FILE* pf, PHONE** pdata) {
    char line[MAX_LINE];
    int prefix;
    long number;
    PHONE* paux = *pdata;
    PHONE* p;

    while (fgets(line, MAX_LINE, pf) != NULL) {
        sscanf(line, "%d %ld", &prefix, &number);
        p = iniPhone(prefix, number);
        copyPhone(paux, p);
        paux++;
        freePhone(p);
    }
}

void loadTreeFromData(PHONE* data, BSTREE* t, int n) {
    createBSTree(t);
    balance(data, t, 0, n - 1);
}

void balance(PHONE* data, BSTREE *t, int first, int last) {
    int middle = (first + last) / 2;
    PHONE p;
    ELEBTREE e;

    if (first <= last) {
        p = *(&(data[0]) + middle);
        copyEleBTree(&e, &p);
        insertBSTree(t, &e);

        balance(data, t, first, middle - 1);
        balance(data, t, middle + 1, last);
    }
}
