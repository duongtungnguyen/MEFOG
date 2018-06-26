clear all
% FULL DATASET includes 100 FNs, 100 services/buyers, and 3 resource types 
% (CPU, RAM, Bandwidth).
M1 = 100; R = 3; N1 = 100;
% ratio is the ratio between the highest resource demand and the lowest
% e.g., if ratio = 5, demand for any resource type must be in the range of
% [1,5]., e.g., (3,5,2). 3CPU cores, 5 GB RAM, 2Gbps BW to handle 1 unit of
% requests (e.g., 1000 requests). => actual BDV is (3,5,2)/1000 for
% handling 1 request.
%ratio = 5; 

% smaller dataset is the data extracted for the first M nodes and 
% N services/buyers
M = 100; N = 20;  K=M*R;
%nozero = 1;         % a_{ijr} # 0 , for all i,j,r.
rev = ones(1,N1);   % rev(i) is e(i) in the paper.
% capa1: each FN is one Amazon server
% capa2: each FN has several amazon servers of the same type.
[capa1,capa2] = dataCapacity(M1);
capa = capa1; 

[data1,data2,data3,data4] = generateBaseDemandVector(M1,R,N1,M,N,capa,rev);
 % data1 is the base demand vector with full data set size M1*N1 with
 % actual value of CPU (#cores), RAM (GB), and BW (Mbps)
 % data2 is the dataset extracted from data1, size M*N
 
 % data3 is the normalized value of base demand vector, scaled by the
 % actual capacity of resources at nodes. its a_{ijr} in the paper
 
 % data4 is a M*N matrix extracted from data3.
 
 
budget = ones(1,N);
cap =3000*ones(1,N);
basedemand = data4;
capa_normalized = ones(M,R); % since basedemand is normalized in data4, we will take 

% e.g.: p_{2,3} is the price of the whole resource type 3 (BW) at FN 2. To
% get price of 1 unit (1 Mbps) of BW at FN 2, we can simply take
% p_{2,3}/capa(2,3).

[p,u,iu,x,demand] =  capLinearLeontief(budget,basedemand,capa_normalized,cap);


tic
% you can set rho differently depending on data. 
% for example, rho= 1, rho = N, ...
rho = N;

% You can change the value of tol1 and tol2 depending on the problem data.
% Here, we set convergence/termination/stopping when the difference of each element x_k is smaller than 10^-4.
% the smaller (tol1, tol2) the better convergence is. you can change the
% admmcapLinearLeontief file to define different convergence criteria (e.g. based on % change of x between iterations).
% 
% tol1 = K*N*10^-8; tol2 = K*10^-8*(rho^2); 
% tol1 = sqrt(N*10^-6); tol2 = sqrt(K*10^-8*(rho^2)); 
tol1 = sqrt(N)*10^-3; tol2 = 10^-4*(rho^2); 
[num_iteadmm,padmm, uadmm,xadmm,x_vectoradmm,gap1_trace,gap2_trace,u_trace, p_trace] = ...
    admmcapLinearLeontief(budget,basedemand,capa_normalized,cap,rho,tol1,tol2)
time = toc


%gap1 = sqrt(gap1_trace); gap2 = sqrt(gap2_trace);7i
gap1 = gap1_trace; gap2 = gap2_trace;

l = length(u_trace); t=1:1:l;
uu1 = u(1)*ones(l,1);uu2=u(2)*ones(l,1);uu3=u(3)*ones(l,1);uu4=u(4)*ones(l,1);
plot(t,u_trace(:,1),t,u_trace(:,2),t,u_trace(:,3),t,u_trace(:,4),t,uu1,t,uu2,t,uu3,t,uu4)
%plot(t,gap1_trace,t,gap2_trace);
semilogy(t,gap1,t,gap2);


% vector2matrix(padmm,M,R); % convert to M*R matrix form , prices.
