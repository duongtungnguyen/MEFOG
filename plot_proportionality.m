
clear all
M1 = 50; R = 5; N1 = 50;
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
%budget1 = [1 1 2 6];

M = 2:2:40;
L = length(M);
uu1 = zeros(1,L); u1 = zeros(1,L);
uprop = zeros(1,L); uSW = zeros(1,L); uMM = zeros(1,L);

EF1 = zeros(1,L); EF = zeros(1,L);  EFprop = zeros(1,L);  EFSW = zeros(1,L); 
 EFMM = zeros(1,L);
 umax = zeros(1,N);
 % ratio between actual utility and utility of get all resources 
 cap_r = zeros(L,N);
 uncap_r = zeros(L,N); prop_r =  zeros(L,N);
 SW_r = zeros(L,N); MM_r = zeros(L,N);
 
 %cap1=cap;
for k=1:L
    basedemand = demand(1:M(k),1:R,1:N);
    capa = ones(M(k),R);
    for i=1:N
%         size(basedemand(:,:,i))
%         size(capa)
        umax(i) = computeuti(basedemand(:,:,i),capa,cap1(i));
    end
    
    [~,u,~,~,~] =  uncapLinearLeontief(budget1,basedemand,capa,cap)
    u = min(u,cap1');
    %uu1(k) = sum(u);
    %[~,~,~,EF(k)] = computeEFindex(budget1,basedemand,capa,cap1,x)
    uncap_r(k,:) = u'./umax;
    
    
    [~,u1,~,~,~] =  capLinearLeontief(budget1,basedemand,capa,cap1);
    cap_r(k,:) = u1'./umax;
% 
%     [~,uprop1] = proportionalSharing(budget1,basedemand,capa,cap1)
%     prop_r(k,:) =  uprop1'./umax; 
% 
%     [~,SWu1,~,~] = SWM(budget1,basedemand,capa,cap1)
%     SW_r(k,:) = SWu1'./umax;
%     
%     [~, MMu1, ~, mmx] = MMF(budget1,basedemand,capa,cap1)
%     MM_r(k,:) = MMu1'./umax;
end
M = M';

% plot(M,cap_r(:,1),M,uncap_r(:,1),M,prop_r(:,1),M,SW_r(:,1),M,MM_r(:,1));
% plot(M,cap_r(:,2),M,uncap_r(:,2),M,prop_r(:,2),M,SW_r(:,2),M,MM_r(:,3));
% plot(M,cap_r(:,4),M,uncap_r(:,4),M,prop_r(:,4),M,SW_r(:,4),M,MM_r(:,4));
% plot(M,cap_r(:,3),M,uncap_r(:,3),M,prop_r(:,3),M,SW_r(:,1),M,MM_r(:,3));
% 
% ave_cap_r = sum(cap_r,2)/N; ave_uncap_r = sum(uncap_r,2)/N; 
% ave_prop_r = sum(prop_r,2)/N; ave_SW_r = sum(SW_r,2)/N; ave_MM_r = sum(MM_r,2)/N;
% plot(M,ave_cap_r,M,ave_uncap_r,M,ave_prop_r,M,ave_SW_r,M,ave_MM_r);


plot(M,uncap_r(:,1),M,uncap_r(:,2),M,uncap_r(:,3),M,uncap_r(:,4));
plot(M,cap_r(:,1),M,cap_r(:,2),M,cap_r(:,3),M,cap_r(:,4));

