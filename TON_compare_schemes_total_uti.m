clear all




%%%%%%%%%%%%%%%%%% DATA INPUT %%%%%%%%%%%%%%%%%%%%%
[~, capa, fullbasedemand] = dataTON_v1();
%basedemand = basedemand(:,:,1:8);
%[M, R, N] = size(basedemand);
[M1, R, N1]  = size(fullbasedemand);
%K = M*R;
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
%cap1=cap;
tic
parfor k=1:L
    basedemand = fullbasedemand(1:M(k),1:R,1:N);
    capa_normalized = ones(M(k),R);
    %capa = ones(M(k),R);
    [~,u,~,~,~] =  uncapLinearLeontief(budget,basedemand,capa_normalized)
    u = min(u,cap');
    uu1(k) = sum(u);
    
    [~,temp1,~,~,~] =  capLinearLeontief(budget,basedemand,capa_normalized,cap);
    u1(k) = sum(temp1);
    
    [~,temp2] = proportionalSharing(budget,basedemand,capa_normalized,cap)
    uprop(k) = sum(temp2);    
    
    [~,SWu1,~,~] = SWM(budget,basedemand,capa_normalized,cap)
    uSW(k) = sum(SWu1);
    
    [~, MMu1, ~, ~] = MMF(budget,basedemand,capa_normalized,cap)
    uMM(k) = sum(MMu1);
end
toc
M = M';
plot(M,u1,M,uu1,M,uprop,M,uSW,M,uMM)