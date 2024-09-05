rm(list=ls())

library(ggplot2)

source_files <- function(directory) {
  file_list <- list.files(directory, pattern = "\\.R$", full.names = TRUE)
  sapply(file_list, source, .GlobalEnv)
}

#set the directory to where you have saved the folder
setwd("C:/Users/Unnati Nigam/Desktop/U/Unnati Nigam/PhD Notes/Research/Quasi-Periodic GP/ICASSP 2025/QPGP_GitHub")
source_files("basics")

y=as.numeric(sunspot.year)
x=1700:1988
n=length(y)

t=230 #training dataset contains first 80% data points
res=y-mean(y)
par=par_est(t,2:12,res[1:t])
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

p_var=pred_var(n,p,w,R_m,res)
p_sd=sqrt(p_var)

pred=y_pred
lower=y_pred-2*p_sd
upper=y_pred+2*p_sd

full_data <- data.frame(
  x = x,
  y = y
)

# Data frame for the last 58 points (with estimates and CIs)
ci_data <- data.frame(
  x = x[231:289],
  estimate = y_pred[231:289],
  lower = lower[231:289],
  upper = upper[231:289]
)

library(ggplot2)

ggplot() +
  geom_line(data = full_data, aes(x = x, y = y)) +  # Line for the full dataset
  geom_ribbon(data = ci_data, aes(x = x, ymin = lower, ymax = upper), alpha = 0.2) +  # Shaded CIs for last 58 points
  geom_line(data = ci_data, aes(x = x, y = estimate), color = "red") +  # Estimates line for last 58 points
  #geom_point(data = ci_data, aes(x = x, y = estimate), color = "blue") +  # Estimates points for last 58 points
  labs(x = "Year", y = "No. of sunspots") +
  theme_minimal()

