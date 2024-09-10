rm(list=ls())

library(ggplot2)

source_files <- function(directory) {
  file_list <- list.files(directory, pattern = "\\.R$", full.names = TRUE)
  sapply(file_list, source, .GlobalEnv)
}

#set the directory to where you have saved the folder
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

R_ma=sig2*toeplitz(matern_cov(0:(p-1),nu,ell))
diag(R_ma)=rep(sig2,p)

b=mackay_th_sig2_est(t,par$p,par$R,res)
theta=b[1]
sig2=b[2]

R_mb=sig2*toeplitz(exp(-theta^2*(sin(pi*(0:(p-1))/p))^2))

y_pred_a=mean(y)+pred_element(n,p,w,R_ma,res)

y_pred_b=mean(y)+pred_element(n,p,w,R_mb,res)

full_data <- data.frame(
  x = x[201:289],
  y = y[201:289]
)

# Data frame for the last 58 points (with estimates and CIs)
est_data <- data.frame(
  x = x[231:289],
  a_est=y_pred_a[231:289],
  b_est=y_pred_b[231:289]
)

library(ggplot2)
ggplot() +
  geom_line(data = full_data, aes(x = x, y = y, color = "Sunspots")) +  # Line for the full dataset
  geom_line(data = est_data, aes(x = x, y = a_est, color = "QPGP using Periodic Matern kernel")) +  # Estimates line for last 58 points
  geom_line(data = est_data, aes(x = x, y = b_est, color = "QPGP using Periodic MacKay's kernel")) +  # Estimates line for last 58 points
  labs(x = "Year", y = "No. of sunspots", color = "Legend") +  # Adding a label for the legend
  scale_color_manual(
    values = c("Sunspots" = "black", 
               "QPGP using Periodic Matern kernel" = "red", 
               "QPGP using Periodic MacKay's kernel" = "blue"),
    breaks = c("Sunspots", "QPGP using Periodic Matern kernel", "QPGP using Periodic MacKay's kernel")  # Ensuring the legend order
  ) +
  theme_minimal() +
  theme(
    legend.position = c(0.05, 0.95),  # Place legend in the top-left corner
    legend.justification = c("left", "top"),  # Align legend to the top-left corner
    legend.title = element_text(size = 10),  # Adjust legend title size
    legend.text = element_text(size = 8),   # Adjust legend text size
    legend.key.size = unit(0.5, "cm")       # Adjust the size of the legend keys
  )
