clear all
%%%%%%%%%%%%%%%%%% DATA INPUT %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% DATA INPUT %%%%%%%%%%%%%%%%%%%%%
M1 = 100; N1 = 40; R = 3; MM = 40; N = 8;
rev = ones(1,N1);
[capa1,capa2] = dataCapacity(M1);
% each FN is an Amazon EC2 instance
capacity = capa1; 
%[~,~,fullbasedemand,~] = generateBaseDemandVector(M1,R,N1,MM,N,capacity,rev);
%[M1, R, N1]  = size(fullbasedemand);
budget = ones(1,N);
cap = 600*ones(1,N); % cap is utility limit, change to a very big value for uncap case.
uncap = 1000000*ones(1,N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = 50; % number of runs
M = 10:10:100;
L = length(M);

%uu1 = zeros(T,L); u1 = zeros(T,L);
%uprop = zeros(T,L); uSW = zeros(T,L); uMM = zeros(T,L);
 umax = zeros(1,N); umax1 = zeros(1,N);
 % ratio between actual utility and utility of get all resources 
% cap_r = zeros(L,N);
% uncap_r = zeros(L,N); prop_r =  zeros(L,N);
% SW_r = zeros(L,N); MM_r = zeros(L,N);
 
 %cap1=cap;
for t=1:T
    [~,~,fullbasedemand,~] = generateBaseDemandVector(M1,R,N1,MM,N,capacity,rev);

    for k=1:L
        basedemand = fullbasedemand(1:M(k),1:R,1:N);
        capa = ones(M(k),R);
        for i=1:N
            umax(i) = computeuti(basedemand(:,:,i),capa,cap(i));
        end
        
        % no cap
        for i=1:N
            umax1(i) = computeuti(basedemand(:,:,i),capa,uncap(i));
        end

        [~,u,~,~,~] =  uncapLinearLeontief(budget,basedemand,capa);
%        u = min(u,cap');
        uncap_r(k,:,t) = u'./umax1;

        [~,u1,~,~,~] =  capLinearLeontief(budget,basedemand,capa,cap);
        cap_r(k,:,t) = u1'./umax;
    end
end
M = M';
% plot(M,uncap_r(:,1),M,uncap_r(:,2),M,uncap_r(:,3),M,uncap_r(:,4));
% plot(M,cap_r(:,1),M,cap_r(:,2),M,cap_r(:,3),M,cap_r(:,4));

PR = mean(cap_r,3);
PRu = mean(uncap_r,3);
plot(M,PR(:,1),M,PR(:,2),M,PR(:,3),M,PR(:,4));
plot(M,PRu(:,1),M,PRu(:,2),M,PRu(:,3),M,PRu(:,4));


PR1 = []; PR2 = []; PR3 = [];PR4= [];
PR1u = []; PR2u = []; PR3u = [];PR4u = [];

for t = 1:T
    %
    PR1 = [PR1;cap_r(:,1,t)'];
    PR2 = [PR2;cap_r(:,2,t)'];
    PR3 = [PR3;cap_r(:,3,t)'];
    PR4 = [PR4;cap_r(:,4,t)'];
    
    PR1u = [PR1u;uncap_r(:,1,t)'];
    PR2u = [PR2u;uncap_r(:,2,t)'];
    PR3u = [PR3u;uncap_r(:,3,t)'];
    PR4u = [PR4u;uncap_r(:,4,t)'];
end

boxplot(PR1,M);
boxplot(PR2,M);
boxplot(PR3,M);
boxplot(PR4,M);

boxplot(PR1u,M);
boxplot(PR2u,M);
boxplot(PR3u,M);
boxplot(PR4u,M);
