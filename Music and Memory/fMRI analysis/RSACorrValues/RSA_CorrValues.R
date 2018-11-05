library(ggplot2)
library(plyr)
fname<-"RSA_CorrValues.csv"
data<-read.table(fname, sep=",",header=FALSE)

mydata<-split(data,data$V3);

levels(mydata$run1Vrun2$V2) <- c("lyric","music","stimulus")
ggplot(mydata$run1Vrun2) +
  aes(x=V2,y=V1,color=V2)+
  #geom_violin() +
  geom_boxplot(lwd=2) +
  geom_jitter(size=3,width=0.2) +
  ylim(-0.25,0.55) +
  labs(x="Models",y="Correlation (r)" ) +
  #theme_classic() +
  theme(axis.text = element_text(size=20),
        axis.title = element_text(size=25),
        legend.position="none") +
  scale_color_manual(values=c("#134663","#EC008c","#134663"))
test<-mydata$run1Vrun2[ which(mydata$run1Vrun2$V2=='music'),]
mean(test$V1)

levels(mydata$scan1Vscan2$V2) <- c("lyric","music","stimulus")
ggplot(mydata$scan1Vscan2) +
  aes(x=V2,y=V1,color=V2) +
  #geom_violin() +
  geom_boxplot(lwd=2) +
  geom_jitter(size=3,width=0.2) +
  ylim(-0.25,0.55) +
  labs(x="Models",y="Correlation (r)") +
  #theme_classic() +
  theme(axis.text = element_text(size=20),
        axis.title = element_text(size=25),
        legend.position="none") +
  scale_color_manual(values=c("#134663","#EC008c","#134663"))

fname<-"RSA_CorrValues_SCAN12.csv"
data<-read.table(fname, sep=",",header=FALSE)
ggplot(data) +
  aes(x=V2, y=V1,color=V2) +
  #geom_violin() +
  geom_boxplot(lwd=2, color="#134663") +
  geom_jitter(size=3,width=0.2, color="#EC008c") +
  #ylim(-0.25,0.55) +
  labs(x="Models",y="Correlation (r)") +
  theme_classic() +
  theme(axis.text = element_text(size=20),
        axis.title = element_text(size=25),
        legend.position="none") 

+
  scale_color_manual(values=c("#134663","#EC008c","#134663"))

mydata<-split(data,data$V2)
                     