logL=function(n,p,omega,R,X)
{
  spec=sd_R(R,p)
  R_inv=Re(spec$U%*%(diag(1/spec$e))%*%(spec$UH))
  
  sum=0
  k=floor(n/p)
  for(i in 2:k)
  {
    a=t(X[(((i-1)*p+1):(i*p))]-as.vector(omega)*X[(((i-2)*p+1):((i-1)*p))])%*%R_inv%*%(X[(((i-1)*p+1):(i*p))]-as.vector(omega)*X[(((i-2)*p+1):((i-1)*p))])
    sum=sum+a
  }
  detR=prod(Re(spec$e))
  #detR=det(R)
  logL=((k-1)*p*log(2*pi))/2+((k-1)*log(detR))/2+sum
  if(is.nan(logL))
  {logL=Inf}
  if(!is.nan(logL)&&logL< -1e+10)
  {logL=Inf}
  
  return(as.numeric(logL))
}
