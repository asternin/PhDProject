library(ggplot2)
library(tidyr)
data<-data.frame("diag"=c("im","bo","un","im","bo","un","im","bo","un"), 
                 "test"=c("MoCA","MoCA","MoCA","MoCA+SP","MoCA+SP","MoCA+SP","MMSE","MMSE","MMSE"),
                 scores=c(22,28,50,34,8,58,2,4,94))
data$diag=factor(data$diag,levels=c("im","bo","un"))
data$test=factor(data$test,levels=c("MoCA","MoCA+SP","MMSE"))
labels<-c("impaired","borderline","unimpaired")
(p<-ggplot(data) +
    aes(x=diag,y=scores, fill=diag) +
    geom_bar(stat="identity",position=position_stack())+
    facet_wrap(~test) +
    scale_fill_manual(values=c("red", "black", "green"),labels= labels) +
    labs(x="Category",
         y="Proportion Categorized (%)",
         fill="Category") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    scale_x_discrete(labels= labels)
)


(p<-ggplot(data,aes(test,scores)) +
    geom_bar(aes(fill=diag))
)


    facet_wrap(~test) +
    scale_fill_manual(values=c("red", "black", "green"),labels= labels) +
    labs(x="Category",
         y="Proportion Categorized (%)",
         fill="Category") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    scale_x_discrete(labels= labels)
)
