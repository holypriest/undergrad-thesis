import csv
from matplotlib import pyplot
from multiprocessing import Pool
import numpy as np
import os
import sys

xmin, xmax = np.float64(-2.5), np.float64(1.0)
ymin, ymax = np.float64(-1.25), np.float64(1.25)
nx = int(os.environ.get('INPUTMAT_ROWS'))
ny = int(os.environ.get('INPUTMAT_COLS'))
procs = int(os.environ.get('NUM_THREADS'))
maxiter = 100


def mandelbrotorbit(c):
    z = complex(0, 0) + c
    for n in range(maxiter):
        if abs(z) > 2:
            return n
        z = z*z + c
    return maxiter


def linspace(start, end, n):
    lspace = [start]
    distance = (end - start) / np.float64(n - 1)
    next = start
    while np.abs(next - end) > 0.000000000001:
        next += distance
        lspace.append(next)
    return lspace


X = linspace(xmin, xmax, nx)
Y = linspace(ymin, ymax, ny)


def mandelbrot(x):
    Z = [complex(x, y) for y in Y]
    return list(map(mandelbrotorbit, Z))


p = Pool(procs)
N = p.map(mandelbrot, X)

def matrix_to_csv(m):
    filename = 'output-py-par-{}.csv'.format(nx)
    with open(filename, 'w') as f:
        writer = csv.writer(f, delimiter=';', lineterminator='\n')
        writer.writerows(N)

if '-export' in sys.argv:
    matrix_to_csv(N)

if '-fractal' in sys.argv:
    pyplot.imshow(N)
    pyplot.savefig('mandel.png')
