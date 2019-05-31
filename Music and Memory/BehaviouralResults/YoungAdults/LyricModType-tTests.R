library(tidyverse)
library(ggplot2)
library(plyr)
#fname <-"C:/Users/asternin/My Documents/PhdProject.git/Music and Memory/behaviouralResults/LyricModType.csv"
fname<-"/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/BehaviouralResults/YoungAdults/LyricMod.csv"

data<-read.table(fname, sep=",",header=FALSE)
t.test(data$a.pre,data$a.post)
t.test(data$s.pre,data$s.post)
t.test(data$w.pre,data$w.post)

t.test(data$s.post,data$a.post)
t.test(data$a.post,data$w.post)
t.test(data$s.post,data$w.post)

fname <-"C:/Users/asternin/My Documents/PhdProject.git/Music and Memory/behaviouralResults/LyricMod_Type.csv"
data<-read.table(fname, sep=",",header=TRUE)
model=lm(reps ~ type*ses,data=data)
anova(model)
aov(model)



fname<-"/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/BehaviouralResults/YoungAdults/LyricMod.csv"
data<-read.table(fname, sep=",",header=FALSE)
data$V1<-as.numeric(data$V1)
data<-rename(data, c("V1"="session","V2"="scores"))
ggplot(data, aes(x=session, y=scores, group=session)) +
  geom_boxplot()
t.test(data$V1,data$V2)
