
clear all
M1 = 100; R = 5; N1 = 50;
%M = 10; 
N = 4; ratio = 5; nozero=1; 
rev = ones(1,N1);


%[~,basedemand] = dataok();
[fulldata,data] = dataTON()

%[data5,data6,data7,data8] = generateDataFixedProportion2(M1,R,N1,ratio,M,N,nozero,fullcapa,rev);

%demand = data7;
demand = fulldata;
demand(1:10,1:R,1:4) = data;

%basedemand =  demand(1:10,1:R,1:N);
cap = 10000*ones(1,N);
% uncapped
cap1 = 30*ones(1,N);
cap2 = 25*ones(1,N);
%ucap = bigM*ones(1,N);
budget1 = ones(1,N);
%budget1 = [11 1 20 1]
M = 2:4:50;
L = length(M);
uu1 = zeros(1,L); u1 = zeros(1,L);
uprop = zeros(1,L); uSW = zeros(1,L); uMM = zeros(1,L);
EF1 = zeros(1,L); EF = zeros(1,L);  EFprop = zeros(1,L);  EFSW = zeros(1,L); 
 EFMM = zeros(1,L); 
 
 %cap1=cap;

for k=1:L
    basedemand = demand(1:M(k),1:R,1:N);
    capa = ones(M(k),R);
    [~,u,~,x,~] =  uncapLinearLeontief(budget1,basedemand,capa,cap)
    u = min(u,cap1');
    uu1(k) = sum(u);
    [~,~,~,EF(k)] = computeEFindex(budget1,basedemand,capa,cap1,x)
    
    [~,temp1,~,x1,~] =  capLinearLeontief(budget1,basedemand,capa,cap1);
    u1(k) = sum(temp1);
    [~,~,~,EF1(k)] = computeEFindex(budget1,basedemand,capa,cap1,x1)

        
    [xprop,temp2] = proportionalSharing(budget1,basedemand,capa,cap1)
    uprop(k) = sum(temp2);    
    [~,~,~,EFprop(k)] = computeEFindex(budget1,basedemand,capa,cap1,xprop)

    
    [~,SWu1,~,xSW] = SWM(budget1,basedemand,capa,cap1)
    uSW(k) = sum(SWu1);
    [~,~,~,EFSW(k)] = computeEFindex(budget1,basedemand,capa,cap1,xSW)

    [~, MMu1, ~, mmx] = MMF(budget1,basedemand,capa,cap1)
    uMM(k) = sum(MMu1);
    [~,~,~,EFMM(k)] = computeEFindex(budget1,basedemand,capa,cap1,mmx)
end
M = M';
%plot(M,u1,M,uu1,M,uprop,M,uSW,M,uMM)
plot(M,EF1,M,EF,M,EFprop,M,EFSW,M,EFMM);
