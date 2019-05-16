fname <-"file:///C:/Users/asternin/Documents/PhDProject.git/Music and Memory/BehaviouralResults/OldNew.csv"
#fname<-"~/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/CovData.csv"
data<-read.table(fname, sep=",",header=FALSE)


library(ggplot2)
ggplot(data)+
  aes(x=V1)+
  geom_histogram(breaks=seq(70,100, by=5),color="white",fill="#134663")+
  labs(x="% Correct",y="Frequency") +
  theme_classic() +
  theme(axis.text = element_text(size=18),
        axis.title = element_text(size=20),
        legend.position="none")
ggsave("OldNew_SfN.pdf",device="pdf")

#scale_x_continuous(breaks=c(70,80,90,100),labels=c("70","80","90","100")) + # Ticks from 70-100, every 10

hist(data$V1, 
     main="",
     xlim = c(70,100),
     xlab = "Melody Memory Scores",
     axes = TRUE, plot = TRUE, labels = FALSE)