import numpy as np
import os

xmin, xmax = np.float64(-2.5), np.float64(1.0)
ymin, ymax = np.float64(-1.25), np.float64(1.25)
nx = int(os.environ.get('INPUTMAT_ROWS'))
ny = int(os.environ.get('INPUTMAT_COLS'))
maxiter = 100


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

def compute_all_y(x):
    return [complex(x, y) for y in Y]

Z = list(map(compute_all_y, X))
