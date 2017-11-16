#!/usr/local/bin/Rscript

pdf('speedup.pdf', width = 6.66, height = 4.42)

procs = c(1, 2, 4, 8)

go.mean = c(
    1.0,
    2.016113495052106,
    4.017099982551038,
    5.499104263704765
)
go.sd = c(
    0.04852909260240542,
    0.07102654170053539,
    0.1489641307261648,
    0.19084536862648308
)

jlfun.mean = c(
    1.0,
    1.9829059829059827,
    3.4746543778801846,
    3.586206896551724
)
jlfun.sd = c(
    0.16740124816647448,
    0.23755351962337626,
    0.41416984516775884,
    0.4281905147828979
)

jlimp.mean = c(
    1.0,
    1.2094763092269327,
    1.3397790055248617,
    1.5594855305466238
)
jlimp.sd = c(
    0.024521350511040832,
    0.04237069245845915,
    0.05411611075858205,
    0.08373921227983037
)

py.mean = c(
    1.0,
    2.093349779550703,
    4.732142857142857,
    4.523363955994103
)
py.sd = c(
    0.05406680418043978,
    0.1010957959741525,
    0.22762847200224567,
    0.19500668527648699
)

omp.mean = c(
    1.0,
    2.1711497890295357,
    4.37809093326243,
    6.78171334431631
)
omp.sd = c(
    0.029546214319890966,
    0.046934766436090604,
    0.09189713446329201,
    0.17394222556969716
)

plot(
    procs,
    go.mean,
    xlab="Número de processadores",
    ylab="Speedup",
    col="dodgerblue4",
    type="l",
    ylim=c(0.9,7.2)
)
arrows(
    x0=procs,
    y0=go.mean-go.sd,
    y1=go.mean+go.sd,
    code=3,
    angle=90,
    length=.05,
    col="dodgerblue4"
)

lines(
    procs,
    jlfun.mean,
    xlab="Número de processadores",
    ylab="Speedup",
    col="brown3",
    ylim=c(0.9,5.9)
)
arrows(
    x0=procs,
    y0=jlfun.mean-jlfun.sd,
    y1=jlfun.mean+jlfun.sd,
    code=3,
    angle=90,
    length=.05,
    col="brown3"
)

lines(
    procs,
    jlimp.mean,
    xlab="Número de processadores",
    ylab="Speedup",
    col="darkgoldenrod3",
    ylim=c(0.9,5.9)
)
arrows(
    x0=procs,
    y0=jlimp.mean-jlimp.sd,
    y1=jlimp.mean+jlimp.sd,
    code=3,
    angle=90,
    length=.05,
    col="darkgoldenrod3"
)

lines(
    procs,
    py.mean,
    xlab="Número de processadores",
    ylab="Speedup",
    col="darkgreen",
    ylim=c(0.9,5.9)
)
arrows(
    x0=procs,
    y0=py.mean-py.sd,
    y1=py.mean+py.sd,
    code=3,
    angle=90,
    length=.05,
    col="darkgreen"
)

lines(
    procs,
    omp.mean,
    xlab="Número de processadores",
    ylab="Speedup",
    col="darkmagenta",
    ylim=c(0.9,5.9)
)
arrows(
    x0=procs,
    y0=omp.mean-omp.sd,
    y1=omp.mean+omp.sd,
    code=3,
    angle=90,
    length=.05,
    col="darkmagenta"
)

invisible(dev.off())