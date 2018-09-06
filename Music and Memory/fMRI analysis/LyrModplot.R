fname <-"file:///C:/Users/asternin/Documents/PhDProject.git/Music and Memory/BehaviouralResults/LyricMod.csv"
#fname<-"~/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/CovData.csv"
data<-read.table(fname, sep=",",header=FALSE)

data=na.omit(data)

data$V1=factor(data$V1,
                 levels=1:6, 
                  labels=c("pre-scan1", "lab1", "lab2", "lab3", "lab4", "post-scan2")
                  )

plot(data$V1,data$V2, xlab="lab session", ylab="lyric modification score")
#abline(fit<-lm(data$V2~data$V1))