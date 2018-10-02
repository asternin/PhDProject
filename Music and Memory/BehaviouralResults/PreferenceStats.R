fname <-"file:///C:/Users/asternin/Documents/PhDProject.git/Music and Memory/BehaviouralResults/BehaviouralResults-AllParticipants.csv"
#fname<-"~/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/CovData.csv"
data<-read.table(fname, sep=",",header=TRUE)

a<-c(data$a)
i<-c(data$i)
s<-c(data$s)
w<-c(data$w)
pref<-c(a,i,s,w)

type<-c(rep("a",242),rep("i",242),rep("s",242),rep("w",242))

preftype<-data.frame(pref,type)

model=lm(pref ~ type,data=preftype)
anova(model)

p<-ggplot(data=preftype, aes(x=type, y=pref)) +
  geom_boxplot() +
  scale_x_discrete(labels=c("a capella","instrumental","spoken","whole"))
p


t.test(data$a,data$i)
t.test(data$a,data$s)
t.test(data$a,data$w)
t.test(data$i,data$s)
t.test(data$i,data$w)
t.test(data$s,data$w)