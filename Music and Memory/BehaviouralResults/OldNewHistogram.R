fname <-"file:///C:/Users/asternin/Documents/PhDProject.git/Music and Memory/BehaviouralResults/OldNew.csv"
#fname<-"~/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/CovData.csv"
data<-read.table(fname, sep=",",header=FALSE)

hist(data$V1, 
     main="",
     xlim = c(70,100),
     xlab = "Melody Memory Scores",
     axes = TRUE, plot = TRUE, labels = FALSE)