#ifndef COMPLEX_H_
#define COMPLEX_H_

typedef struct Complex {
    double re;
    double im;
} Complex;

Complex addComplex(Complex a, Complex b);
Complex multComplex(Complex a, Complex b);
double absComplex(Complex c);
void printComplex(Complex a);

#endif // COMPLEX_H_
