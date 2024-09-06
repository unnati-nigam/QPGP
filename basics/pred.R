pred=function(n,p,w,X)
{
  Y=c()
  Y[1:p]=0
  k=floor(n/p)
  for(i in 2:k)
  {
    Y[((i-1)*p+1):(i*p)]=w*X[((i-2)*p+1):((i-1)*p)]
  }
  if(k!=(n/p))
  {
    c=n/p-k
    Y[(k*p+1):n]=w*X[((k-1)*p+1):((k-1)*p+1+c)]
  }
  return(Y)
}