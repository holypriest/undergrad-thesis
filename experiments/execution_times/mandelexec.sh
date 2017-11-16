#!/bin/zsh
if [ "$1" = "all" ]
then
    1="go"
    2="jlfun"
    3="jlimp"
    4="py"
    5="omp"
fi

argc="$#"
mkdir results

for i in {1..$argc}
do
    # Go section
    if [ "$1" = "go" ]
    then
        go build ../../code/go/mandel-gen-input.go
        go build ../../code/go/mandel-seq.go
        go build ../../code/go/mandel-par.go

        export NUM_THREADS=8

        export INPUTMAT_ROWS=3500; export INPUTMAT_COLS=2500
        for i in {1..102}; do time ./mandel-gen-input; done >>& "results/[mbp]gen-go-3500.txt"
        for i in {1..102}; do time ./mandel-seq; done >>& "results/[mbp]mandel-go-imp-seq-0-0-0-3500.txt"
        for i in {1..102}; do time ./mandel-par; done >>& "results/[mbp]mandel-go-imp-par-0-0-8x-3500.txt"

        export INPUTMAT_ROWS=7000; export INPUTMAT_COLS=5000
        for i in {1..102}; do time ./mandel-gen-input; done >>& "results/[mbp]gen-go-7000.txt"
        for i in {1..102}; do time ./mandel-seq; done >>& "results/[mbp]mandel-go-imp-seq-0-0-0-7000.txt"
        for i in {1..102}; do time ./mandel-par; done >>& "results/[mbp]mandel-go-imp-par-0-0-8x-7000.txt"

        export INPUTMAT_ROWS=14000; export INPUTMAT_COLS=10000
        for i in {1..102}; do time ./mandel-gen-input; done >>& "results/[mbp]gen-go-14000.txt"
        for i in {1..102}; do time ./mandel-seq; done >>& "results/[mbp]mandel-go-imp-seq-0-0-0-14000.txt"
        for i in {1..102}; do time ./mandel-par; done >>& "results/[mbp]mandel-go-imp-par-0-0-8x-14000.txt"

        export NUM_THREADS=4
        for i in {1..102}; do time ./mandel-par; done >>& "results/[mbp]mandel-go-imp-par-0-0-4x-14000.txt"

        export NUM_THREADS=2
        for i in {1..102}; do time ./mandel-par; done >>& "results/[mbp]mandel-go-imp-par-0-0-2x-14000.txt"

        rm mandel-*
    fi

    # JuliaFunctional section
    if [ "$1" = "jlfun" ]
    then
        export INPUTMAT_ROWS=3500; export INPUTMAT_COLS=2500
        for i in {1..102}; do time julia ../../code/julia/mandel-gen-input.jl; done >>& "results/[mbp]gen-jl-3500.txt"
        for i in {1..102}; do time julia ../../code/julia/juliaFunctional/mandel-seq.jl; done >>& "results/[mbp]mandel-jl-fun-seq-0-0-0-3500.txt"
        for i in {1..102}; do time julia -p 8 ../../code/julia/juliaFunctional/mandel-par.jl; done >>& "results/[mbp]mandel-jl-fun-par-0-0-8x-3500.txt"

        export INPUTMAT_ROWS=7000; export INPUTMAT_COLS=5000
        for i in {1..102}; do time julia ../../code/julia/mandel-gen-input.jl; done >>& "results/[mbp]gen-jl-7000.txt"
        for i in {1..102}; do time julia ../../code/julia/juliaFunctional/mandel-seq.jl; done >>& "results/[mbp]mandel-jl-fun-seq-0-0-0-7000.txt"
        for i in {1..102}; do time julia -p 8 ../../code/julia/juliaFunctional/mandel-par.jl; done >>& "results/[mbp]mandel-jl-fun-par-0-0-8x-7000.txt"

        export INPUTMAT_ROWS=14000; export INPUTMAT_COLS=10000
        for i in {1..102}; do time julia ../../code/julia/mandel-gen-input.jl; done >>& "results/[mbp]gen-jl-14000.txt"
        for i in {1..102}; do time julia ../../code/julia/juliaFunctional/mandel-seq.jl; done >>& "results/[mbp]mandel-jl-fun-seq-0-0-0-14000.txt"
        for i in {1..102}; do time julia -p 8 ../../code/julia/juliaFunctional/mandel-par.jl; done >>& "results/[mbp]mandel-jl-fun-par-0-0-8x-14000.txt"
        for i in {1..102}; do time julia -p 4 ../../code/julia/juliaFunctional/mandel-par.jl; done >>& "results/[mbp]mandel-jl-fun-par-0-0-4x-14000.txt"
        for i in {1..102}; do time julia -p 2 ../../code/julia/juliaFunctional/mandel-par.jl; done >>& "results/[mbp]mandel-jl-fun-par-0-0-2x-14000.txt"
    fi

    # JuliaImperative section
    if [ "$1" = "jlimp" ]
    then
        cd julia

        export INPUTMAT_ROWS=3500; export INPUTMAT_COLS=2500
        for i in {1..102}; do time julia mandel-gen-input.jl; done >>& "results/[mbp]gen-jl-3500.txt"

        cd julia/JuliaImperative
        for i in {1..102}; do time julia mandel-seq.jl; done >>& "results/[mbp]mandel-jl-imp-seq-0-0-0-3500.txt"
        for i in {1..102}; do time julia -p 8 mandel-par.jl; done >>& "results/[mbp]mandel-jl-imp-par-0-0-8x-3500.txt"

        cd ..
        export INPUTMAT_ROWS=7000; export INPUTMAT_COLS=5000
        for i in {1..102}; do time julia mandel-gen-input.jl; done >>& "results/[mbp]gen-jl-7000.txt"

        cd julia/JuliaImperative
        for i in {1..102}; do time julia mandel-seq.jl; done >>& "results/[mbp]mandel-jl-imp-seq-0-0-0-7000.txt"
        for i in {1..102}; do time julia -p 8 mandel-par.jl; done >>& "results/[mbp]mandel-jl-imp-par-0-0-8x-7000.txt"

        cd ..
        export INPUTMAT_ROWS=14000; export INPUTMAT_COLS=10000
        for i in {1..102}; do time julia mandel-gen-input.jl; done >>& "results/[mbp]gen-jl-14000.txt"

        cd julia/JuliaImperative
        for i in {1..102}; do time julia mandel-seq.jl; done >>& "results/[mbp]mandel-jl-imp-seq-0-0-0-14000.txt"
        for i in {1..102}; do time julia -p 8 mandel-par.jl; done >>& "results/[mbp]mandel-jl-imp-par-0-0-8x-14000.txt"
        for i in {1..102}; do time julia -p 4 mandel-par.jl; done >>& "results/[mbp]mandel-jl-imp-par-0-0-4x-14000.txt"
        for i in {1..102}; do time julia -p 2 mandel-par.jl; done >>& "results/[mbp]mandel-jl-imp-par-0-0-2x-14000.txt"

        cd ../..
    fi

    # Python section
    if [ "$1" = "py" ]
    then
        cd python

        export NUM_THREADS=8

        export INPUTMAT_ROWS=3500; export INPUTMAT_COLS=2500
        for i in {1..102}; do time python mandel-gen-input.py; done >>& "results/[mbp]gen-py-3500.txt"
        for i in {1..102}; do time python mandel-seq.py; done >>& "results/[mbp]mandel-py-fun-seq-0-0-0-3500.txt"
        for i in {1..102}; do time python mandel-par.py; done >>& "results/[mbp]mandel-py-fun-par-0-0-8x-3500.txt"

        export INPUTMAT_ROWS=7000; export INPUTMAT_COLS=5000
        for i in {1..102}; do time python mandel-gen-input.py; done >>& "results/[mbp]gen-py-7000.txt"
        for i in {1..102}; do time python mandel-seq.py; done >>& "results/[mbp]mandel-py-fun-seq-0-0-0-7000.txt"
        for i in {1..102}; do time python mandel-par.py; done >>& "results/[mbp]mandel-py-fun-par-0-0-8x-7000.txt"

        export INPUTMAT_ROWS=14000; export INPUTMAT_COLS=10000
        for i in {1..102}; do time python mandel-gen-input.py; done >>& "results/[mbp]gen-py-14000.txt"
        for i in {1..102}; do time python mandel-seq.py; done >>& "results/[mbp]mandel-py-fun-seq-0-0-0-14000.txt"
        for i in {1..102}; do time python mandel-par.py; done >>& "results/[mbp]mandel-py-fun-par-0-0-8x-14000.txt"

        export NUM_THREADS=4
        for i in {1..102}; do time python mandel-par.py; done >>& "results/[mbp]mandel-py-fun-par-0-0-4x-14000.txt"

        export NUM_THREADS=2
        for i in {1..102}; do time python mandel-par.py; done >>& "results/[mbp]mandel-py-fun-par-0-0-2x-14000.txt"

        cd ..
    fi

    # C/OpenMP section
    if [ "$1" = "omp" ]
    then
        cd c-openmp
        gcc-7 complex.c complex.h linspace.c linspace.h mandel-gen-input.c -o mandel-gen-input
        gcc-7 complex.c complex.h linspace.c linspace.h mandel-seq.c -o mandel-seq
        gcc-7 -fopenmp complex.c complex.h linspace.c linspace.h mandel-par-static.c -o mandel-par-static
        gcc-7 -fopenmp complex.c complex.h linspace.c linspace.h mandel-par-dynamic.c -o mandel-par-dynamic

        export SCHED_CHUNK_SIZE=1
        export NUM_THREADS=8

        export INPUTMAT_ROWS=3500; export INPUTMAT_COLS=2500
        for i in {1..102}; do time ./mandel-gen-input; done >>& "results/[mbp]gen-omp-3500.txt"
        for i in {1..102}; do time ./mandel-seq; done >>& "results/[mbp]mandel-omp-imp-seq-0-0-0-3500.txt"
        for i in {1..102}; do time ./mandel-par-static; done >>& "results/[mbp]mandel-omp-imp-par-static-0-8x-3500.txt"
        for i in {1..102}; do time ./mandel-par-dynamic; done >>& "results/[mbp]mandel-omp-imp-par-dynamic-c1-8x-3500.txt"

        export INPUTMAT_ROWS=7000; export INPUTMAT_COLS=5000
        for i in {1..102}; do time ./mandel-gen-input; done >>& "results/[mbp]gen-omp-7000.txt"
        for i in {1..102}; do time ./mandel-seq; done >>& "results/[mbp]mandel-omp-imp-seq-0-0-0-7000.txt"
        for i in {1..102}; do time ./mandel-par-static; done >>& "results/[mbp]mandel-omp-imp-par-static-0-8x-7000.txt"
        for i in {1..102}; do time ./mandel-par-dynamic; done >>& "results/[mbp]mandel-omp-imp-par-dynamic-c1-8x-7000.txt"

        export INPUTMAT_ROWS=14000; export INPUTMAT_COLS=10000
        for i in {1..102}; do time ./mandel-gen-input; done >>& "results/[mbp]gen-omp-14000.txt"
        for i in {1..102}; do time ./mandel-seq; done >>& "results/[mbp]mandel-omp-imp-seq-0-0-0-14000.txt"
        for i in {1..102}; do time ./mandel-par-static; done >>& "results/[mbp]mandel-omp-imp-par-static-0-8x-14000.txt"
        for i in {1..102}; do time ./mandel-par-dynamic; done >>& "results/[mbp]mandel-omp-imp-par-dynamic-c1-8x-14000.txt"

        export NUM_THREADS=4
        for i in {1..102}; do time ./mandel-par-dynamic; done >>& "results/[mbp]mandel-omp-imp-par-dynamic-c1-4x-14000.txt"

        export NUM_THREADS=2
        for i in {1..102}; do time ./mandel-par-dynamic; done >>& "results/[mbp]mandel-omp-imp-par-dynamic-c1-2x-14000.txt"

        export SCHED_CHUNK_SIZE=100
        for i in {1..102}; do time ./mandel-par-dynamic; done >>& "results/[mbp]mandel-omp-imp-par-dynamic-c100-8x-14000.txt"

        export SCHED_CHUNK_SIZE=1000
        for i in {1..102}; do time ./mandel-par-dynamic; done >>& "results/[mbp]mandel-omp-imp-par-dynamic-c1000-8x-14000.txt"

        export SCHED_CHUNK_SIZE=2000
        for i in {1..102}; do time ./mandel-par-dynamic; done >>& "results/[mbp]mandel-omp-imp-par-dynamic-c2000-8x-14000.txt"

        cd ..
    fi

    shift
done