frob_norm_matern=function(n,p,R_hat,sig2_nu_ell,X)
{
  sig2=sig2_nu_ell[1]
  nu=sig2_nu_ell[2]
  ell=sig2_nu_ell[3]
  R=sig2*toeplitz(matern_cov(0:(p-1),nu,ell)) #for MacKay's periodic kernel
  diag(R)=rep(sig2,p)
  f=sqrt(sum((R_hat-R)^2))
  return(f)
}
