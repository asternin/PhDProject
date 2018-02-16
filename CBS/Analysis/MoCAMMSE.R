fname <-"C:/Users/asternin/My Documents/PhdProject.git/CBS/Data.csv"
data<-read.table(fname, sep=",",header=TRUE)
pdata<-na.omit(data)
MoCAcat<-list("U","MCI","I")
colour<-list("green","blue","red")

##REGRESSIONS FOR MoCA AND MMSE SCORES
m0MoCA<-lm(MoCA~1,data=pdata)
mallMoCA<-lm(MoCA~DT+OOO+SP+GR+DS+TS+PA+SS+FM+R+P+ML+age,data=pdata)
mbestMoCA<-step(m0MoCA,list(lower=m0MoCA,upper=mallMoCA),diection="both")
#summary(mbestMoCA)

m0MMSE<-lm(MMSE~1,data=pdata)
mallMMSE<-lm(MMSE~DT+OOO+SP+GR+DS+TS+PA+SS+FM+R+P+ML+age,data=pdata)
mbestMMSE<-step(m0MMSE,list(lower=m0MMSE,upper=mallMMSE),diection="both")
#summary(mbestMMSE)

mageMoCA<-lm(MoCA~age,data=pdata)
summary(mageMoCA)
mageMMSE<-lm(MMSE~age,data=pdata)
summary(mageMMSE)

## CREATE CATEGORY VARIABLES
attach(data)
data$MoCAcat[MoCA >= 27] <- 1
data$MoCAcat[MoCA < 27 & MoCA > 22] <- 2
data$MoCAcat[MoCA <= 22] <- 3
detach(data)

attach(data)
data$MMSEcat[MMSE >= 24] <- 1
data$MMSEcat[MMSE < 24 & MMSE > 17] <- 2
data$MMSEcat[MMSE <= 17] <-3
detach(data)

## PLOTS
#plot MoCA and MMSE scores vs age
par(mfrow=c(1,2))

MoCAcat <- as.factor(data$MoCAcat)
col.MoCAlist<-c("red","green","black")
palette(col.list)
plot(data$age,data$MoCA,xlab="age",ylab="MoCA",pch=19,col=MoCAcat)
abline(fit<-lm(data$MoCA~data$age))
abline(27,0,col="green")
abline(22,0,col="red")
summary(lm(data$MoCA~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))
legend("bottomright", legend=c("No CI", "MCI","I"),col=c("green", "black","red"),pch=19)

MMSEcat <- as.factor(data$MMSEcat)
col.MMSelist<-c("red","green","black")
palette(col.list)
plot(data$age,data$MMSE,xlab="age",ylab="MMSE",pch=19,col=MMSEcat)
abline(fit<-lm(data$MMSE~data$age))
abline(24,0,col="green")
abline(17,0,col="red")
summary(lm(data$MMSE~data$age))
legend("bottomleft", bty="n", legend=paste("R2 is", format(summary(fit)$adj.r.squared, digits=4)))
legend("bottomright", legend=c("No CI", "MCI","I"),col=c("green", "black","red"),pch=19)

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