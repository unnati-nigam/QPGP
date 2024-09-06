dftmtx <- function(n) 
{
  omega <- exp(-2i * pi / n)
  F <- matrix(0, nrow = n,ncol = n)
  for (k in 0:(n-1)) 
  {
    for (j in 0:(n-1)) 
    {
      F[k+1,j+1] <- omega^(k*j)
    }
  }
  return(F)
}
