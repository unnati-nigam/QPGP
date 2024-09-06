pred_element=function(n,p,w,R,X)
{
  
  pred=c()
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
    
    if(j>p)
    {
      pred1=w*X[(i-1)*p+l]
      pred2=(R[l,1:(l-1)])%*%solve(R[1:(l-1),1:(l-1)])%*%(X[(i*p+1):(i*p+l-1)]-w*X[((i-1)*p+1):((i-1)*p+l-1)])
    } 
    else 
    {
      pred1=0
      pred2=(R[l,1:(l-1)])%*%solve(R[1:(l-1),1:(l-1)])%*%(X[(i*p+1):(i*p+l-1)])
    }
    pred[j]=pred1+as.numeric(pred2)
    
  }
  return(pred)

  
}