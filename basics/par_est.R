par_est=function(n,p_search,X)
{
  #R=array(NA, dim = c(length(p_search),p,p))
  l=w=c()
  for (i in 1:length(p_search))
  {
    var=w_R_est(n,p_search[i],X)
    w=var$w
    R=var$R
    l[i]=logL(n,p_search[i],w,R,X)
    #print(p_search[i])
    #print(i)
    #print(l[i])
  }
  ind=which.min(l)
  p_est=p_search[ind]
  var=w_R_est(n,p_est,X)
  w_cap=var$w
  R_cap=var$R
  #th_cap=th_est(n,p_est,R_cap,X)
  return(list(p=p_est,w=w_cap,R=R_cap))#,th=th_cap))
}
