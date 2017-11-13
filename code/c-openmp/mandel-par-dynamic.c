#include <stdlib.h>
#include <stdio.h>
#include <omp.h>
#include "complex.h"
#include "linspace.h"

int rows;
int columns;
int chunk_size;
int nthreads;

void setGlobalVariables() {
    rows = atoi(getenv("INPUTMAT_ROWS"));
    columns = atoi(getenv("INPUTMAT_COLS"));
    chunk_size = atoi(getenv("SCHED_CHUNK_SIZE"));
    nthreads = atoi(getenv("NUM_THREADS"));
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

    #pragma omp parallel for schedule(dynamic, chunk_size) num_threads(nthreads)
    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < columns; j++) {
            outputmat[i][j] = mandelbrotorbit(inputmat[i][j]);
        }
    }
    return outputmat;
}

int main() {

    setGlobalVariables();
    Complex start, end;
    start.re = -2.5; start.im = -1.25;
    end.re = 1.0; end.im = 1.25;
    Complex **inputmat = clinspace(start, end, rows, columns);

    mandelbrot(inputmat);
    return 0;
}