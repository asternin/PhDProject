library(tidyverse)
library(ggplot2)
library(plyr)

#fullfiles<-list.files(path = "Data", pattern="*.csv",full.names = TRUE)
#files<-list.files(path = "Data", pattern="*.csv",full.names = FALSE)

#fullfiles<-list.files(path = "Data", pattern="*_L_",full.names = TRUE)
#files<-list.files(path = "Data", pattern="_L_",full.names = FALSE)

#WINDOWS
#fullfiles<-grep(list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults",
#                  pattern="*.csv", full.names = TRUE), pattern='pval',inv=T, value=T)
#files<-grep(list.files(path="/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults", 
#                  pattern="*.csv", full.names = FALSE), pattern='pval', inv=T, value=T)
#LyrOrdata<-readr::read_csv("/Users/asternin/Documents/PhDProject/Music and Memory/BehaviouralResults/LyrOrScores.csv")
#MAC
fullfiles<-grep(list.files(path = "/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults",
                           pattern="*.csv", full.names = TRUE), pattern='pval',inv=T, value=T)
files<-grep(list.files(path="/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults", 
                       pattern="*.csv", full.names = FALSE), pattern='pval', inv=T, value=T)
LyrOrdata<-readr::read_csv("/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/BehaviouralResults/OlderAdults/LyrOrScores.csv")
LyrOrdata<-LyrOrdata[-c(1,2), ]

for(f in 1:length(fullfiles)){
  pval<-c()
  data<-read.csv(fullfiles[f], header=FALSE) #load data
  data<-rename(data,c("V1"="1_song2", "V2"="1_song3", "V3"="1_song4", "V4"="1_song5",
                      "V5"="1_song6", "V6"="1_song7", "V7"="1_song9", "V8"="1_song10"))
  #synchrony<-data %>% gather(songs, corr) #rearrange data
  
  ##### RUN ALL STATS #####
  ## Gather all data
  I1<-rowMeans(select(data, "1_song6","1_song7")) #ses 1 instrumental data together
  S1<-rowMeans(select(data, "1_song2","1_song3")) #ses 1 spoken data together
  W1<-rowMeans(select(data, "1_song4","1_song5"))  #ses 1 whole data together
  WF<-rowMeans(select(data, "1_song9")) #Beatles Hey Jude
  SF<-rowMeans(select(data, "1_song10")) #Twas the night before Christmas
  meansync1<-data.frame(I1,S1,W1)
  meansync1<-meansync1 %>% gather(type, corr) #rearrange data
  
  meansync<-data.frame(I1,S1,W1,SF,WF)
  meansync<-meansync %>% gather(type, corr) #rearrange data
  
  sprintf("%s.txt",str_replace(files[f],".csv",""))
  
  ##### START PRINTING RESULTS TO TEXT FILE #####
  #WINDOWS
  #sink(file=sprintf("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults/%s.txt",str_replace(files[f],".csv","")))
  #MAC
  sink(file=sprintf("/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults/%s.txt",str_replace(files[f],".csv","")))

  files[f]
  ## Stats
  
  print("ANOVA - Unfamiliar I S W")
  fit<-aov(corr~type,data=meansync1) 
  print(summary(fit))
  a=summary(fit)[[1]][["Pr(>F)"]][[1]]
  pval<-c(pval,a)
  
  print("ANOVA - I S W WF SF")
  fit<-aov(corr~type,data=meansync) 
  print(summary(fit))
  a=summary(fit)[[1]][["Pr(>F)"]][[1]]
  pval<-c(pval,a)
  
  p<-ggplot(meansync1) +
    aes(x=type,y=corr) +
    geom_boxplot(color=c("red","blue","green")) +
    geom_hline(yintercept=0,size=1) +
    ylim(-0.4,0.4)
  
  p<-ggplot(meansync) +
    aes(x=type,y=corr) +
    geom_boxplot(color=c("red","blue","blue","green","green")) +
    geom_hline(yintercept=0,size=1) +
    ylim(-0.4,0.4)
  #print(p)
  t<-print(t.test(I1,S1))
  pval<-c(pval,t$p.value)
  t<-print(t.test(I1,W1))
  pval<-c(pval,t$p.value)
  t<-print(t.test(S1,W1))
  pval<-c(pval,t$p.value)
  t<-print(t.test(S1,SF))
  pval<-c(pval,t$p.value)
  t<-print(t.test(W1,WF))
  pval<-c(pval,t$p.value)
  
  #ANOVA with LyrOr Covariate
  meansync$lyror<-LyrOrdata$LyrOr
  mod.full <- lm(corr~lyror + type, data=meansync)
  mod.rest <- lm(corr~lyror ,data=meansync)
  a2 <- anova(mod.full, mod.rest)
  print(a2)
  pval<-c(pval,a2$'Pr(>F)'[2])
  a3 <- anova(mod.full)
  print(a3)
  pval<-c(pval,a3$'Pr(>F)'[1])
  pval<-c(pval,a3$'Pr(>F)'[2])
  
  sink()
  #WINDOWS
  #write.csv(pval,file=sprintf("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults/%s_pval.csv",str_replace(files[f],".csv","")))
  #MAC
  write.csv(pval,file=sprintf("/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults/%s_pval.csv",str_replace(files[f],".csv","")))
}