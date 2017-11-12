import csv
from matplotlib import pyplot
import numpy as np
import os

xmin, xmax = np.float64(-2.5), np.float64(1.0)
ymin, ymax = np.float64(-1.25), np.float64(1.25)
nx = int(os.environ.get('INPUTMAT_ROWS'))
ny = int(os.environ.get('INPUTMAT_COLS'))
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


N = list(map(mandelbrot, X))

# Exports output matrix to a csv file
# with open('output-py-seq-14000-10000.csv', 'w') as f:
#     writer = csv.writer(f, delimiter=';')
#     writer.writerows(N)

# Exports output matrix to a graphic representation (png)
pyplot.imshow(N)
pyplot.savefig('mandel.png')
