fname <-"C:/Users/asternin/Documents/PhDProject/Music and Memory/BehaviouralResults/YoungAdults/LyricMod.csv"
#fname<-"/Users/avitalsternin/Documents/Western/Academics/PhDProject.git/Music and Memory/BehaviouralResults/YoungAdults/LyricMod.csv"
data<-read.table(fname, sep=",",header=FALSE)

data=na.omit(data)

data$V1=factor(data$V1,
                 levels=1:6, 
                  labels=c("pre-scan1", "lab1", "lab2", "lab3", "lab4", "post-scan2")
                  )

library(ggplot2)
ggplot(data) +
  aes(x=V1, y=V2) +
  geom_violin(lwd=1,color="#EC008c") +
  geom_jitter(size=3, alpha = 0.7, color="#134663") +
  labs(x="Experimental Session",y="% correct") +
  theme_classic() +
  theme(axis.text = element_text(size=18),
        axis.title = element_text(size=20))
ggsave("LyrMemory_SfN.pdf",device="pdf")

plot(data$V1,data$V2, xlab="lab session", ylab="lyric modification score")

listens<-(c(0,4.54375,2.16895,2.8625,2.125,3.23125))
plot(listens, type="l")
#abline(fit<-lm(data$V2~data$V1))

pre <- data[ which(data$V1=='pre-scan1'), ] 
lab1 <- data[ which(data$V1=='lab1'), ] 
lab2 <- data[ which(data$V1=='lab2'), ] 
lab3 <- data[ which(data$V1=='lab3'), ] 
lab4 <- data[ which(data$V1=='lab4'), ] 
post <- data[ which(data$V1=='post-scan2'), ] 