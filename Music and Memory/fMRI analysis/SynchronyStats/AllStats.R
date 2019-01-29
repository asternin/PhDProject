library(tidyverse)
library(ggplot2)
library(plyr)

fullfiles<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
                  pattern="*.csv",full.names = TRUE)
files<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
                      pattern="*.csv",full.names = FALSE)

for(f in 1:length(fullfiles)){
  data<-read.csv(fullfiles[f], header=FALSE) #load data
  data<-rename(data,c("V1"="1_song1", "V2"="1_song2", "V3"="1_song3", "V4"="1_song4",
                      "V5"="1_song5", "V6"="1_song6", "V7"="1_song7", "V8"="1_song8",
                      "V9"="2_song1", "V10"="2_song2", "V11"="2_song3", "V12"="2_song4",
                      "V13"="2_song5", "V14"="2_song6", "V15"="2_song7", "V16"="2_song8"))
  
  #synchrony<-data %>% gather(songs, corr) #rearrange data
  
  ## Gather all session 1 data
  A1<-rowMeans(select(data, "1_song1","1_song8")) #ses 1 acapella data together
  I1<-rowMeans(select(data, "1_song6","1_song7")) #ses 1 instrumental data together
  S1<-rowMeans(select(data, "1_song2","1_song3")) #ses 1 spoken data together
  W1<-rowMeans(select(data, "1_song4",'1_song5'))  #ses 1 whole data together
  meansync1<-data.frame(A1,I1,S1,W1)
  meansync1<-meansync1 %>% gather(type, corr) #rearrange data
  
  ## Gather all session 2 data
  A2<-rowMeans(select(data, "2_song1","2_song8")) #ses 1 acapella data together
  I2<-rowMeans(select(data, "2_song6","2_song7")) #ses 1 instrumental data together
  S2<-rowMeans(select(data, "2_song2","2_song3")) #ses 1 spoken data together
  W2<-rowMeans(select(data, "2_song4",'2_song5'))  #ses 1 whole data together
  meansync2<-data.frame(A2,I2,S2,W2)
  meansync2<-meansync2 %>% gather(type, corr) #rearrange data
  
  meansync<-data.frame(A1,I1,S1,W1,A2,I2,S2,W2)
  meansync<-meansync %>% gather(type, corr) #rearrange data
  
  ## Gather all data across sessions together
  A<-rowMeans(select(data, "1_song1","1_song8","2_song1","2_song8"))
  I<-rowMeans(select(data, "1_song6","1_song7","2_song6","2_song7"))
  S<-rowMeans(select(data, "1_song2","1_song3","2_song2","2_song3"))
  W<-rowMeans(select(data, "1_song4","1_song5","2_song4","2_song5"))
  meansyncALL<-data.frame(A,I,S,W) 
  meansyncALL<-meansyncALL %>% gather(type, corr) #rearrange data
  
  sprintf("%s.txt",str_replace(files[f],".csv",""))
  
  sink(file=sprintf("%s.txt",str_replace(files[f],".csv","")))
  files[f]
  ## Stats

  print("Session 1 ANOVA")
  fit<-aov(corr~type,data=meansync1) 
  print(summary(fit))
  
  print("Session 2 ANOVA")
  fit<-aov(corr~type,data=meansync2) 
  print(summary(fit))
  
  print("Session 1&2 ANOVA")
  fit<-aov(corr~type,data=meansyncALL) 
  print(summary(fit))
  
  print(t.test(A,I))
  print(t.test(A,S))
  print(t.test(A,W))
  print(t.test(I,S))
  print(t.test(I,W))
  print(t.test(S,W))
  
  print(t.test(A1,I1))
  print(t.test(A1,S1))
  print(t.test(A1,W1))
  print(t.test(I1,S1))
  print(t.test(I1,W1))
  print(t.test(S1,W1))
  
  print(t.test(A2,I2))
  print(t.test(A2,S2))
  print(t.test(A2,W2))
  print(t.test(I2,S2))
  print(t.test(I2,W2))
  print(t.test(S2,W2))
  
  sink()
}
