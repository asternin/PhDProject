#CBS & Synchrony stats

library(tidyverse)
library(ggplot2)
library(plyr)

#ISCdata<-readr::read_csv("/Users/asternin/Documents/PhDProject/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults/Yeo_6.csv")
ISCdata<-readr::read_csv("/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/SynchronyStats/Data/OlderAdults/Yeo_6.csv", 
                         col_names=FALSE)
ISCdata<-rename(ISCdata,c("X1"="song_2", "X2"="song_3", "X3"="song_4", "X4"="song_5",
                    "X5"="song_6", "X6"="song_7", "X7"="song_9", "X8"="song_10"))


#CBSdata<-readr::read_csv("/Users/asternin/Documents/PhDProject/Music and Memory/BehaviouralResults/CBSScoresForISC.csv")
CBSdata<-readr::read_csv("/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/BehaviouralResults/OlderAdults/CBSScoresForISC.csv")

CBSdata<-CBSdata[-c(1,2),]
CBSdata<-CBSdata[,-1] #remove ID variable
CBSdata<-rename(CBSdata,c("Paired Associates"="PA", "Odd One Out (Max)"="OOO", "Polygons"="P", "Grammatical Reasoning"="GR",
                    "Double Trouble"="DT", "Monkey Ladder"="ML", "Digit Span"="DS", "Token Search"="TS",
                    "Feature Match"="FM", "Spatial Planning"="SP", "Spatial Span"="SS", "Rotations"="R"))

data<-cbind(ISCdata,CBSdata)
I1<-rowMeans(select(data, "song_6","song_7")) 
S1<-rowMeans(select(data, "song_2","song_3")) 
W1<-rowMeans(select(data, "song_4","song_5")) 

stim<-c("A1","I1")#
## REGRESSIONS PREDICTING CBS SCORES
regfuncage<-function(s,t){
  m0<-lm(t~age,data=data)
  mall<-lm(t~age+s,data=data)
  mbest<-step(m0,list(lower=m0,upper=mall),direction="both")
  summary(mbest)
}
regfuncmus<-function(s,t){
  m0<-lm(t~age+MusicExpRating+MusicYrsMax,data=data)
  mall<-lm(t~age+MusicExpRating+MusicYrsMax+s,data=data)
  mbest<-step(m0,list(lower=m0,upper=mall),direction="both")
  summary(mbest)
}

s<-S1
t<-data$ML
regfuncmus(s,t)
#

##REGRESSIONS Predicting ISC
#null model = age+MusicExpRating+MusicYrsMax+NumOfLang+Listens
s<-S2
m0song<-lm(s~age+MusicExpRating+MusicYrsMax+NumOfLang+Listens,data=data)
mallsong<-lm(s~DT+OOO+SP+GR+DS+TS+PA+SS+FM+R+P+ML+age+MusicExpRating+MusicYrsMax+NumOfLang+Listens,data=data)
mbestsong<-step(m0song,list(lower=m0song,upper=mallsong),direction="both")
summary(mbestsong)

#null model = age
s<-A1
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


