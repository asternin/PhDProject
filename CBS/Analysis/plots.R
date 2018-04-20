fname <-"C:/Users/asternin/My Documents/PhdProject.git/CBS/Analysis/DataforR.csv"
#fname<-"~/Documents/Western/Academics/PhDProject.git/CBS/Analysis/Data.csv"
data<-read.table(fname, sep=",",header=TRUE)
pdata<-na.omit(data)
MoCAcat<-list("U","MCI","I")
colour<-list("green","blue","red")

## CREATE CATEGORY VARIABLES

data$MoCAcat[data$MoCA >= 27] <- 3
data$MoCAcat[data$MoCA < 27 & data$MoCA > 22] <- 1
data$MoCAcat[data$MoCA <= 22] <- 2

data$MMSEcat[data$MMSE >= 24] <- 3
data$MMSEcat[data$MMSE < 24 & data$MMSE > 17] <- 1
data$MMSEcat[data$MMSE <= 17] <-2

MoCAcat <- as.factor(data$MoCAcat)
# plot CBS scores by category
par(mfrow=c(4,3))
plot(pdata$PA,pdata$ID,ylab="ID",xlab="Paired Associates Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$FM,pdata$ID,ylab="ID",xlab="Feature Match Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$GR,pdata$ID,ylab="ID",xlab="Grammatical Reasoning Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$DS,pdata$ID,ylab="ID",xlab="Digit Span Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$TS,pdata$ID,ylab="ID",xlab="Token Search Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$ML,pdata$ID,ylab="ID",xlab="Monkey Ladder Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$OOO,pdata$ID,ylab="ID",xlab="Odd One Out Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$SP,pdata$ID,ylab="ID",xlab="Spatial Planning Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$R,pdata$ID,ylab="ID",xlab="Rotations Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$P,pdata$ID,ylab="ID",xlab="Polygons Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$SS,pdata$ID,ylab="ID",xlab="Spatial Span Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)
plot(pdata$DT,pdata$ID,ylab="ID",xlab="Double Trouble Score",pch=19,col=MoCAcat)
#legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)

layout(matrix(c(1,1,1,2,3,4),nrow=2,ncol=3,byrow=TRUE))
#hist(pdata$PA,xlab="all participants")
plot(pdata$PA,pdata$ID,ylab="ID",xlab="Paired Associates Score",pch=19,col=MoCAcat)
hist(pdata$PA[ which(MoCAcat==3)],xlab="unimpaired",main="",col="green")
hist(pdata$PA[ which(MoCAcat==2)],xlab="borderline",main="")
hist(pdata$PA[ which(data$MoCAcat==1)],xlab="impaired",main="",col="red")
density(pdata$PA[ which(data$MoCAcat==3)],xlab="unimpaired",main="",col="green")

ggplot(data=data, aes(data$PA)) + geom_histogram(bins=10) + geom_density(col=2) 

hist(pdata$FM)
hist(pdata$GR)
hist(pdata$DS)
hist(pdata$TS)
hist(pdata$ML)
hist(pdata$OOO)
hist(pdata$SP)
hist(pdata$R)
hist(pdata$P)
hist(pdata$SS)
hist(pdata$DT)