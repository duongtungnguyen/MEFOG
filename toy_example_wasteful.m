% Consider a toy example with two FNs, single-resource (e.g., CPU only) and
% two services. Note that aij in the paper is 1/aij in addititvecapa(1).m
clear all
N = 2;  M = 2;

%%% single FN
a1 = [5; 10];


%%% 2 FNs
a = [8 2;
    5 2];
B = [3, 1]; % B1= 3; B2 = 1;
cap = [1,10];
basedemand = a;
budget = B;
capa = ones(1,M);
%capa = 1;



[p,x,v,u] = additivecapa(budget,basedemand,capa);
[p1,x1,v1,u1] = additivecapa1(budget,basedemand,capa,cap);
x
x1
u
u1