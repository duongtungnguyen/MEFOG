clear all
M1 = 50; R = 5; N1 = 50; M = 10; N = 4; ratio = 5; nozero=1; K=M*R;
rev = ones(1,N1);

capa = ones(M,R);
%[~,basedemand] = dataok();
[fullcapa,data] = dataTON()

% [data5,data6,data7,data8] = generateDataFixedProportion2(M1,R,N1,ratio,M,N,nozero,fullcapa,rev);
% 
% demand = data8;
basedemand =  data;
cap = 100*ones(1,N);
% uncapped
cap1 = 30*ones(1,N);
cap2 = 25*ones(1,N);
%ucap = bigM*ones(1,N);
budget1 = ones(1,N);

budget2 = [2 1 1 1];
% budget = randi(3,1,N);
%budget = rand(1,N);

% [p,u,iu,x,demand] =  uncapLinearLeontief(budget,basedemand,capa,cap);
% uu1 = min(u,cap1');
% uu2 = min(u,cap2');

[p1,u1,iu1,x1,demand1] =  capLinearLeontief(budget1,basedemand,capa,cap1);

[p2,u2,iu2,x2,demand2] =  capLinearLeontief(budget2,basedemand,capa,cap1);


[p3,u3,iu3,x3,demand3] =  uncapLinearLeontief(budget1,basedemand,capa);

[p4,u4,iu4,x4,demand4] =  uncapLinearLeontief(budget2,basedemand,capa);

u=[u1 u2 u3 u4]
bar(u)

% b=1:M;
% plot(b,p1(:,1),b,p1(:,2),b,p1(:,3),b,p1(:,4),b,p1(:,5))
