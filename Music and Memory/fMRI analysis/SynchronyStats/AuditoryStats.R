library(tidyverse)
library(ggplot2)

data<-readr::read_csv('Auditory.csv') #load data
data<-select(data, -ID) #remove ID variable
synchrony<-data %>% gather(songs, corr) #rearrange data
ggplot(synchrony) +
  aes(x=songs,y=corr, color=songs) +
  #geom_bar(stat="identity")
  #geom_jitter(alpha = 0.25)
  geom_violin()

A1<-select(data, "1_song1","1_song8") #ses 1 acapella data together
A1<-rowMeans(A1)
I1<-select(data, "1_song6","1_song7") #ses 1 instrumental data together
I1<-rowMeans(I1)
S1<-select(data, "1_song2","1_song3") #ses 1 spoken data together
S1<-rowMeans(S1)
W1<-select(data, "1_song4",'1_song5') #ses 1 whole data together
W1<-rowMeans(W1)
meansync1<-data.frame(A1,I1,S1,W1)
meansync1<-meansync1 %>% gather(type, corr) #rearrange data

A2<-select(data, "2_song1","2_song8") #ses 2 acapella data together
A2<-rowMeans(A2)
I2<-select(data, "2_song6","2_song7") #ses 2 instrumental data together
I2<-rowMeans(I2)
S2<-select(data, "2_song2","2_song3") #ses 2 spoken data together
S2<-rowMeans(S2)
W2<-select(data, "2_song4",'2_song5') #ses 2 whole data together
W2<-rowMeans(W2)
meansync2<-data.frame(A2,I2,S2,W2)
meansync2<-meansync2 %>% gather(type, corr) #rearrange data

meansync<-data.frame(A1,I1,S1,W1,A2,I2,S2,W2)
meansync<-meansync %>% gather(type, corr) #rearrange data

A<-select(data, "1_song1","1_song8","2_song1","2_song8") #acapella data together
A<-rowMeans(A)
I<-select(data, "1_song6","1_song7","2_song6","2_song7") #instrumental data together
I<-rowMeans(I)
S<-select(data, "1_song2","1_song3","2_song2","2_song3") #spoken data together
S<-rowMeans(S)
W<-select(data, "1_song4","1_song5","2_song4","2_song5") #whole data together
W<-rowMeans(W)
meansyncALL<-data.frame(A,I,S,W) 
meansyncALL<-meansyncALL %>% gather(type, corr) #rearrange data

ggplot(meansync) +
  aes(x=type,y=corr, color=type) +
  #geom_bar(stat="identity")
  #geom_jitter(alpha = 0.25)
  geom_violin()

ggplot(meansync1) +
  aes(x=type,y=corr, color=type) +
  #geom_bar(stat="identity")
  geom_violin() +
  geom_jitter() 

ggplot(meansync2) +
  aes(x=type,y=corr, color=type) +
  #geom_bar(stat="identity")
  #geom_jitter(alpha = 0.25)
  geom_violin()

ggplot(meansyncALL) +
  aes(x=type,y=corr, color=type) +
  #geom_bar(stat="identity")
  geom_violin()+
  geom_jitter()

t.test(A1,A2) # t=1.8682, p<0.001 A2<A1
t.test(I1,I2) #p=0.06
t.test(S1,S2) #t=3.17, p=0.003 S2<S1
t.test(W1,W2) #t=3.9112, p<0.001 W2<W1

fit<-aov(corr~type,data=meansync1) #sig effect of type in first session
summary(fit)

fit<-aov(corr~type,data=meansync2) #p=0.05 in second session
summary(fit)

fit<-aov(corr~type,data=meansyncALL) #sig effect of type when averaged across both sessions
summary(fit)

t.test(A,I) #SIG
t.test(A,S)
t.test(A,W)
t.test(I,S) #SIG
t.test(I,W)
t.test(S,W)

t.test(A1,I1) #SIG
t.test(A1,S1)
t.test(A1,W1)
t.test(I1,S1) #SIG
t.test(I1,W1)
t.test(S1,W1)

##################### UNFAMILIAR VS FAMILIAR#####################
##########GROUP A ##########
data<-readr::read_csv('Auditory.csv') #load data
GA<-list("P101","P103","P105","P107","P111","P113","P115","P117","P119","P123","P125")
GroupA<-data[data$ID %in% GA, ]

FA1<-select(GroupA, "1_song8") #ses 1 acapella data together
FA1<-rowMeans(FA1)
FI1<-select(GroupA, '1_song7') #ses 1 instrumental data together
FI1<-rowMeans(FI1)
FS1<-select(GroupA, "1_song2") #ses 1 spoken data together
FS1<-rowMeans(FS1)
FW1<-select(GroupA, "1_song4") #ses 1 whole data together
FW1<-rowMeans(FW1)
Fmeansync1<-data.frame(FA1,FI1,FS1,FW1)
Fmeansync1<-meansync1 %>% gather(type, corr) #rearrange data

FA2<-select(GroupA, "2_song8") #ses 2 acapella data together
FA2<-rowMeans(FA2)
FI2<-select(GroupA, '2_song7') #ses 2 instrumental data together
FI2<-rowMeans(FI2)
FS2<-select(GroupA, "2_song2") #ses 2 spoken data together
FS2<-rowMeans(FS2)
FW2<-select(GroupA, "2_song4") #ses 2 whole data together
FW2<-rowMeans(FW2)
Fmeansync2<-data.frame(FA2,FI2,FS2,FW2)
Fmeansync2<-meansync2 %>% gather(type, corr) #rearrange data

Fmeansync<-data.frame(FA1,FI1,FS1,FW1,FA2,FI2,FS2,FW2) 
Fmeansync<-Fmeansync %>% gather(type, corr) #rearrange data

UA1<-select(GroupA, "1_song1") #ses 1 acapella data together
UA1<-rowMeans(UA1)
UI1<-select(GroupA, '1_song6') #ses 1 instrumental data together
UI1<-rowMeans(UI1)
US1<-select(GroupA, "1_song3") #ses 1 spoken data together
US1<-rowMeans(US1)
UW1<-select(GroupA, "1_song5") #ses 1 whole data together
UW1<-rowMeans(UW1)
Umeansync1<-data.frame(UA1,UI1,US1,UW1)
Umeansync1<-meansync1 %>% gather(type, corr) #rearrange data

UA2<-select(GroupA, "2_song1") #ses 2 acapella data together
UA2<-rowMeans(UA2)
UI2<-select(GroupA, '2_song6') #ses 2 instrumental data together
UI2<-rowMeans(UI2)
US2<-select(GroupA, "2_song3") #ses 2 spoken data together
US2<-rowMeans(US2)
UW2<-select(GroupA, "2_song5") #ses 2 whole data together
UW2<-rowMeans(UW2)
Umeansync2<-data.frame(UA2,UI2,US2,UW2)
Umeansync2<-meansync2 %>% gather(type, corr) #rearrange data

Fmeansync<-data.frame(FA1,FI1,FS1,FW1,FA2,FI2,FS2,FW2) 
Fmeansync<-Fmeansync %>% gather(type, corr) #rearrange data
Umeansync<-data.frame(UA1,UI1,US1,UW1,UA2,UI2,US2,UW2) 
Umeansync<-Umeansync %>% gather(type, corr) #rearrange data

t.test(FA2,UA2) #not sig
t.test(FI2,UI2) #not sig
t.test(FS2,US2) #not sig
t.test(FW2,UW2) #not sig

########## GROUP B ##########
data<-readr::read_csv('Auditory.csv') #load data
GB<-list("P102","P104","P106","P108","P112","P114","P116","P118","P120","P122","P124")
GroupB<-data[data$ID %in% GB, ]

FA1<-select(GroupB, "1_song1") #ses 1 acapella data together
FA1<-rowMeans(FA1)
FI1<-select(GroupB, '1_song6') #ses 1 instrumental data together
FI1<-rowMeans(FI1)
FS1<-select(GroupB, "1_song3") #ses 1 spoken data together
FS1<-rowMeans(FS1)
FW1<-select(GroupB, "1_song5") #ses 1 whole data together
FW1<-rowMeans(FW1)
Fmeansync1<-data.frame(FA1,FI1,FS1,FW1)
Fmeansync1<-meansync1 %>% gather(type, corr) #rearrange data

FA2<-select(GroupB, "2_song1") #ses 2 acapella data together
FA2<-rowMeans(FA2)
FI2<-select(GroupB, '2_song6') #ses 2 instrumental data together
FI2<-rowMeans(FI2)
FS2<-select(GroupB, "2_song3") #ses 2 spoken data together
FS2<-rowMeans(FS2)
FW2<-select(GroupB, "2_song5") #ses 2 whole data together
FW2<-rowMeans(FW2)
Fmeansync2<-data.frame(FA2,FI2,FS2,FW2)
Fmeansync2<-meansync2 %>% gather(type, corr) #rearrange data

Fmeansync<-data.frame(FA1,FI1,FS1,FW1,FA2,FI2,FS2,FW2) 
Fmeansync<-Fmeansync %>% gather(type, corr) #rearrange data

UA1<-select(GroupB, "1_song8") #ses 1 acapella data together
UA1<-rowMeans(UA1)
UI1<-select(GroupB, '1_song7') #ses 1 instrumental data together
UI1<-rowMeans(UI1)
US1<-select(GroupB, "1_song4") #ses 1 spoken data together
US1<-rowMeans(US1)
UW1<-select(GroupB, "1_song2") #ses 1 whole data together
UW1<-rowMeans(UW1)
Umeansync1<-data.frame(UA1,UI1,US1,UW1)
Umeansync1<-meansync1 %>% gather(type, corr) #rearrange data

UA2<-select(GroupB, "2_song8") #ses 2 acapella data together
UA2<-rowMeans(UA2)
UI2<-select(GroupB, '2_song7') #ses 2 instrumental data together
UI2<-rowMeans(UI2)
US2<-select(GroupB, "2_song4") #ses 2 spoken data together
US2<-rowMeans(US2)
UW2<-select(GroupB, "2_song2") #ses 2 whole data together
UW2<-rowMeans(UW2)
Umeansync2<-data.frame(UA2,UI2,US2,UW2)
Umeansync2<-meansync2 %>% gather(type, corr) #rearrange data

Fmeansync<-data.frame(FA1,FI1,FS1,FW1,FA2,FI2,FS2,FW2) 
Fmeansync<-Fmeansync %>% gather(type, corr) #rearrange data
Umeansync<-data.frame(UA1,UI1,US1,UW1,UA2,UI2,US2,UW2) 
Umeansync<-Umeansync %>% gather(type, corr) #rearrange data

t.test(FA2,UA2) #not sig
t.test(FI2,UI2) #not sig
t.test(FS2,US2) #not sig
t.test(FW2,UW2) #not sig
