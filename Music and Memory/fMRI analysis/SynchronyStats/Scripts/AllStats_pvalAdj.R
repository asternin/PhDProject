library(tidyverse)
library(ggplot2)
library(plyr)

#CORRECT P VALS FOR MULTIPLE COMPARISONS - FDR
fullfiles<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
                      pattern="*_pval.csv",full.names = TRUE)
files<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
                  pattern="*_pval.csv",full.names = FALSE)

for(f in 1:length(fullfiles)){
  data<-read.csv(fullfiles[f], header=TRUE) #load data
  data<-rename(data,c("X"="test", "x"="pval"))
  p=data$pval
  p_adj<-p.adjust(p,method="fdr",n=length(p))
  write.csv(p_adj,file=sprintf("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/%s_adj.csv",str_replace(files[f],".csv","")))
}

#EXTRACT SIG P VALS AFTER FDR CORRECTION
fullfiles<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
                      pattern="*_pval_adj.csv",full.names = TRUE)
files<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
                  pattern="*_pval_adj.csv",full.names = FALSE)

sink(file=sprintf("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/SummaryDocs/AdjPVal_Summary.txt"))
for(f in 1:length(fullfiles)){
  tests<-c()
  data<-read.csv(fullfiles[f], header=TRUE) #load data
  data<-rename(data,c("X"="test", "x"="pval"))
  for(p in 1:length(data$test)){
    if(data$pval[p] < 0.06)
      tests<-c(tests,data$test[p])
  }
  print(files[f])
  print(tests)
}
sink()
