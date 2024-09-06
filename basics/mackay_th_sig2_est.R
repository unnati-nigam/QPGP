mackay_th_sig2_est=function(n,p,R,X)
{
  initial_guess <- c(th = 1, sig2 = 1)
  t<-optim(par = initial_guess, fn = frob_norm_mackay,n=n,p=p,X=X,R_hat=R,method = "L-BFGS-B")
   return(t$par)
}
