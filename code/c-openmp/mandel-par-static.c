#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <omp.h>
#include "complex.h"
#include "linspace.h"

int rows;
int columns;

void setGlobalVariables() {
    rows = atoi(getenv("INPUTMAT_ROWS"));
    columns = atoi(getenv("INPUTMAT_COLS"));
}

void printMatrix(int **m) {
    for(int i = 0; i < rows; i++){
        for(int j = 0; j < columns; j++){
            printf("%d ", m[i][j]);
        }
        printf("\n");
    }
}

void matrixToCsv(int **m) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            if (j != columns-1) {
                printf("%d;", m[i][j]);
            } else {
                printf("%d\n", m[i][j]);
            }
        }
    }
}

int mandelbrotorbit(Complex c) {
    Complex z;
    z.re = 0.0; z.im = 0.0;
    z = addComplex(multComplex(z, z), c);
    for (int i = 1; i <= 100; i++) {
        if (absComplex(z) > 2) {
            return i - 1;
        }
        z = addComplex(multComplex(z, z), c);
    }
    return 100;
}

int** mandelbrot(Complex** inputmat) {
    int **outputmat = malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++){
        outputmat[i] = malloc(columns * sizeof(int));
    }

    #pragma omp parallel for
    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < columns; j++) {
            outputmat[i][j] = mandelbrotorbit(inputmat[i][j]);
        }
    }
    return outputmat;
}

int main(int argc, char *argv[]) {

    setGlobalVariables();
    Complex start, end;
    start.re = -2.5; start.im = -1.25;
    end.re = 1.0; end.im = 1.25;
    Complex **inputmat = clinspace(start, end, rows, columns);

    int **outputmat = mandelbrot(inputmat);
    if(argc != 0){
        for (int i = 0; i < argc; i++) {
            if (!strcmp(argv[i], "-export")) {
                matrixToCsv(outputmat);
            }
        }
    }
    return 0;
}
