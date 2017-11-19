#!/usr/local/bin/Rscript

pdf('sched.pdf', width = 6.66, height = 4.42)

df = read.csv("scheduler.csv", sep=";")
library(ggplot2)
sched = ggplot(df, aes(x=as.factor(sched), y=mean)) +
  geom_bar(position=position_dodge(), stat="identity", colour='black') +
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.2,position=position_dodge(.9)) +
  scale_fill_brewer(palette = "Blues") +
  labs(x = "Tipo de escalonamento", y = "Tempo de execução (s)")
print(sched)

invisible(dev.off())