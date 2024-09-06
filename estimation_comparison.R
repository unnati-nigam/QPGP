rm(list=ls())

source_files <- function(directory) {
  file_list <- list.files(directory, pattern = "\\.R$", full.names = TRUE)
  sapply(file_list, source, .GlobalEnv)
}

#set the directory to where you have saved the folder
source_files("basics")

p=10
theta=5
sig2=1
omega=0.5
p_search=10

run=100
k_grid=c(10,100,1000,10000)#seq(100,1000,by=100)
w=matrix(NA,nrow=length(k_grid),ncol=run)
pp=matrix(NA,nrow=length(k_grid),ncol=run)
th=matrix(NA,nrow=length(k_grid),ncol=run)
sig2m=matrix(NA,nrow=length(k_grid),ncol=run)


for (i in 1:length(k_grid))
{
  start=Sys.time()
  k=k_grid[i]
  n=k*p
  
  period=c()
  for (j in 1:run)
  {
    set.seed(j)
    y=QPGPsim(n,p,theta,omega,sig2)
    par=par_est(n,p_search,y)
  #print(j)
    w[i,j]=par$w
    pp[i,j]=par$p
    th[i,j]=(th_sig2_est(n,par$p,par$R,y))[1]
    sig2m[i,j]=(th_sig2_est(n,par$p,par$R,y))[2]
  }
  print(i)
  end=Sys.time()
 print(end-start)
}

apply(w,1,mean)
apply(w,1,sd)
apply(th,1,mean)
apply(th,1,sd)
apply(sig2m,1,mean)
apply(sig2m,1,sd)
