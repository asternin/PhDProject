library(tidyverse)
library(ggplot2)
library(plyr)
library(gridExtra)

#fullfiles<-list.files(path = "Data", pattern="*.csv",full.names = TRUE)
#files<-list.files(path = "Data", pattern="*.csv",full.names = FALSE)

#fullfiles<-list.files(path = "Data", pattern="*_L_",full.names = TRUE)
#files<-list.files(path = "Data", pattern="_L_",full.names = FALSE)

#WINDOWS
fullfiles<-grep(list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
                           pattern="*.csv", full.names = TRUE), pattern='pval',inv=T, value=T)
files<-grep(list.files(path="/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data", 
                       pattern="*.csv", full.names = FALSE), pattern='pval', inv=T, value=T)
LyrOrdata<-readr::read_csv("/Users/asternin/Documents/PhDProject/Music and Memory/BehaviouralResults/LyrOrScores.csv")


#MAC
fullfiles<-grep(list.files(path = "/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/YoungAdults",
                           pattern="*.csv", full.names = TRUE), pattern='pval',inv=T, value=T)
files<-grep(list.files(path="/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/YoungAdults", 
                       pattern="*.csv", full.names = FALSE), pattern='pval', inv=T, value=T)
LyrOrdata<-readr::read_csv("/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/BehaviouralResults/YoungAdults/LyrOrScores.csv")

for(f in 1:length(fullfiles)){
  #f<- 66 #frontal_L_4 IFG opercularis
  pval<-c()
  
  data<-read.csv(fullfiles[f], header=FALSE) #load data
  data<-rename(data,c("V1"="1_song1", "V2"="1_song2", "V3"="1_song3", "V4"="1_song4",
                      "V5"="1_song5", "V6"="1_song6", "V7"="1_song7", "V8"="1_song8",
                      "V9"="2_song1", "V10"="2_song2", "V11"="2_song3", "V12"="2_song4",
                      "V13"="2_song5", "V14"="2_song6", "V15"="2_song7", "V16"="2_song8"))
  GroupAdata<-data[c(1,3,5,7,10,12,13,14,16,18),c(1:16)]
  GroupBdata<-data[c(2,4,6,8,9,11,15,17,19),c(1:16)]
  #synchrony<-data %>% gather(songs, corr) #rearrange data
  
  ##### RUN ALL STATS #####
  ## Gather all session 1 data
  A1<-rowMeans(select(data, "1_song1","1_song8")) #ses 1 acapella data together
  I1<-rowMeans(select(data, "1_song6","1_song7")) #ses 1 instrumental data together
  S1<-rowMeans(select(data, "1_song2","1_song3")) #ses 1 spoken data together
  W1<-rowMeans(select(data, "1_song4",'1_song5'))  #ses 1 whole data together
  
  ## Gather all session 2 data
  A2<-rowMeans(select(data, "2_song1","2_song8")) #ses 1 acapella data together
  I2<-rowMeans(select(data, "2_song6","2_song7")) #ses 1 instrumental data together
  S2<-rowMeans(select(data, "2_song2","2_song3")) #ses 1 spoken data together
  W2<-rowMeans(select(data, "2_song4",'2_song5'))  #ses 1 whole data together
  
  ## Gather all data ignoring sessions
  A<-rowMeans(select(data, "1_song1","1_song8","2_song1","2_song8"))
  I<-rowMeans(select(data, "1_song6","1_song7","2_song6","2_song7"))
  S<-rowMeans(select(data, "1_song2","1_song3","2_song2","2_song3"))
  W<-rowMeans(select(data, "1_song4","1_song5","2_song4","2_song5"))
  
  ## OTHER STUFF
  l=76 #dim(meansync2)[1]
  ses<-c(rep(1,l),rep(2,l))
  stim<-c(rep(1,l/4),rep(2,l/4),rep(3,l/4),rep(4,l/4),rep(1,l/4),rep(2,l/4),rep(3,l/4),rep(4,l/4))
  
  ## Stats
  ##### START PRINTING RESULTS TO TEXT FILE #####
  sink(file=sprintf("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/%s_ANOVAs.txt",str_replace(files[f],".csv","")))
  files[f]
  
  #2x4 ANOVA
  print("ANOVA - 2(ses) x 4(stim)")
  meansync<-data.frame(A1,I1,S1,W1,A2,I2,S2,W2)
  meansync<-meansync %>% gather(type, corr) #rearrange data
  meansync$ses<-ses
  meansync$stim<-stim
  fit1<-aov(corr~stim + ses +stim:ses,data=meansync) 
  print(summary(fit1))
  a=summary(fit1)[[1]][["Pr(>F)"]][[1]]
  pval<-c(pval,a)
  # #plot
  # with(meansync, interaction.plot(ses,stim,corr,col=1:4,lty=1,main="main effect of session"))
  # 
  p<-ggplot(meansync) +
    aes(x=type,y=corr) +
    geom_boxplot(color=c("red","blue","green","black","red","blue","green","black")) +
    geom_hline(yintercept=0,size=1)+
    facet_wrap(~ses)
   plot(p)
  
  print("Session 1 ANOVA")
  meansync1<-data.frame(A1,I1,S1,W1)
  meansync1<-meansync1 %>% gather(type, corr) #rearrange data
  fit2<-aov(corr~type,data=meansync1) 
  print(summary(fit2))
  a=summary(fit2)[[1]][["Pr(>F)"]][[1]]
  pval<-c(pval,a)
  
  print("Session 2 ANOVA")
  meansync2<-data.frame(A2,I2,S2,W2)
  meansync2<-meansync2 %>% gather(type, corr) #rearrange data
  fit3<-aov(corr~type,data=meansync2) 
  print(summary(fit3))
  a=summary(fit3)[[1]][["Pr(>F)"]][[1]]
  pval<-c(pval,a)
  
  print("Session 1&2 ANOVA - TYPE 1 - DATA AVERAGED FIRST")
  meansyncALL<-data.frame(A,I,S,W) 
  meansyncALL<-meansyncALL %>% gather(type, corr) #rearrange data
  fit4<-aov(corr~type,data=meansyncALL) 
  print(summary(fit4))
  a=summary(fit4)[[1]][["Pr(>F)"]][[1]]
  pval<-c(pval,a)
  p1<-ggplot(meansyncALL) + aes(x=type,y=corr) + geom_boxplot() + 
     ylim(-0.3,0.3) + ggtitle('Data Averaged First')
  # 
  
  # print("Session 1&2 ANOVA - TYPE 2 - DATA NOT AVERAGED FIRST")
  # meansyncALL2<-data.frame(A1,I1,S1,W1,A2,I2,S2,W2) 
  # meansyncALL2<-meansyncALL2 %>% gather(type, corr) #rearrange data
  # meansyncALL2$stim<-stim
  # fit<-aov(corr~stim,data=meansyncALL2) 
  # print(summary(fit))
  # p2<-ggplot(meansyncALL2) + aes(x=as.factor(stim),y=corr) + geom_boxplot() + 
  #   ylim(-0.3,0.3) + ggtitle('Data NOT Averaged First')
  
  # plot means
  # grid.arrange(p1, p2, nrow = 1)
  
  # 2x4 ANOVA with LyrOr Covariate
  meansync$lyror<-LyrOrdata$LyrOr
  print("2x4 ANOVA with Lyric Orientation covariate")
  mod.full <- lm(corr~lyror + stim*ses, data=meansync)
  mod.rest <- lm(corr~lyror ,data=meansync)
  a2 <- anova(mod.full, mod.rest)
  print(a2)
  pval<-c(pval,a2$'Pr(>F)'[2])
  
  a3 <- anova(mod.full)
  print(a3)
  a=summary(a3)[1,5]
  pval<-c(pval,a)
  a=summary(a3)[2,5]
  pval<-c(pval,a)
  a=summary(a3)[3,5]
  pval<-c(pval,a)
  a=summary(a3)[4,5]
  pval<-c(pval,a)
  
  sink()
  write.csv(pval,file=sprintf("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/%s_pval_ANOVAs.csv",str_replace(files[f],".csv","")))
}
