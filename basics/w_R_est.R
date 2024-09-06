w_R_est=function(n,p,X)
{
  max_iter=100
  R_hat=array(NA, dim = c(max_iter,p,p))
  w_hat=c()
  R_hat[1,,]=diag(p) #initial- independent observations
  w_hat[1]=w_est(n,p,R_hat[1,,],X)
  
  i=2
  repeat
  {
    R_hat[i,,]=R_est(n,p,w_hat[i-1],X)
    w_hat[i]=w_est(n,p,R_hat[i,,],X)
    
    l1=logL(n,p,w_hat[i],R_hat[i,,],X)
    l2=logL(n,p,w_hat[i-1],R_hat[i-1,,],X)
    l1-l2
    if (!is.nan(l1-l2))
      if(abs(l1-l2)<1e-10||i>=max_iter) 
        break  
    
    if(i>=max_iter)
      break
    i=i+1
     }
  R_hat=R_hat[1:i,,]
  w_hat=w_hat[length(w_hat)]
  R_hat=R_hat[dim(R_hat)[1],,]
  return(list(w=w_hat,R=R_hat))
}

