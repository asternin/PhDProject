library(ggplot2)
library(ggpubr)
#fname <-"C:/Users/asternin/My Documents/PhdProject.git/CBS/Analysis/DataforR.csv"
fname<-"~/Documents/Western/Academics/PhDProject.git/CBS/Analysis/DataforR.csv"
data<-read.table(fname, sep=",",header=TRUE)
data<-na.omit(data)

## CREATE CATEGORY VARIABLE
data$MoCAcat[data$MoCA >= 27] <- 3
data$MoCAcat[data$MoCA < 27 & data$MoCA > 22] <- 2
data$MoCAcat[data$MoCA <= 22] <- 1
data$MoCAcat <- factor(data$MoCAcat,levels=c(1,2,3),labels=c("impaired","borderline","unimpaired"))

p1<-ggplot(data,aes(x=DT, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p2<-ggplot(data,aes(x=OOO, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p3<-ggplot(data,aes(x=SP, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p4<-ggplot(data,aes(x=GR, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p5<-ggplot(data,aes(x=DS, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p6<-ggplot(data,aes(x=TS, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p7<-ggplot(data,aes(x=PA, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p8<-ggplot(data,aes(x=SS, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p9<-ggplot(data,aes(x=FM, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p10<-ggplot(data,aes(x=R, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p11<-ggplot(data,aes(x=P, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
p12<-ggplot(data,aes(x=ML, color=MoCAcat)) + geom_density()+scale_color_manual(values=c("red","black","green"))
ggarrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,ncol=3,nrow=4)

#p1<-ggplot(data,aes(MoCA,DT,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p2<-ggplot(data,aes(MoCA,OOO,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p3<-ggplot(data,aes(MoCA,SP,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p4<-ggplot(data,aes(MoCA,GR,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p5<-ggplot(data,aes(MoCA,DS,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p6<-ggplot(data,aes(MoCA,TS,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p7<-ggplot(data,aes(MoCA,PA,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p8<-ggplot(data,aes(MoCA,SS,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p9<-ggplot(data,aes(MoCA,FM,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p10<-ggplot(data,aes(MoCA,R,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p11<-ggplot(data,aes(MoCA,P,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#p12<-ggplot(data,aes(MoCA,ML,color=MoCAcat))+geom_point() + stat_ellipse() + scale_color_manual(values=c("red","black","green"))
#ggarrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,ncol=3,nrow=4)