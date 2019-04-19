% Consider a toy example with two FNs, single-resource (e.g., CPU only) and
% two services. Note that aij in the paper is 1/aij in addititvecapa(1).m
clear all
N = 2;  M = 2;

%%% single FN
%a1 = [5; 10];
%%% 2 FNs
%  The utilities amount to 1 and
% 2, resp., and the prices can be chosen as p1 = 1 and p2 ? [0.5, 3].
a = [5 1;
     2 1]; 
price=[1 2]; xx = [0 1; 1 0]; bb=xx*price'; uti=sum(xx.*a,2)
B = [3, 1]; cap = [1,100];basedemand = a;budget = B;capa = ones(1,M);%capa = 1;
[p,x,v,u] = additivecapa(budget,basedemand,capa);
[p1,x1,v1,u1] = additivecapa1(budget,basedemand,capa,cap);
uu = min(u,cap'); uuu=[u uu u1] 
x
p
p1
x1
b = x*p
b1=x1*p1




%p = [4.8 1.2]; xx2 = [0.2 0], xx2*p = 0.96<B2; xx1=[0.8 0.8]; xx1*p = 4.8 < 5;
%u1 = min(0.8*4+0.8*1,1)=1; u2=min(0.2*5+0,1)=1; both max under budget.
% EG:  x=[1  0.1667; 0  0.8333]; total spend 5,1
% GEG: x