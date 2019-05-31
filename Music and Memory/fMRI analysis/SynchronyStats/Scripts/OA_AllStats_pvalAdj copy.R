library(tidyverse)
library(ggplot2)
library(plyr)

#CORRECT P VALS FOR MULTIPLE COMPARISONS - FDR
#WINDOWS
#fullfiles<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
#                      pattern="*_pval.csv",full.names = TRUE)
#files<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
#                  pattern="*_pval.csv",full.names = FALSE)

#MAC
fullfiles<-grep(list.files(path = "/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults",
                           pattern="*_pval.csv", full.names = TRUE), pattern='_pval.csv',inv=F, value=T)
files<-grep(list.files(path="/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults", 
                       pattern="*_pval.csv", full.names = FALSE), pattern='pval', inv=F, value=T)

for(f in 1:length(fullfiles)){
  data<-read.csv(fullfiles[f], header=TRUE) #load data
  data<-rename(data,c("X"="test", "x"="pval"))
  p=data$pval
  p_adj<-p.adjust(p,method="fdr",n=length(p))
  #write.csv(p_adj,file=sprintf("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults/%s_adj.csv",str_replace(files[f],".csv","")))
  write.csv(p_adj,file=sprintf("/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults/%s_adj.csv",str_replace(files[f],".csv","")))
}

#EXTRACT SIG P VALS AFTER FDR CORRECTION
#WINDOWS
#fullfiles<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults",
#                  pattern="*_pval_adj.csv",full.names = TRUE)
#files<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults",
#                  pattern="*_pval_adj.csv",full.names = FALSE)
#MAC
fullfiles<-grep(list.files(path = "/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults",
                           pattern="*_pval_adj.csv", full.names = TRUE), pattern='pval',inv=F, value=T)
files<-grep(list.files(path="/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults", 
                       pattern="*_pval_adj.csv", full.names = FALSE), pattern='pval', inv=F, value=T)


#sink(file=sprintf("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/SummaryDocs/OA_AdjPVal_Summary.txt"))
sink(file=sprintf("/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/SummaryDocs/OA_AdjPVal_Summary.txt"))
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
