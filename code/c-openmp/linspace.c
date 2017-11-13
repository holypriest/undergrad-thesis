#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "complex.h"
#include "linspace.h"

double* linspace(double start, double end, int n) {
    double *lnsp = malloc(n * sizeof(double));
    lnsp[0] = start;
    double distance = (end - start) / (double)(n-1);
    double next = start;
    for (int i = 1; i < n; i++) {
        next = next + distance;
        lnsp[i] = next;
    }
    return lnsp;
}

Complex** clinspace(Complex start, Complex end, int m, int n) {
    double *reLnsp = linspace(start.re, end.re, m);
    double *imLnsp = linspace(start.im, end.im, n);

    Complex** cmplxLnsp = malloc(m * sizeof(Complex*));
    for(int i = 0; i < m; i++) {
        cmplxLnsp[i] = malloc(n * sizeof(Complex));
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            Complex c;
            c.re = reLnsp[i];
            c.im = imLnsp[j];
            cmplxLnsp[i][j] = c;
        }
    }
    free(reLnsp);
    free(imLnsp);
    return cmplxLnsp;
}

void freeClinspace(Complex **clsp, int m) {
    for(int i = 0; i < m; i++) {
        free(clsp[i]);
    }
    free(clsp);
}
