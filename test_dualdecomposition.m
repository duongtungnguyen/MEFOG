clear all
M1 = 50; R = 5; N1 = 50; M = 1;N = 50; ratio = 10; nozero=1;rev = ones(1,N1);

[fulldata,data] = dataTON();
% fullcapa = randi(100,M1,R); 
% [data5,data6,data7,data8] = generateDataFixedProportion2(M1,R,N1,ratio,M1,N1,nozero,fullcapa,rev);
%demand = data7;

demand = fulldata; demand(1:10,1:R,1:4) = data;

cap = 10000*ones(1,N); cap1 = 30*ones(1,N);
budget = ones(1,N);

basedemand = demand(1:M,1:R,1:N); capa = ones(M,R);

[p3,u3,iu3,x3,demand3] =  capLinearLeontief(budget,basedemand,capa,cap1);

step = N*20*10^-1;tol =10^-6; step1 = 5;
basedemand1 = zeros(N,R);
for i=1:N
    basedemand1(i,:) = basedemand(:,:,i);
end
basedemand1
[ite,u,p,xopt,p_trace,p1_trace,u_trace,u1_trace] = ...
    dualdecomposition(budget,basedemand1,capa,cap1,step,tol);
% % 
[ite1,u1,p1,xopt1,p_trace1,p1_trace1,u_trace1,u1_trace1] = ...
    dualdecomposition1(budget,basedemand1,capa,cap1,step1,tol);

t = 1:1:ite;
plot(t,p_trace(:,1),t,p_trace(:,2),t,p_trace(:,3),t,p_trace(:,4),t,p_trace(:,5))
plot(t,u_trace(:,1),t,u_trace(:,2),t,u_trace(:,3),t,u_trace(:,4))

t1 = 1:1:ite1;
plot(t1,p_trace1(:,1),t1,p_trace1(:,2),t1,p_trace1(:,3),t1,p_trace1(:,4),t1,p_trace1(:,5))
plot(t1,u_trace1(:,1),t1,u_trace1(:,2),t1,u_trace1(:,3),t1,u_trace1(:,4))
% plot(t1,u_trace1(t1,1),t1,u_trace1(t1,2),t1,u_trace1(t1,3),t1,u_trace1(t1,4))






