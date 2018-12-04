library(tidyverse)
library(ggplot2)

#data<-readr::read_csv('GroupAPref.csv') #load data
data<-readr::read_csv('GroupBPref.csv') #load data
data<-select(data, -ID) #remove ID variable
data<-select(data, -ses) #remove ses variable
pref<-data %>% gather(song, rating) #rearrange data
#pref<-rename(pref,ratings='col2:col9')
pref$song<-as.factor(pref$song)
ggplot(pref) +
  aes(x=song,y=rating)+
  geom_bar(stat="summary",fun.y="mean") +
  geom_jitter(alpha = 0.25)
  #geom_violin()

fit<-aov(rating~song,data=pref) #
summary(fit)
pairwise.t.test(pref$rating,pref$song,p.adj="bonf")

