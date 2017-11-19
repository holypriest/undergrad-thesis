package main

import "fmt"
import "flag"
import "math"
import "math/cmplx"
import "os"
import "strconv"

var rows, _ = strconv.Atoi(os.Getenv("INPUTMAT_ROWS"))
var columns, _ = strconv.Atoi(os.Getenv("INPUTMAT_COLS"))

func mandelbrotorbit(c complex128) int {
	z := cmplx.Pow(0+0i, 2) + c
	for i := 1; i <= 100; i++ {
		if cmplx.Abs(z) > 2 {
			return i - 1
		}
		z = cmplx.Pow(z, 2) + c
	}
	return 100
}

func mandelbrot(inputmat [][]complex128) [][]int {
	outputmat := make([][]int, rows)
	for i := range outputmat {
		outputmat[i] = make([]int, columns)
	}
	for i := 0; i < rows; i++ {
		for j := 0; j < columns; j++ {
			outputmat[i][j] = mandelbrotorbit(inputmat[i][j])
		}
	}
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

func matrix_to_csv(matrix [][]int) {
	filename := fmt.Sprintf("output-go-seq-%d.csv", rows)
	file, _ := os.Create(filename)
	for i := 0; i < rows; i++ {
		for j := 0; j < columns; j++ {
			if j != columns-1 {
				fmt.Fprintf(file, "%d;", matrix[i][j])
			} else {
				fmt.Fprintln(file, matrix[i][j])
			}
		}
	}
}

func main() {
	export_flag := flag.Bool("export", false, "Prints output matrix in CSV format")
	flag.Parse()
	outputmat := mandelbrot(clinspace(-2.5-1.25i, 1.0+1.25i, rows, columns))
	if *export_flag {
		matrix_to_csv(outputmat)
	}
}
