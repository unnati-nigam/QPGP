library(MASS)
QPGPsim=function(n,p,theta,omega,sig2)
{
  R=sig2*toeplitz(exp(-theta^2*(sin(pi*(0:(p-1))/p))^2))
  X=c()
  X[1:p]=mvrnorm(1,rep(0,p),(R)/(1-omega^2))#
  k=floor(n/p)
  for (i in 2:k)
  {
    X[((i-1)*p+1):(i*p)]=omega*X[((i-2)*p+1):((i-1)*p)]+mvrnorm(1,rep(0,p),R)#
  }
  return(X)
}
