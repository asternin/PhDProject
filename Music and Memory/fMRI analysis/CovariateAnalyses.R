#fname <-"C:/Users/asternin/My Documents/PhdProject.git/Music and Memory/fMRI analysis/CovData.csv"
fname<-"~/Documents/Western/Academics/PhDProject.git/Music and Memory/fMRI analysis/CovData.csv"
data<-read.table(fname, sep=",",header=TRUE)


# ## familiarity ANOVA
# model=lm(fam_S1_ROI1 ~ song*familiarity,data=data)
# anova(model)
# model=lm(fam_S1_ROI2 ~ song*familiarity,data=data)
# anova(model)
# model=lm(fam_S1_ROI3 ~ song*familiarity,data=data)
# anova(model)
# model=lm(fam_S2_ROI1 ~ song*familiarity,data=data) #SIG main effect of familiarity (0.001)
# anova(model)
# model=lm(fam_S2_ROI2 ~ song*familiarity,data=data) # SIG main effect of familiarity (0.01)
# anova(model)
# 
# ##for plotting ANOVA values - change y = ...
# #require(ggplot2)
# ggplot(data, aes(x=song , y=fam_S2_ROI2)) +
#   geom_boxplot(fill = "grey80", colour = "blue") +
#   scale_x_discrete() + xlab("song") +
#   ylab("activation")
# 
# ## lyror ANOVA
# model=lm(lyror_S1_ROI1 ~ song*lyror,data=data)
# anova(model)
# model=lm(lyror_S1_ROI2 ~ song*lyror,data=data)
# anova(model)
# model=lm(lyror_S1_ROI3 ~ song*lyror,data=data)
# anova(model)
# model=lm(lyror_S2_ROI1 ~ song*lyror,data=data)
# anova(model)
# model=lm(lyror_S2_ROI2 ~ song*lyror,data=data)
# anova(model)
# 
# ##for plotting ANOVA values - change y = ...
# #require(ggplot2)
# ggplot(data, aes(x=song , y=lyror_S2_ROI1)) +
#   geom_boxplot(fill = "grey80", colour = "blue") +
#   scale_x_discrete() + xlab("song") +
#   ylab("activation")
# 
# ## melmem ANOVA
# model=lm(melmem_S1_ROI1 ~ song*melmem,data=data) # SIG effect of melmem (0.001)
# anova(model)
# model=lm(melmem_S1_ROI2 ~ song*melmem,data=data) # SIG effect of melmem (0.01)
# anova(model)
# model=lm(melmem_S2_ROI1 ~ song*melmem,data=data)
# anova(model)
# model=lm(melmem_S2_ROI2 ~ song*melmem,data=data)
# anova(model)
# 
# ##for plotting ANOVA values - change y = ...
# #require(ggplot2)
# ggplot(data, aes(x=song , y=melmem_S2_ROI1)) +
#   geom_boxplot(fill = "grey80", colour = "blue") +
#   scale_x_discrete() + xlab("song") +
#   ylab("activation")
# 
# ## beatper ANOVA
# model=lm(beatper_S1_ROI1 ~ song*beatper,data=data)
# anova(model)
# model=lm(beatper_S1_ROI2 ~ song*beatper,data=data) #SIG effect of beat per (0.05)
# anova(model)
# model=lm(beatper_S2_ROI1 ~ song*beatper,data=data)
# anova(model)
# model=lm(beatper_S2_ROI2 ~ song*beatper,data=data)
# anova(model)
# model=lm(beatper_S2_ROI3 ~ song*beatper,data=data) #SIG effect of beatper (0.01)
# anova(model)
# model=lm(beatper_S2_ROI4 ~ song*beatper,data=data) # SIG effect of beatper (0.01)
# anova(model)
# 
# ##for plotting ANOVA values - change y = ...
# #require(ggplot2)
# ggplot(data, aes(x=song , y=beatper_S2_ROI1)) +
#   geom_boxplot(fill = "grey80", colour = "blue") +
#   scale_x_discrete() + xlab("song") +
#   ylab("activation")
# 
# ## Lyrmod ANOVA
# model=lm(lyrmod_S1_ROI1 ~ song*lyrmod,data=data) #SIG effect of lyrmod (0.01)
# anova(model)
# model=lm(lyrmod_S1_ROI2 ~ song*lyrmod,data=data) #SIG Effect of lyrmod (0.05)
# anova(model)
# model=lm(lyrmod_S1_ROI3 ~ song*lyrmod,data=data)
# anova(model)
# model=lm(lyrmod_S1_ROI4 ~ song*lyrmod,data=data) #SIG effect of lyrmod (0.05)
# anova(model)
# model=lm(lyrmod_S2_ROI1 ~ song*lyrmod,data=data)
# anova(model)
# model=lm(lyrmod_S2_ROI2 ~ song*lyrmod,data=data)
# anova(model)
# 
# ##for plotting ANOVA values - change y = ...
# #require(ggplot2)
# ggplot(data, aes(x=song , y=lyrmod_S2_ROI1)) +
#   geom_boxplot(fill = "grey80", colour = "blue") +
#   scale_x_discrete() + xlab("song") +
#   ylab("activation")
# 
# ## oldnew ANOVA
# model=lm(oldnew_S1_ROI1 ~ song*oldnew,data=data)
# anova(model)
# model=lm(oldnew_S1_ROI2 ~ song*oldnew,data=data)
# anova(model)
# model=lm(oldnew_S1_ROI3 ~ song*oldnew,data=data)
# anova(model)
# model=lm(oldnew_S2_ROI1 ~ song*oldnew,data=data)
# anova(model)
# model=lm(oldnew_S2_ROI2 ~ song*oldnew,data=data)
# anova(model)
# 
# ##for plotting ANOVA values - change y = ...
# #require(ggplot2)
# ggplot(data, aes(x=song , y=oldnew_S2_ROI1)) +
#   geom_boxplot(fill = "grey80", colour = "blue") +
#   scale_x_discrete() + xlab("song") +
#   ylab("activation")