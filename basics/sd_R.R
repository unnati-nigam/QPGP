sd_R=function(R,p)
{
  e=(fft(R[1,]))
  UH=((dftmtx(p)))/sqrt(p)
  UH=(UH)
  U=Conj(t(UH))
  return(list(e=e,U=U,UH=UH))
}
