#!/bin/zsh

source /usr/local/bin/virtualenvwrapper.sh

echo "Compiling..."

cd ../../code/go
go build mandel-seq.go
go build mandel-par.go

cd ../c-openmp
gcc-7 complex.c complex.h linspace.c linspace.h mandel-seq.c -o mandel-seq.out
gcc-7 -fopenmp complex.c complex.h linspace.c linspace.h mandel-par-static.c -o mandel-par.out

echo "Exporting..."

cd ../../experiments/output_diff

rows[1]=3500; cols[1]=2500
rows[2]=7000; cols[2]=5000
rows[3]=14000; cols[3]=10000

export NUM_THREADS=8

for i in {1..3}
do
    export INPUTMAT_ROWS=$rows[i]
    export INPUTMAT_COLS=$cols[i]

    ../../code/go/mandel-seq -export
    ../../code/go/mandel-par -export

    julia ../../code/julia/juliaFunctional/mandel-seq.jl -export
    julia ../../code/julia/juliaFunctional/mandel-par.jl -export
    julia ../../code/julia/juliaImperative/mandel-seq.jl -export
    julia ../../code/julia/juliaImperative/mandel-par.jl -export

    workon tfs
    python ../../code/python/mandel-seq.py -export
    python ../../code/python/mandel-par.py -export

    ../../code/c-openmp/mandel-seq.out -export
    ../../code/c-openmp/mandel-par.out -export
done

go_seq_3500='output-go-seq-3500.csv'
go_seq_7000='output-go-seq-7000.csv'
go_seq_14000='output-go-seq-14000.csv'
go_par_3500='output-go-par-3500.csv'
go_par_7000='output-go-par-7000.csv'
go_par_14000='output-go-par-14000.csv'

jl_fun_seq_3500='output-jl-fun-seq-3500.csv'
jl_fun_seq_7000='output-jl-fun-seq-7000.csv'
jl_fun_seq_14000='output-jl-fun-seq-14000.csv'
jl_fun_par_3500='output-jl-fun-par-3500.csv'
jl_fun_par_7000='output-jl-fun-par-7000.csv'
jl_fun_par_14000='output-jl-fun-par-14000.csv'

jl_imp_seq_3500='output-jl-imp-seq-3500.csv'
jl_imp_seq_7000='output-jl-imp-seq-7000.csv'
jl_imp_seq_14000='output-jl-imp-seq-14000.csv'
jl_imp_par_3500='output-jl-imp-par-3500.csv'
jl_imp_par_7000='output-jl-imp-par-7000.csv'
jl_imp_par_14000='output-jl-imp-par-14000.csv'

py_seq_3500='output-py-seq-3500.csv'
py_seq_7000='output-py-seq-7000.csv'
py_seq_14000='output-py-seq-14000.csv'
py_par_3500='output-py-par-3500.csv'
py_par_7000='output-py-par-7000.csv'
py_par_14000='output-py-par-14000.csv'

omp_seq_3500='output-omp-seq-3500.csv'
omp_seq_7000='output-omp-seq-7000.csv'
omp_seq_14000='output-omp-seq-14000.csv'
omp_par_3500='output-omp-par-3500.csv'
omp_par_7000='output-omp-par-7000.csv'
omp_par_14000='output-omp-par-14000.csv'

echo "(diff)ing filesize 3500"
diff $jl_imp_seq_3500 $jl_imp_par_3500
diff $jl_imp_par_3500 $jl_fun_seq_3500
diff $jl_fun_seq_3500 $jl_fun_par_3500
diff $jl_fun_par_3500 $go_seq_3500
diff $go_seq_3500 $go_par_3500
diff $go_par_3500 $py_seq_3500
diff $py_seq_3500 $py_par_3500
diff $py_par_3500 $omp_seq_3500
diff $omp_seq_3500 $omp_par_3500

echo "(diff)ing filesize 7000"
diff $jl_imp_seq_7000 $jl_imp_par_7000
diff $jl_imp_par_7000 $jl_fun_seq_7000
diff $jl_fun_seq_7000 $jl_fun_par_7000
diff $jl_fun_par_7000 $go_seq_7000
diff $go_seq_7000 $go_par_7000
diff $go_par_7000 $py_seq_7000
diff $py_seq_7000 $py_par_7000
diff $py_par_7000 $omp_seq_7000
diff $omp_seq_7000 $omp_par_7000

echo "(diff)ing filesize 14000"
diff $jl_imp_seq_14000 $jl_imp_par_14000
diff $jl_imp_par_14000 $jl_fun_seq_14000
diff $jl_fun_seq_14000 $jl_fun_par_14000
diff $jl_fun_par_14000 $go_seq_14000
diff $go_seq_14000 $go_par_14000
diff $go_par_14000 $py_seq_14000
diff $py_seq_14000 $py_par_14000
diff $py_par_14000 $omp_seq_14000
diff $omp_seq_14000 $omp_par_14000
