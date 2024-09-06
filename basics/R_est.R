R_est=function(n,p,omega,X)
{
  k=n/p
  S= matrix(0, nrow = p, ncol = p)
  for (i in 1:(k-1))
  {
    S=S+(X[((i*p+1):((i+1)*p))]-omega*X[(((i-1)*p+1):(i*p))])%*%t(X[((i*p+1):((i+1)*p))]-omega*X[(((i-1)*p+1):(i*p))])
  }
  S=S/(k-1)
  return(S)
}