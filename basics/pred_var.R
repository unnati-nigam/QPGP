pred_var=function(n,p,w,R,X)
{
  var=c()
  for(j in 1:n)
  {
    if(j %%p!=0)
    {
      i=floor(j/p)
      l=j-i*p
    }
    else 
    {
      i=floor(j/p)-1
      l=p
    }
    
    R_star=as.matrix(R[l,1:(l-1)],byrow=TRUE)
    R_star_t=t(R_star)
    R_inv=solve(R[1:(l-1),1:(l-1)])
    if(j>p)
    {
      v=(w^2)*(R[l,l])/(1-w^2)+R_star_t%*%t(R_inv)%*%R_star
      #  R_star_t%*%R_inv%*%R_star+R_star_t%*%t(R_inv)%*%R_star 
    }
    else
    {
      v=(w^2)*(R[l,l])/(1-w^2)+(R_star_t%*%t(R_inv)%*%R_star)/(1-w^2)
    }
    
    var[j]=as.numeric(v)
  }
  return(var)
}
