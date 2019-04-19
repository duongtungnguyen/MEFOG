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
 umax = zeros(1,N);
 % ratio between actual utility and utility of get all resources 
 cap_r = zeros(L,N);
 uncap_r = zeros(L,N); prop_r =  zeros(L,N);
 SW_r = zeros(L,N); MM_r = zeros(L,N);
 
 %cap1=cap;
for k=1:L
    basedemand = fullbasedemand(1:M(k),1:R,1:N);
    capa = ones(M(k),R);
    for i=1:N
%         size(basedemand(:,:,i))
%         size(capa)
        umax(i) = computeuti(basedemand(:,:,i),capa,cap(i));
    end
    
    [~,u,~,~,~] =  uncapLinearLeontief(budget,basedemand,capa)
    u = min(u,cap');
    %uu1(k) = sum(u);
    %[~,~,~,EF(k)] = computeEFindex(budget1,basedemand,capa,cap1,x)
    uncap_r(k,:) = u'./umax;
    
    
    [~,u1,~,~,~] =  capLinearLeontief(budget,basedemand,capa,cap);
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

