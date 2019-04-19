clear all



%%%%%%%%%%%%%%%%%% DATA INPUT %%%%%%%%%%%%%%%%%%%%%
[~, ~, fullbasedemand] = dataTON_v1();
M  = 40; N = 8;
basedemand = fullbasedemand(1:M,:,1:N);
[M, R, N] = size(basedemand);
K = M*R;
budget = ones(1,N);
cap = 600*ones(1,N); % cap is utility limit
capa = ones(M,R); % since basedemand is normalized 


[p1,u1,iu1,x1,demand1] =  capLinearLeontief(budget,basedemand,capa,cap);
bar(demand1(1:5,:))