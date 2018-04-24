library(ggplot2)
#fname <-"C:/Users/asternin/My Documents/PhdProject.git/CBS/Analysis/DataforR.csv"
fname<-"~/Documents/Western/Academics/PhDProject.git/CBS/Analysis/DataforR.csv"
data<-read.table(fname, sep=",",header=TRUE)
data<-na.omit(data)
MoCAcat<-list("U","MCI","I")
colour<-list("green","black","red")

## CREATE CATEGORY VARIABLE
data$MoCAcat[data$MoCA >= 27] <- 3
data$MoCAcat[data$MoCA < 27 & data$MoCA > 22] <- 2
data$MoCAcat[data$MoCA <= 22] <- 1

data$MoCAcat <- factor(data$MoCAcat,levels=c(1,2,3),labels=c("impaired","borderline","unimpaired"))
p<-ggplot(data,aes(x=PA, color=MoCAcat)) + geom_density()
p+scale_color_manual(values=c("red","black","green"))

p<-ggplot(data,aes(MoCA,PA,color=MoCAcat))+geom_point() + stat_ellipse()
p+scale_color_manual(values=c("red","black","green"))