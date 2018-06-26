clear all
% at the end of this file is code for testing dual decomposition in the
% case  of only one FN.
M1 = 50; R = 5; N1 = 50; M = 10; N = 4; ratio = 5; nozero=1; K=M*R;
rev = ones(1,N1);
%capa = randi(20,M,R);
fullcapa = randi(100,M1,R);
%[data1,data] = generateData(M,R,N,ratio,M0,N0)
[data1,data2] = generateDataFixedProportion(M1,R,N1,ratio,M,N, nozero);
[data3,data4] = generateData(M1,R,N1,ratio,M,N, nozero);
[data5,data6,data7,data8] = generateDataFixedProportion2(M1,R,N1,ratio,M,N,nozero,fullcapa,rev);
capa = ones(M,R);
%[~,basedemand] = dataok();
[fulldata,data] = dataTON()
demand = fulldata;
demand(1:10,1:R,1:4) = data;
basedemand = demand(1:M,1:R,1:N);
%[~,basedemand] = dataTON();
%basedemand = data8;
cap = 100*ones(1,N);
% uncapped

%ucap = bigM*ones(1,N);
budget1 = ones(1,N);

budget = ones(1,N);
% budget = randi(3,1,N);
%budget = rand(1,N);
%[p1,u1,iu1,x1,demand1] =  uncapLinearLeontief(budget,basedemand,capa,cap);
tic
[p,u,iu,x,demand] =  capLinearLeontief(budget,basedemand,capa,cap);
xxx=toc
p
u
u

tic

 %rho = 1/(M*R*N);
 
 % R=5,M=2, rho has to be multiplied by N number of buyers. can be 1xN~5xN
 rho = 1;
 tol1 = K*N*10^-8; tol2 = K*10^-11*(rho^2); 
[num_iteadmm,padmm, uadmm,xadmm,x_vectoradmm,gap1_trace,gap2_trace,u_trace, p_trace] = ...
    admmcapLinearLeontief(budget,basedemand,capa,cap,rho,tol1,tol2)
time = toc
%  19.8410
%    15.8387
%    39.6167
%    26.3930

gap1 = sqrt(gap1_trace); gap2 = sqrt(gap2_trace);

l = length(u_trace); t=1:1:l;
uu1 = u(1)*ones(l,1);uu2=u(2)*ones(l,1);uu3=u(3)*ones(l,1);uu4=u(4)*ones(l,1);
plot(t,u_trace(:,1),t,u_trace(:,2),t,u_trace(:,3),t,u_trace(:,4),t,uu1,t,uu2,t,uu3,t,uu4)
%plot(t,gap1_trace,t,gap2_trace);
semilogy(t,gap1,t,gap2);
%st=5;
%semilogy(t(st:length(t)),gap1(st:length(gap1)),t(st:length(t)),gap2(st:length(gap2)));

% l = length(u_trace); t=1:1:l;
% uu1 = u(1)*ones(l,1);uu2=u(2)*ones(l,1);
% plot(t,u_trace(:,1),t,u_trace(:,2),t,uu1,t,uu2)

%[p_trace(:,1) p_trace(:,2) p_trace(:,3) p_trace(:,4) p_trace(:,5)]
%plot(t,p_trace(:,1),t, p_trace(:,2), t,p_trace(:,3), t,p_trace(:,4),t, p_trace(:,5))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% DUAL DECOMPOSITION 1 NODE %%%%%%%%%%%%%%%%%%
% % step = 100*10^-1;tol =10^-6; step1 = 10*10^-1;
% % basedemand1 = zeros(N,R);
% % for i=1:N
% %     basedemand1(i,:) = basedemand(:,:,i);
% % end
% % basedemand1
% % [num_ite,uti,price,xopt,price_trace,p1_trace,u_trace,u1_trace] = ...
% %     dualdecomposition(budget,basedemand1,capa,cap,step,tol);
% % 
% % [num_ite1,uti1,price1,xopt1,price_trace1,p1_trace1,u_trace1,u1_trace1] = ...
% %     dualdecomposition1(budget,basedemand1,capa,cap,step1,tol);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DUAL DECOMPOSITION %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% 
% [SWp,SWu,SWiu,SWx] = SWM(budget,basedemand,capa,cap);
% SWp
% SWu
% [SWp1,SWu1,SWiu1,SWx1] = SWM(budget1,basedemand,capa,cap);
% SWp1
% SWu1
% [MMp, MMu, MMiu, MMx] = MMF(budget,basedemand,capa,cap);
% MMu
% MMp
%  [xprop,uprop] = proportionalSharing(budget,basedemand,capa,cap)
%  [sum(u) sum(SWu) sum(SWu1) sum(MMu) sum(uprop)]
% [u SWu SWu1 MMu uprop];
% [x2,u2] = subprobemclosedform(1,basedemand(:,:,10),p,cap(10))
% [xtemp,utemp,iutemp] = subprobem(1,basedemand(:,:,10),p,cap(10))
% x(:,:,10)
% u(10)
