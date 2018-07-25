library(ggplot2)
library(magrittr)
fname<-"~/Documents/Western/Academics/PhDProject.git/CBS/Analysis/CBS_Concussion_Age_Clara.csv"
data<-read.table(fname, sep=",",header=TRUE)
#CBS_dataAge_All<-data[ data$Concussion == "Non-Concussed" & data$Test=="ST", ]
CBS_dataAge_All<-data[ data$Concussion == "Non-Concussed",]

newdata<-subset(data, Age=='71-80' & Concussion=='Non-Concussed')
newdata$Test<-factor(newdata$Test)

p <- newdata %>% 
  ggplot(aes(x = Age, y = Scores, colour = Test)) +
  geom_point(aes(shape=Test, size=3)) + 
  scale_shape_manual(values=c(2,6,15,3,25,16,4,0,1,17,5,6) ) +
  #scale_size_manual(values=c(3,3,3,3,3,3,3,3,3,3,3,3) ) +
  #geom_line(aes(group = Test)) +
  ylim(-1.5, 0.1) +
  labs(x = "Age Group", y = "Standardized CBS scores") +
  geom_hline(yintercept = 0.0, colour = "black") +
  #facet_wrap(~Concussion) +
  #ggtitle("CBS across Ages") + 
  guides(colour = guide_legend(override.aes = list(size=5))) +
  theme(legend.position = "right", 
        legend.text = element_text(size = 12), 
        legend.title = element_blank(), 
        plot.title = element_text(hjust=0.5), 
        axis.line = element_line(colour='black'), 
        axis.text = element_text(colour = "black"), 
        text = element_text(size = 15),     
        panel.background = element_rect(fill='white', colour='white') )