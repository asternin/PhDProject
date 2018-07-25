#fname <-"C:/Users/asternin/My Documents/PhdProject.git/CBS/Analysis/DataforR.csv"
fname<-"~/Documents/Western/Academics/PhDProject.git/CBS/Analysis/DataforR.csv"
data<-read.table(fname, sep=",",header=TRUE)
pdata<-data[c(1:17)]
pdata<-na.omit(pdata)
MoCAcat<-list("U","MCI","I")
colour<-list("green","blue","red")

##REGRESSIONS FOR MoCA AND MMSE SCORES
m0MoCA<-lm(MoCA~1,data=pdata)
mallMoCA<-lm(MoCA~DT+OOO+SP+GR+DS+TS+PA+SS+FM+R+P+ML+age,data=pdata)
mbestMoCA<-step(m0MoCA,list(lower=m0MoCA,upper=mallMoCA),diection="both")
summary(mbestMoCA)

m0MMSE<-lm(MMSE~1,data=pdata)
mallMMSE<-lm(MMSE~DT+OOO+SP+GR+DS+TS+PA+SS+FM+R+P+ML+age,data=pdata)
mbestMMSE<-step(m0MMSE,list(lower=m0MMSE,upper=mallMMSE),diection="both")
summary(mbestMMSE)

mageMoCA<-lm(MoCA~age,data=pdata)
summary(mageMoCA)
mageMMSE<-lm(MMSE~age,data=pdata)
summary(mageMMSE)

meduMoCA<-lm(MoCA~edu,data=data)
summary(meduMoCA)
meduMMSE<-lm(MMSE~edu,data=data)
summary(meduMMSE)
## CREATE CATEGORY VARIABLES

pdata$MoCAcat[pdata$MoCA >= 26] <- 3
pdata$MoCAcat[pdata$MoCA < 26 & pdata$MoCA > 22] <- 1
pdata$MoCAcat[pdata$MoCA <= 22] <- 2


pdata$MMSEcat[pdata$MMSE >= 24] <- 3
pdata$MMSEcat[pdata$MMSE < 24 & pdata$MMSE > 17] <- 1
pdata$MMSEcat[pdata$MMSE <= 17] <-2

## COrrelations
cor(data$DT,data$MoCA)
cor(data$OOO,data$MoCA)
cor(data$SP,data$MoCA)
cor(data$GR,data$MoCA)
cor(data$DS,data$MoCA)
cor(data$TS,data$MoCA)
cor(data$PA,data$MoCA)
cor(data$SS,data$MoCA)
cor(data$FM,data$MoCA)
cor(data$R,data$MoCA)
cor(data$P,data$MoCA)
cor(data$ML,data$MoCA)

## ZScore - composite score
library(mosaic)
OOOz<-zscore(pdata$OOO)
FMz<-zscore(pdata$FM)
SPz<-zscore(pdata$SP)
comp<-(OOOz+FMz+SPz)/3
cor(comp,pdata$MoCA)

cor.test(pdata$MMSE, pdata$MoCA, method="pearson",alternative="two.sided")

cor.test(data$MMSE, data$edu, method="pearson",alternative="two.sided")
plot(data$edu, data$MMSE)
abline(fit<-lm(data$MMSE~data$edu))
cor.test(data$MoCA, data$edu, method="pearson",alternative="two.sided")
plot(data$edu, data$MoCA)
abline(fit<-lm(data$MoCA~data$edu))

cor.test(comp, pdata$MoCA, method="pearson",alternative="two.sided")
cor.test(comp, pdata$MMSE, method="pearson",alternative="two.sided")

par(mfrow=c(1,2))
MoCAcat <- as.factor(pdata$MoCAcat)
MMSEcat <- as.factor(pdata$MMSEcat)
#plot(comp,pdata$MoCA, xlab="CBS 3 test composite score",ylab="MoCA",pch=c(19,15,17)[as.factor(MoCAcat)],ylim=c(12,30),col=MoCAcat)
plot(comp,pdata$MoCA, xlab="CBS 3 test composite score",ylab="MoCA",pch=c(1,15,17)[as.factor(MoCAcat)],ylim=c(12,30))
abline(26,0,col="black")
abline(22,0,col="black")
abline(fit<-lm(pdata$MoCA~comp))

cor(comp,pdata$MMSE)
#par(mfrow=c(1,1))
#plot(comp,pdata$MMSE, xlab="CBS 3 test composite score",ylab="MMSE",pch=c(19,15,17)[as.factor(MMSEcat)],ylim=c(12,30),col=MMSEcat)
plot(comp,pdata$MMSE, xlab="CBS 3 test composite score",ylab="MMSE",pch=c(1,15,17)[as.factor(MMSEcat)],ylim=c(12,30))
abline(24,0,col="black")
abline(17,0,col="black")
abline(fit<-lm(pdata$MMSE~comp))
#legend("bottomright", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=c(17,19,15))
legend("bottomright", legend=c("unimpaired", "borderline","impaired"),pch=c(17,1,15))



## PLOTS
#plot MoCA and MMSE scores vs age
par(mfrow=c(1,2))

MoCAcat <- as.factor(data$MoCAcat)
#col.MoCAlist<-c("red","green","black")
#palette(col.list)
plot(data$age,data$MoCA,xlab="age",ylab="MoCA",pch=19,col=MoCAcat,ylim=c(12,30))
#abline(fit<-lm(data$MoCA~data$age))
abline(26,0,col="green")
abline(22,0,col="red")
#summary(lm(data$MoCA~data$age))
#legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))
legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)

MMSEcat <- as.factor(data$MMSEcat)
col.MMSelist<-c("red","green","black")
palette(col.list)
plot(data$age,data$MMSE,xlab="age",ylab="MMSE",pch=19,col=MMSEcat,ylim=c(12,30))
abline(fit<-lm(data$MMSE~data$age))
abline(24,0,col="green")
abline(17,0,col="red")
#summary(lm(data$MMSE~data$age))
#legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))
legend("bottomleft", legend=c("unimpaired", "borderline","impaired"),col=c("green", "black","red"),pch=19)

# plot CBS scores vs age
par(mfrow=c(4,3))
plot(data$age,data$PA,xlab="age",ylab="Paired Associates")
abline(fit<-lm(data$PA~data$age))
summary(lm(data$PA~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$FM,xlab="age",ylab="Feature Match")
abline(fit<-lm(data$FM~data$age))
summary(lm(data$FM~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$GR,xlab="age",ylab="Grammatical Reasoning")
abline(fit<-lm(data$GR~data$age))
summary(lm(data$GR~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$DS,xlab="age",ylab="Digit Span")
abline(fit<-lm(data$DS~data$age))
summary(lm(data$DS~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$TS,xlab="age",ylab="Token Search")
abline(fit<-lm(data$TS~data$age))
summary(lm(data$TS~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$ML,xlab="age",ylab="Monkey Ladder")
abline(fit<-lm(data$ML~data$age))
summary(lm(data$ML~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$OOO,xlab="age",ylab="Odd One Out")
abline(fit<-lm(data$OOO~data$age))
summary(lm(data$OOO~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$SP,xlab="age",ylab="Spatial Planning")
abline(fit<-lm(data$SP~data$age))
summary(lm(data$SP~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$R,xlab="age",ylab="Rotations")
abline(fit<-lm(data$R~data$age))
summary(lm(data$R~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$P,xlab="age",ylab="Polygons")
abline(fit<-lm(data$P~data$age))
summary(lm(data$P~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$SS,xlab="age",ylab="Spatial Span")
abline(fit<-lm(data$SS~data$age))
summary(lm(data$SS~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))

plot(data$age,data$DT,xlab="age",ylab="Double Trouble")
abline(fit<-lm(data$DT~data$age))
summary(lm(data$DT~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))
