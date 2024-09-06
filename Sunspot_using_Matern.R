rm(list=ls())

source_files <- function(directory) {
  file_list <- list.files(directory, pattern = "\\.R$", full.names = TRUE)
  sapply(file_list, source, .GlobalEnv)
}

#set the directory to where you have saved the basics folder
source_files("basics")

y=as.numeric(sunspot.year)
x=1700:1988
n=length(y)

t=230 #training dataset contains first 80% data points
res=y-mean(y)
par=par_est(t,2:12, res[1:t])
p=par$p
w=par$w
R=par$R

a=matern_sig2_nu_ell_est(t,par$p,par$R,res)
sig2=a[1]
nu=a[2]
ell=a[3]

R_m=sig2*toeplitz(matern_cov(0:(p-1),nu,ell))
diag(R_m)=rep(sig2,p)

y_pred=mean(y)+pred_element(n,p,w,R_m,res)
plot(x[1:288],y[1:288],'l',ylab="No. of sunspots", xlab="Year",ylim=c(-10,210))
lines(x[(t+1):288],y_pred[(t+1):288],col=2)


test=y[(t+1):289]
test_pred=y_pred[(t+1):289]

mean(abs(test - test_pred))

mean((test - test_pred)^2)

relative_squared_errors <- ((test - test_pred) / test)^2
mean_relative_squared_error <- mean(relative_squared_errors)
sqrt(mean_relative_squared_error)

