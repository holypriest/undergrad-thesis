package main

import "math"
import "math/cmplx"
import "os"
import "strconv"
import "sync"
import "runtime"

var rows, err1 = strconv.Atoi(os.Getenv("INPUTMAT_ROWS"))
var columns, err2 = strconv.Atoi(os.Getenv("INPUTMAT_COLS"))

func mandelbrotorbit(c complex128) int {
	z := complex(0, 0) + c
	for i := 1; i <= 100; i++ {
		if cmplx.Abs(z) > 2 {
			return i - 1
		}
		z = cmplx.Pow(z, 2) + c
	}
	return 100
}

func mandelbrot(inputmat [][]complex128) [][]int {
	runtime.GOMAXPROCS(8)
	var wg sync.WaitGroup
	wg.Add(rows)

	outputmat := make([][]int, rows)
	for i := range outputmat {
		outputmat[i] = make([]int, columns)
	}

	for i := 0; i < rows; i++ {
		go func(i int) {
			for j := 0; j < columns; j++ {
				outputmat[i][j] = mandelbrotorbit(inputmat[i][j])
			}
			wg.Done()
		}(i)
	}
	wg.Wait()
	return outputmat
}

func linspace(start float64, end float64, n int) []float64 {
	var linspace []float64
	linspace = append(linspace, start)
	distance := (end - start) / float64(n-1)
	next := start
	for math.Abs(next-end) > 0.000000000001 {
		next = next + distance
		linspace = append(linspace, next)
	}
	return linspace
}

func clinspace(start complex128, end complex128, m int, n int) [][]complex128 {
	realParts := linspace(real(start), real(end), m)
	imagLinspace := linspace(imag(start), imag(end), n)
	var cmplxParts []float64
	for im := range imagLinspace {
		cmplxParts = append(cmplxParts, imagLinspace[im])
	}

	var cmplxLinspace [][]complex128
	for r := range realParts {
		var cmplxRow []complex128
		for c := range cmplxParts {
			cmplxRow = append(cmplxRow, complex(realParts[r], cmplxParts[c]))
		}
		cmplxLinspace = append(cmplxLinspace, cmplxRow)
	}
	return cmplxLinspace
}

func main() {
	clinspace(-2.5-1.25i, 1.0+1.25i, rows, columns)
}
