% Simulation study

close all;
clear;
clc;

% Specify the filename
filename = 'data_1k.xlsx';

% Load data into a matrix
data = readmatrix(filename);

p=10;
k=10^4;
N=k*p;
sigma=1;
delta=0;
theta=5;
omega=0.5;
addpath('routine', 'routine/fastF0Nls');
datetime('now')
iter=100;

w_tsp=zeros(1,iter);
th_tsp=zeros(1,iter);
sig2_tsp=zeros(1,iter);
time_est_tsp=zeros(1,iter);
time_pred_tsp=zeros(1,iter);

w_hat=zeros(1,iter);
th_hat=zeros(1,iter);
sig2_hat=zeros(1,iter);
time_est_hat=zeros(1,iter);
time_pred_hat=zeros(1,iter);

for j = 1:iter 
        rng(j);
        period=10;
        lob = [0 0.1 -0.9999];      upb = [0 15 0.9999];
        %y=data(:,j);
        %y=randQPGP(N,p,sigma,delta,theta,omega,@period_sin_gauss_cov);
        y=QPGPsim(N,p,theta,omega,sigma^2);
     %TSP   
        tic;
        % estimation time 
        model=fit_QPGP(period,y,@regpoly0,@period_sin_gauss_cov,lob,upb);
        w_tsp(j)=model.thetahat(3);
        sig2_tsp(j)=(model.sigmahat)^2;% do i need to square this? as it is an estimate of sigma and not sigma2
        th_tsp(j)=model.thetahat(2);
        time_est_tsp(j)=toc;

        tic;
        % prediction time 
        y_pred_tsp=pred_QPGP(model,y);
        time_pred_tsp(j)=toc;


     % OUR
        n=length(y);
        tic;
        % estimation time 
        par=par_est(n,10,y);
        w_hat(j)=par.w;
        R_est=par.R;
        a=mackay_th_sig2_est(n,period,par.R,y);
        sig2_hat(j)=a(2);
        th_hat(j)=a(1);
        time_est_hat(j)=toc;

        tic;
        % prediction time 
        y_pred_hat=pred_element(n,period,w_hat(j),R_est,y);
        time_pred_hat(j)=toc;
        j

end
 

(mean(w_tsp)-omega)^2+var(w_tsp)
(mean(w_hat)-omega)^2+var(w_hat)
(mean(th_tsp)-theta)^2+var(th_tsp)
(mean(th_hat)-theta)^2+var(th_hat)
(mean(sig2_tsp)-sigma^2)^2+var(sig2_tsp)
(mean(sig2_hat)-sigma^2)^2+var(sig2_hat)

mean(time_est_tsp)
mean(time_est_hat)
mean(time_pred_tsp)
mean(time_pred_hat)

