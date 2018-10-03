fname <-"C:/Users/asternin/My Documents/PhdProject.git/Music and Memory/behaviouralResults/LyricModType.csv"
data<-read.table(fname, sep=",",header=TRUE)

t.test(data$a.pre,data$a.post)
t.test(data$s.pre,data$s.post)
t.test(data$w.pre,data$w.post)

t.test(data$s.post,data$a.post)
t.test(data$a.post,data$w.post)
t.test(data$s.post,data$w.post)

fname <-"C:/Users/asternin/My Documents/PhdProject.git/Music and Memory/behaviouralResults/LyricMod_Type.csv"
data<-read.table(fname, sep=",",header=TRUE)

model=lm(reps ~ type*ses,data=data)
anova(model)
aov(model)