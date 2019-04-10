#CBS & Synchrony stats

library(tidyverse)
library(ggplot2)
library(plyr)

#ISCdata<-readr::read_csv("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/old/FP.csv")
ISCdata<-readr::read_csv("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/old/Auditory.csv")
ISCdata<-ISCdata[-c(6),]
ISCdata<-rename(ISCdata,c("1_song1"="A1_1", "1_song2"="S1_1", "1_song3"="S2_1", "1_song4"="W1_1",
                    "1_song5"="W2_1", "1_song6"="I1_1", "1_song7"="I2_1", "1_song8"="A2_1",
                    "2_song1"="A1_2", "2_song2"="S1_2", "2_song3"="S2_2", "2_song4"="W1_2",
                    "2_song5"="W2_2", "2_song6"="I1_2", "2_song7"="I2_2", "2_song8"="A2_2"))


CBSdata<-readr::read_csv("/Users/asternin/Documents/PhDProject/Music and Memory/BehaviouralResults/CBSScoresForISC.csv")
CBSdata<-CBSdata[-c(6),]
CBSdata<-CBSdata[,-1] #remove ID variable
CBSdata<-rename(CBSdata,c("Paired Associates"="PA", "Odd One Out (Max)"="OOO", "Polygons"="P", "Grammatical Reasoning"="GR",
                    "Double Trouble"="DT", "Monkey Ladder"="ML", "Digit Span"="DS", "Token Search"="TS",
                    "Feature Match"="FM", "Spatial Planning"="SP", "Spatial Span"="SS", "Rotations"="R"))

data<-cbind(ISCdata,CBSdata)
A1<-rowMeans(select(data, "A1_1","A2_1")) #ses 1 acapella data together
I1<-rowMeans(select(data, "I1_1","I2_1")) #ses 1 instrumental data together
S1<-rowMeans(select(data, "S1_1","S2_1")) #ses 1 spoken data together
W1<-rowMeans(select(data, "W1_1",'W2_1')) #ses 1 whole data together
A2<-rowMeans(select(data, "A1_2","A2_2")) #ses 1 acapella data together
I2<-rowMeans(select(data, "I1_2","I2_2")) #ses 1 instrumental data together
S2<-rowMeans(select(data, "S1_2","S2_2")) #ses 1 spoken data together
W2<-rowMeans(select(data, "W1_2",'W2_2')) #ses 1 whole data together

##REGRESSIONS for CBS scores
#null model = age+MusicExpRating+MusicYrsMax+NumOfLang+Listens
s<-I1
m0song<-lm(s~age+MusicExpRating+MusicYrsMax+NumOfLang+Listens,data=data)
mallsong<-lm(s~DT+OOO+SP+GR+DS+TS+PA+SS+FM+R+P+ML+age+MusicExpRating+MusicYrsMax+NumOfLang+Listens,data=data)
mbestsong<-step(m0song,list(lower=m0song,upper=mallsong),direction="both")
summary(mbestsong)

#null model = age
s<-W2
m0song<-lm(s~age,data=data)
mallsong<-lm(s~DT+OOO+SP+GR+DS+TS+PA+SS+FM+R+P+ML+age,data=data)
mbestsong<-step(m0song,list(lower=m0song,upper=mallsong),direction="both")
summary(mbestsong)

#null model = 0
s<-W2
m0song<-lm(s~1,data=data)
mallsong<-lm(s~DT+OOO+SP+GR+DS+TS+PA+SS+FM+R+P+ML,data=data)
mbestsong<-step(m0song,list(lower=m0song,upper=mallsong),direction="both")
summary(mbestsong)


# fullfiles<-grep(list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
#                            pattern="*.csv", full.names = TRUE), pattern='pval',inv=T, value=T)
# #files<-list.files(path = "/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data",
# #                      pattern="*.csv",full.names = FALSE)
# files<-grep(list.files(path="/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data", 
#                        pattern="*.csv", full.names = FALSE), pattern='pval', inv=T, value=T)
# 
# for(f in 1:length(fullfiles)){
#   
# }