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


budget1 = ones(1,N);

budget2 = [1 2 1 1 1 1 1 1];

[p1,u1,iu1,x1,demand1] =  capLinearLeontief(budget1,basedemand,capa,cap);

[p2,u2,iu2,x2,demand2] =  capLinearLeontief(budget2,basedemand,capa,cap);


[p3,u3,iu3,x3,demand3] =  uncapLinearLeontief(budget1,basedemand,capa);

[p4,u4,iu4,x4,demand4] =  uncapLinearLeontief(budget2,basedemand,capa);

u=[u1 u2 u3 u4]
bar(u)

% b=1:M;
% plot(b,p1(:,1),b,p1(:,2),b,p1(:,3),b,p1(:,4),b,p1(:,5))
