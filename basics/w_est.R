w_est=function(n,p,R,X)
{
  k=floor(n/p)
  spec=sd_R(R,p)
  R_inv=Re(spec$U%*%(diag(1/spec$e))%*%(spec$UH))
  #R_inv=chol2inv(chol(R))
  i1i=0
  for(i in 2:k)
  {
    i1i=i1i+t(X[((i-2)*p+1):((i-1)*p)])%*%R_inv%*%(X[((i-1)*p+1):(i*p)])
  }
  
  ii=0
  for(i in 1:(k-1))
  {
    ii=ii+t(X[((i-1)*p+1):(i*p)])%*%R_inv%*%(X[((i-1)*p+1):(i*p)])
  }
  
  w_est=i1i/ii
  return(w_est)
}
