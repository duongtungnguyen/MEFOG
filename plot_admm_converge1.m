clear all
% FULL DATASET includes 100 FNs, 100 services/buyers, and 3 resource types 
% (CPU, RAM, Bandwidth).
M1 = 1000; R = 3; N1 = 1000;

M = 100; N = 10;  K=M*R;
rev = ones(1,N1);   % rev(i) is e(i) in the paper.

[capa1,capa2] = dataCapacity(M1);
capa = capa1; 

[data1,data2,data3,data4] = generateBaseDemandVector(M1,R,N1,M,N,capa,rev);
 
 
budget = ones(1,N);
cap = 4000*ones(1,N);
basedemand = data4;
capa_normalized = ones(M,R); % since basedemand is normalized in data4, we will take 


[p,u,iu,x,demand] =  capLinearLeontief(budget,basedemand,capa_normalized,cap);



tic
 rho =  N; % increase rho, gap1 decreases quickly.  gap2 increases then decreases.
 
% tol1 = K*N*10^-8; tol2 = K*10^-8*(rho^2); 
% tol1 = sqrt(N*10^-6); tol2 = sqrt(K*10^-8*(rho^2)); 
tol1 = 10^-4; tol2 = rho*10^-3; 
%tol1 = 10^-3; tol2 = 10^-3; 
[num_iteadmm,padmm, uadmm,xadmm,x_vectoradmm,gap1_trace,gap2_trace,u_trace, p_trace] = ...
    admmcapLinearLeontief(budget,basedemand,capa_normalized,cap,rho,tol1,tol2)
time = toc


l = length(u_trace); t=1:1:l;
uu1 = u(1)*ones(l,1);uu2=u(2)*ones(l,1);uu3=u(3)*ones(l,1);uu4=u(4)*ones(l,1);
plot(t,u_trace(:,1),t,u_trace(:,2),t,u_trace(:,3),t,u_trace(:,4),t,uu1,t,uu2,t,uu3,t,uu4)

gap1 = gap1_trace; gap2 = gap2_trace;

semilogy(t,gap1,t,gap2);



