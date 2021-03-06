#######################
## Model 4 1916-1943 ##
#######################

model <- 4

## Use robust methods
library(robust)
lmRobControl <- lmRob.control(mxr=100,mxf=100,trace=F)

## Set start and end years of full model
start <- 1916
end <- 1943

## Set start and end years of partial model
## Roughly 70-30 split

p1b.start <- 1916 # Brest training data start
p1b.end <- 1933 # Brest training data end
p2b.start <- 1934 # Brest prediction start
p2b.end <- 1943 # Brest prediction end

p1n.start <- p1b.start # Newlyn training data start
p1n.end <- p1b.end # Newlyn training data end
p2n.start <- p2b.start # Newlyn prediction start
p2n.end <- p2b.end # Newlyn prediction end

source("~/Dropbox/BrestNewlyn/brestNewlynFunctionsACRE.R")

# Variance reduction
#> (tg.lmRob.newlyn$r.sq-tg.lmRob.newlynTotalP$r.sq)
#[1] 0.3700237 cf 0.273999
#> tg.lmRob.newlyn$r.sq
#[1] 0.7254665 cf 0.7001414
#> c(coef(tg.lmRob.brest)[2]/10.045, coef(tg.lmRob.newlyn)[2]/10.045)
#       t        t 
#1.718610 1.559207 cf 1.822623 1.798708 
#> c(sqrt(diag(tg.lmRob.brest$cov))[2]/10.045,  sqrt(diag(tg.lmRob.newlyn$cov))[2]/10.045)
#        t         t 
#0.6081806 0.7192874 cf 0.2615218 0.2927652

x11()
#png(file="model4Newlyn.png")
mNewlynTotalP <- mean(newlynTotalP, na.rm=T)
plot(time,newlynTotalP-mNewlynTotalP,col='blue',type='l', ylim=c(-1000,1000), lwd=2, ann=F)
lines(time,tg.lmRob.newlyn$fitted-mNewlynTotalP,col='red')
lines(time[p1p.start:p1p.end],tg.lmRob.newlyn.partial$fit-mNewlynTotalP,col='cyan', lwd=2)
lines(time[p2p.start:p2p.end],tg.lmRob.newlyn.pred$fit-mNewlynTotalP,col='orange', lwd=2)
title(main="Model 4: Newlyn", xlab="Year", ylab="Height [mm]")
grid(lwd=2)
#dev.off()
x11()
#png(file="model4Brest.png")
mBrestTotalP <- mean(brestTotalP, na.rm=T)
plot(time,brestTotalP-mBrestTotalP,col='blue',type='l', ylim=c(-1000,1000), lwd=2, ann=F)
lines(time,tg.lmRob.brest$fitted-mBrestTotalP,col='red')
lines(time[p1p.start:p1p.end],tg.lmRob.brest.partial$fit-mBrestTotalP,col='cyan', lwd=2)
lines(time[p2p.start:p2p.end],tg.lmRob.brest.pred$fit-mBrestTotalP,col='orange', lwd=2)
title(main="Model 4: Brest", xlab="Year", ylab="Height [mm]")
grid(lwd=2)
#dev.off()
