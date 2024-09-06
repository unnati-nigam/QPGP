matern_sig2_nu_ell_est=function(n,p,R,X)
{
  initial_guess <- c(sig2=125,nu=3,ell=1)
  t<-optim(par = initial_guess, fn = frob_norm_matern,n=n,p=p,X=X,R_hat=R, method="CG")
  return(t$par)
}
