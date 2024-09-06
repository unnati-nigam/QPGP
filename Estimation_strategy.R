rm(list=ls())

source_files <- function(directory) {
  file_list <- list.files(directory, pattern = "\\.R$", full.names = TRUE)
  sapply(file_list, source, .GlobalEnv)
}

#set the directory to where you have saved the folder
source_files("basics")

p=10
k=1000
theta=5
omega=0.8
n=k*p
sig2=3
p_search=(p-5):(p+5)

iter=100
PAR=matrix(,nrow=iter,ncol=4)
for(j in 1:iter)
{
  print(j)
  set.seed(j)
  y=QPGPsim(n,p,theta,omega,sig2)
  par=par_est(n,p_search,y)
  PAR[j,1]=par$p
  PAR[j,2]=par$w
  PAR[j,3]=(th_sig2_est(n,par$p,par$R,y))[1]#par$th
  PAR[j,4]=(th_sig2_est(n,par$p,par$R,y))[2]
  print(date())
}
summary(PAR)
sd(PAR[,2])
sd(PAR[,3])
table(PAR[,1])

R_hat=par$R
R=((th_sig2_est(n,par$p,par$R,y))[2])*toeplitz(exp(-(th_sig2_est(n,par$p,par$R,y))[1]^2*(sin(pi*(0:(par$p-1))/par$p))^2))
e1=max(eigen(R_hat)$values)
e2=max(eigen(R)$values)
abs(e1-e2)
e1/e2
