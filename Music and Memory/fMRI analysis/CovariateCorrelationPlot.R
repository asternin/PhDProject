library("Hmisc")
covariates<-na.omit(data[c(3:8)])
covcor<-rcorr(as.matrix(covariates))
covcor

#install.packages("RColorBrewer")  
library(RColorBrewer) # Needed to get color gradient


cols = brewer.pal(11, "RdBu")   # goes from red to white to blue
pal = colorRampPalette(cols)
cor_colors = data.frame(correlation = seq(-1,1,0.01), 
                        correlation_color = pal(201)[1:201])  # assigns a color for each r correlation value
cor_colors$correlation_color = as.character(cor_colors$correlation_color)

panel.cor <- function(x, y, digits=2, cex.cor)
{
  par(usr = c(0, 1, 0, 1))
  u <- par('usr') 
  names(u) <- c("xleft", "xright", "ybottom", "ytop")
  r <- cor(x, y,method="pearson",use="complete.obs")
  test <- cor.test(x,y)
  bgcolor = cor_colors[2+(-r+1)*100,2]    # converts correlation into a specific color
  do.call(rect, c(col = bgcolor, as.list(u))) # colors the correlation box
  
  if (test$p.value> 0.05){
    text(0.5,0.5,"n.s.",cex=1.5)
  } else{
    text(0.5, 0.75, paste("r=",round(r,2)),cex=2.5) # prints correlatoin coefficient
    text(.5, .25, paste("p=",formatC(test$p.value, format ="f", digits=4)),cex=2)  
    #text(.5, .25, paste("p=",formatC(test$p.value, format = "e", digits = 1)),cex=2)  
    abline(h = 0.5, lty = 2) # draws a line between correlatoin coefficient and p value
  }
  
}

panel.smooth<-function (x, y, col = "black", bg = NA, pch = 19, cex = 1.2, 
                        col.smooth = "blue", span = 2/3, iter = 3, ...) {
  points(x, y, pch = pch, col = col, bg = bg, cex = cex)
  abline(fit<-lm(y~x))
#  ok <- is.finite(x) & is.finite(y)
#  if (any(ok)) 
#    lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), lwd=2.5, col = col.smooth, ...)
}

panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col="cyan", ...)
}

pairs(covariates,
      lower.panel=panel.smooth, 
      upper.panel=panel.cor,
      diag.panel=panel.hist,cex.labels=2)