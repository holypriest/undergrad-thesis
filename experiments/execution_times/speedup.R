#!/usr/local/bin/Rscript

pdf('speedup.pdf', width = 8.84, height = 4.42)

df = read.csv("speedup.csv", sep=";")
library(ggplot2)
ggplot(df, aes(x=as.factor(procs), y=mean, fill=lang)) +
    geom_bar(position=position_dodge(), stat="identity", colour='black') +
    geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.2,position=position_dodge(.9)) +
    scale_fill_brewer(palette = "Blues") +
    labs(x = "Número de processadores", y = "Speedup", fill="Linguagem")

invisible(dev.off())
