## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
rm(list=ls())

# Required packages
library(sn)
library(Rtwalk)
library(TeachingDemos)

# Data
data(ais)

bmi = ais$BMI[1:100]

hist(bmi)

# Log-likelihood and MLE 
ll <- function(par){
if(par[2]>0) return(-sum(dsn(bmi,par[1],par[2],par[3],log=T)))
else return(Inf)
}

OPT <- optim(c(20,1,2),ll)

MLE <- OPT$par

##########################################################################################################################
# Log-posterior with Wasserstein prior
##########################################################################################################################
# -Log posterior

sc = 0.757

lpw <- function(par){
  mu <- par[1]; sigma = exp(par[2]); alpha = par[3]
return(-sum(dsn(bmi,mu,sigma,alpha,log=T)) - dt(alpha/sc, df = 3/2, log = TRUE) )
}

# Number of iterations 
NMH = 110000

# Support function 
Support <- function(x) {TRUE}

# Function to generate the initial points in the sampler
X0 <- function(x) { MLE + runif(3, -0.1,0.1) }

# Posterior samples
set.seed(1234)
outw <- Runtwalk( dim=3,  Tr=NMH,  Obj=lpw, Supp=Support, x0=X0(), xp0=X0(),PlotLogPost = FALSE) 

# thin-in and burn-in
burn = 10000
thin = 100
ind = seq(burn,NMH,thin)

mupw = outw$output[ , 1][ind]
sigmapw = exp(outw$output[ , 2][ind])
alphapw = outw$output[ , 3][ind]

# Some histograms and summaries
hist(mupw)
abline(v=MLE[1],col="red",lwd=2)
box()

hist(sigmapw)
abline(v=MLE[2],col="red",lwd=2)
box()

hist(alphapw)
abline(v=MLE[3],col="red",lwd=2)
box()

# Posterior means
apply(cbind(mupw,sigmapw,alphapw),2,mean)

# Posterior medians
apply(cbind(mupw,sigmapw,alphapw),2,median)

# Highest posterior credible intervals
apply(cbind(mupw,sigmapw,alphapw),2,emp.hpd)

##########################################################################################################################
# Predictive density
##########################################################################################################################

# Predictive densities for the Wasserstein prior
predw<- Vectorize(function(x) {
  tempf <- function(par) dsn(x,par[1],par[2],par[3])
  var <- mean(apply(cbind(mupw,sigmapw,alphapw),1,tempf))
  return(var)
})


hist(bmi,breaks=20,probability = TRUE, xlim=c(15,35), ylab = "Predictive Density")
curve(predw,15,35,add=T,lwd=2,lty=1)
box()

