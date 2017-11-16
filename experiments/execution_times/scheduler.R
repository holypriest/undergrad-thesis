#!/usr/local/bin/Rscript

pdf('sched.pdf', width = 6.66, height = 4.42)

chunks = c(
    "sequencial",
    "estático",
    "din-1",
    "din-100",
    "din-1000",
    "din-2000"
)

means = c(
    164.66,
    60.269999999999996,
    24.28,
    23.860000000000003,
    40.39,
    60.78
)

stds = c(
    3.4401308114663314,
    0.6606814663663573,
    0.36124783736376886,
    0.5508175741568165,
    1.160387866189577,
    0.5408326913195984
)

barcenters = barplot(
    means,
    names.arg=chunks,
    ylim=c(0, 170),
    col="steelblue3",
    border="white",
    xlab="Tipo de escalonamento",
    ylab="Tempo de execução (s)"
)

arrows(
    x0=barcenters,
    y0=means-stds,
    y1=means+stds,
    code=3,
    angle=90,
    length=.05
)

invisible(dev.off())