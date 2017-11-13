#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "complex.h"

Complex addComplex(Complex a, Complex b) {
    struct Complex sum;
    sum.re = a.re + b.re;
    sum.im = a.im + b.im;
    return sum;
}

Complex multComplex(Complex a, Complex b) {
    struct Complex mult;
    mult.re = a.re * b.re - a.im * b.im;
    mult.im = a.re * b.im + a.im * b.re;
    return mult;
}

double absComplex(Complex c) {
    return sqrt(c.re * c.re + c.im * c.im);
}

void printComplex(Complex a) {
    if (a.im < 0) {
        printf("%f-%fi\n", a.re, fabs(a.im));
    } else {
        printf("%f+%fi\n", a.re, a.im);
    }
}
