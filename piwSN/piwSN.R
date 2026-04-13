## --------------------------------------------------------------------------------------------------------------------------------------
# Wasserstein information function
WIM <- Vectorize(function(alpha){
  # Integrand
  integ <- Vectorize(function(x){
    log_num <- 0.5*log(2) - 0.5*(1 + 2*alpha^2)*x^2
    log_den <- 1.5*log(pi) + 2*log(1 + alpha^2) - log(2) - pnorm(alpha*x, log.p = TRUE)
    out <- exp(log_num - log_den)
    return(out)
  })
  int <- integrate(integ,-Inf,Inf)$value
})

# Normalising constant
tempf <- Vectorize(function(alpha){sqrt(WIM(alpha))})
normc <- integrate(tempf,-Inf,Inf)$value

# Wasserstein prior
piW <- Vectorize(function(alpha){sqrt(WIM(alpha))/normc })

curve(piW,-5,5, lwd = 2, n = 1000, xlab = expression(alpha), ylab = "Prior density", main = "Wasserstein prior",
      cex.axis = 1.5, cex.lab = 1.5)


## --------------------------------------------------------------------------------------------------------------------------------------
# t-approximation
sc = 0.757
appt <- Vectorize(function(x) dt(x/sc, df = 3/2)/sc)

curve(piW,-5,5, lwd = 2, n = 1000, xlab = expression(alpha), ylab = "Prior density", main = "Wasserstein prior",
      cex.axis = 1.5, cex.lab = 1.5)
curve(appt,-5,5, lwd = 2, lty = 2, add = T, n = 1000)
legend('topright', legend = c('Wasserstein prior', 't-approximation'), lwd = 2, lty = c(1,2))



abs_err <- Vectorize(function(x) abs(piW(x) - appt(x))  )

curve(abs_err,-5,5, lwd = 2, n = 1000, xlab = expression(alpha), ylab = "Absolute error", main = "",
      cex.axis = 1.5, cex.lab = 1.5)


