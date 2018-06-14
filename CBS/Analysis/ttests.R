#fname <-"C:/Users/asternin/My Documents/PhdProject.git/CBS/Analysis/DataforR.csv"
fname<-"~/Documents/Western/Academics/PhDProject.git/CBS/Analysis/DataforR.csv"
data<-read.table(fname, sep=",",header=TRUE)
data<-na.omit(data)

## CREATE CATEGORY VARIABLE
data$MoCAcat[data$MoCA >= 27] <- 3
data$MoCAcat[data$MoCA < 27 & data$MoCA > 22] <- 2
data$MoCAcat[data$MoCA <= 22] <- 1
data$MoCAcat <- factor(data$MoCAcat,levels=c(1,2,3),labels=c("impaired","borderline","unimpaired"))

imp<-data[which(data$MoCAcat=="impaired"),] #notice the comma after parenthesis
unimp<-data[which(data$MoCAcat=="unimpaired"),] #notice the comma after parenthesis here too 

#Welch two sample t-test
t.test(imp$DT,unimp$DT)
t.test(imp$OOO,unimp$OOO)
t.test(imp$SP,unimp$SP)
t.test(imp$GR,unimp$GR)
t.test(imp$DS,unimp$DS)
t.test(imp$TS,unimp$TS)
t.test(imp$PA,unimp$PA)
t.test(imp$SS,unimp$SS)
t.test(imp$FM,unimp$FM)
t.test(imp$R,unimp$R)
t.test(imp$P,unimp$P)
t.test(imp$ML,unimp$ML)

#Two sample t-test
t.test(imp$DT,unimp$DT,var.equal=TRUE)
t.test(imp$OOO,unimp$OOO,var.equal=TRUE)
t.test(imp$SP,unimp$SP,var.equal=TRUE)
t.test(imp$GR,unimp$GR,var.equal=TRUE)
t.test(imp$DS,unimp$DS,var.equal=TRUE)
t.test(imp$TS,unimp$TS,var.equal=TRUE)
t.test(imp$PA,unimp$PA,var.equal=TRUE)
t.test(imp$SS,unimp$SS,var.equal=TRUE)
t.test(imp$FM,unimp$FM,var.equal=TRUE)
t.test(imp$R,unimp$R,var.equal=TRUE)
t.test(imp$P,unimp$P,var.equal=TRUE)
t.test(imp$ML,unimp$ML,var.equal=TRUE)