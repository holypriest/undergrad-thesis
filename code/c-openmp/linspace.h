#ifndef LINSPACE_H_
#define LINSPACE_H_

#include "complex.h"

double* linspace(double start, double end, int n);
Complex** clinspace(Complex start, Complex end, int m, int n);
void freeClinspace(Complex **clsp, int m);

#endif // LINSPACE_H_
