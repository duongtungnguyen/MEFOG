clear all
% FULL DATASET includes 100 FNs, 100 services/buyers, and 3 resource types 
% (CPU, RAM, Bandwidth).
[~, capa, fullbasedemand] = dataTON_v1();
[M1, R, N1]  = size(fullbasedemand);
M = 100; N= 20;
basedemand = fullbasedemand(1:M,:,1:N)
K = M*R;
budget = ones(1,N);
cap = 6000*ones(1,N); % cap is utility limit
capa_normalized = ones(M,R); % since basedemand is normalized 

% Centralized solution
[p,u,iu,x,demand] =  capLinearLeontief(budget,basedemand,capa_normalized,cap);

% ADMM
tic
rho = 1;
 %rho =  N; %change rho depending dataset
 
% tol1 = K*N*10^-8; tol2 = K*10^-8*(rho^2); 
% tol1 = sqrt(N*10^-6); tol2 = sqrt(K*10^-8*(rho^2)); 
tol1 = sqrt(N)*10^-4; tol2 = rho*10^-4; 
%tol1 = 10^-3; tol2 = 10^-3; 
[num_iteadmm,padmm, uadmm,xadmm,x_vectoradmm,gap1_trace,gap2_trace,u_trace, p_trace] = ...
    admmcapLinearLeontief(budget,basedemand,capa_normalized,cap,rho,tol1,tol2)
time = toc


l = length(u_trace); t=1:1:l;
%uu1 = u1(1)*ones(l,1);uu2=u1(2)*ones(l,1);uu3=u1(3)*ones(l,1);uu4=u1(4)*ones(l,1);
uu1 = u(1)*ones(l,1);uu2=u(2)*ones(l,1);uu3=u(3)*ones(l,1);uu4=u(4)*ones(l,1);
plot(t,u_trace(:,1),t,u_trace(:,2),t,u_trace(:,3),t,u_trace(:,4),t,uu1,t,uu2,t,uu3,t,uu4)

gap1 = gap1_trace; gap2 = gap2_trace;

semilogy(t,gap1,t,gap2);
legend('Curve1','Curve2')



