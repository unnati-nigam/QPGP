frob_norm_mackay=function(n,p,R_hat,th_sig2,X)
{
  th=th_sig2[1]
  sig2=th_sig2[2]
  R=sig2*toeplitz(exp(-th^2*(sin(pi*(0:(p-1))/p))^2)) #for MacKay's periodic kernel
  f=sqrt(sum((R_hat-R)^2))
  return(f)
}

