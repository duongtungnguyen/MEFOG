clear all
%%%%%%%%%%%%%%%%%% DATA INPUT %%%%%%%%%%%%%%%%%%%%%
[~, ~, fullbasedemand] = dataTON_v1();
%[M, R, N] = size(basedemand);
[M1, R, N1]  = size(fullbasedemand);

N = 8;


budget = ones(1,N);
cap = 600*ones(1,N); % cap is utility limit, change to very big value for uncap case.
%capa_normalized = ones(M,R); % since basedemand is normalized 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uncap = 1000000*ones(1,N);

M = 10:10:100;
L = length(M);
uu1 = zeros(1,L); u1 = zeros(1,L);
uprop = zeros(1,L); uSW = zeros(1,L); uMM = zeros(1,L);
EF1 = zeros(1,L); EF = zeros(1,L);  EFprop = zeros(1,L);  EFSW = zeros(1,L); 
EFMM = zeros(1,L); 
 

for k=1:L
    basedemand = fullbasedemand(1:M(k),1:R,1:N);
    capa = ones(M(k),R);
    [~,u,~,x,~] =  uncapLinearLeontief(budget,basedemand,capa)
    u = min(u,cap');
    uu1(k) = sum(u);
    [~,~,~,EF(k)] = computeEFindex(budget,basedemand,capa,cap,x)
    
    [~,temp1,~,x1,~] =  capLinearLeontief(budget,basedemand,capa,cap);
    u1(k) = sum(temp1);
    [~,~,~,EF1(k)] = computeEFindex(budget,basedemand,capa,cap,x1)
        
    [xprop,temp2] = proportionalSharing(budget,basedemand,capa,cap)
    uprop(k) = sum(temp2);    
    [~,~,~,EFprop(k)] = computeEFindex(budget,basedemand,capa,cap,xprop)

    
    [~,SWu1,~,xSW] = SWM(budget,basedemand,capa,cap)
    uSW(k) = sum(SWu1);
    [~,~,~,EFSW(k)] = computeEFindex(budget,basedemand,capa,cap,xSW)

    [~, MMu1, ~, mmx] = MMF(budget,basedemand,capa,cap)
    uMM(k) = sum(MMu1);
    [~,~,~,EFMM(k)] = computeEFindex(budget,basedemand,capa,cap,mmx)
end
M = M';
%plot(M,u1,M,uu1,M,uprop,M,uSW,M,uMM)
plot(M,EF1,M,EF,M,EFprop,M,EFSW,M,EFMM);
