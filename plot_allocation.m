clear all
M1 = 50; R = 5; N1 = 50; M = 10; N = 4; ratio = 5; nozero=1; 
rev = ones(1,N1);

[fulldata,data] = dataTON()
%demand = data7;
demand = fulldata;
basedemand = data;
cap = 10000*ones(1,N);
% uncapped
cap1 = 30*ones(1,N);
capa = ones(M,R);
budget1 = ones(1,N);
budget2 = [2 1 1 1];
 
% [p,u,iu,x,demand] =  uncapLinearLeontief(budget1,basedemand,capa,cap);
% uu1 = min(u,cap1');
%  
% [p1,u1,iu1,x1,demand1] =  capLinearLeontief(budget1,basedemand,capa,cap1);
% [p11,u11,iu11,x11,demand11] =  capLinearLeontief(budget1,basedemand,capa,cap);

% fullcapa = randi(100,M1,R);
% [data5,data6,data7,data8] = generateDataFixedProportion2(M1,R,N1,ratio,M,N,nozero,fullcapa,rev);
% basedemand1 = data8;
% 
% cap11 = 15*ones(1,N);
% [p,u,iu,x,demand] =  uncapLinearLeontief(budget1,basedemand1,capa,cap);
% uu1 = min(u,cap1');
%  
% [p1,u1,iu1,x1,demand1] =  capLinearLeontief(budget1,basedemand1,capa,cap11);
% [p11,u11,iu11,x11,demand11] =  capLinearLeontief(budget1,basedemand1,capa,cap)
