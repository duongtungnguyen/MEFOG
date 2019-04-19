% This file is used to generate 1 dataset for simulation.

clear all
% FULL DATASET includes 100 FNs, 40 services/buyers, and 3 resource types 
% (CPU, RAM, Bandwidth).
% M1 = 100; R = 3; N1 = 40;
% 
% M = 40; N = 10;  K=M*R;
% rev = ones(1,N1);   % rev(i) is e(i) in the paper.
% 
% [capa1,capa2] = dataCapacity(M1);
% 
% capa = capa1; 

%[data1,data2,data3,data4] = generateBaseDemandVector(M1,R,N1,M,N,capa,rev);
 




%%%%%%%%%%%%%%%%%% DATA INPUT %%%%%%%%%%%%%%%%%%%%%
[basedemand, capa, fullbasedemand] = dataTON_v1();
basedemand = basedemand(:,:,1:8);
[M, R, N] = size(basedemand);
K = M*R;
budget = ones(1,N);
cap = 600*ones(1,N); % cap is utility limit,  % change cap to bigM to get results for unlimited demand (no utility limit case)
capa_normalized = ones(M,R); % since basedemand is normalized 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[p,u,iu,x,demand] =  capLinearLeontief(budget,basedemand,capa_normalized,cap);

[p2,u2,iu2,x2,demand2] =  uncapLinearLeontief(budget,basedemand,capa_normalized);

u3 =  min(u2,cap');

bar([u2 u3 u])