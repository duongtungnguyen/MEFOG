% Consider a toy example with two FNs, single-resource (e.g., CPU only) and
% two services. Note that aij in the paper is 1/aij in addititvecapa.
% 
clear all
N = 2;  M = 2;
%%% single FN
%a1 = [5; 10];

%%% 2 FNs
a  = [4 1;4  4];
a1 = [4 1;3  4];
a2 = [4 1;5  4];  
a3 = [4 1;8  4];
a4 = [4 1;12 4]; 
a5 = [4 1;15.9 4]; 
a6 = [4 1;16.1   4]; 
B = [1, 1]; % B1= 3; B2 = 1;
%cap = [100,100]; %basedemand = a;
budget = B; capa = ones(1,M); %capa = 1;

[p,x,v,u] = additivecapa(budget,a,capa);
[p1,x1,v1,ufake1] = additivecapa(budget,a1,capa);
[p2,x2,v2,ufake2] = additivecapa(budget,a2,capa);
[p3,x3,v3,ufake3] = additivecapa(budget,a3,capa);
[p4,x4,v4,ufake4] = additivecapa(budget,a4,capa);
[p5,x5,v5,ufake5] = additivecapa(budget,a5,capa);
[p6,x6,v6,ufake6] = additivecapa(budget,a6,capa);
% need a function to compute actual utility
% the actual obtained utility must be computed based on actual aij
u1 = sum(x1.*a,2); u2 = sum(x2.*a,2);u3 = sum(x3.*a,2);u4 = sum(x4.*a,2);
u5 = sum(x5.*a,2); u6 = sum(x6.*a,2);
ufake = [u ufake1 ufake2 ufake3 ufake4 ufake5 ufake6];
uu = [u u1 u2 u3 u4 u5 u6]
xx = [x x1 x2 x3 x4 x5 x6]
pp = [p p1 p2 p3 p4 p5 p6]
% x
% u
% u1
% x1
% x2
% u2
% x3
% u3