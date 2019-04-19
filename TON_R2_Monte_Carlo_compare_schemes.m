clear all
%%%%%%%%%%%%%%%%%% DATA INPUT %%%%%%%%%%%%%%%%%%%%%

M1 = 100; N1 = 40; R = 3; M = 40; N = 8;
rev = ones(1,N1);
[capa1,capa2] = dataCapacity(M1);
% each FN is an Amazon EC2 instance
capacity = capa1; 
%[~,~,fullbasedemand,~] = generateBaseDemandVector(M1,R,N1,MM,N,capacity,rev);
%[M1, R, N1]  = size(fullbasedemand);
budget = ones(1,N);
cap = 600*ones(1,N); % cap is utility limit, change to a very big value for uncap case.
uncap = 1000000*ones(1,N);
 % change cap to bigM to get results for unlimited demand (no utility limit case)
capa = ones(M,R); % since basedemand is normalized 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


T = 50; % number of runs
u1 = zeros(T,N);u2=zeros(T,N);u3=zeros(T,N);
uprop = zeros(T,N);uprop1 = zeros(T,N);
SWu = zeros(T,N);SWu1 = zeros(T,N);MMu = zeros(T,N);MMu1 = zeros(T,N);
for t=1:T    
    [~,~,fullbasedemand,basedemand] = generateBaseDemandVector(M1,R,N1,M,N,capacity,rev);

    [p,utemp1,iu,x,demand] =  capLinearLeontief(budget,basedemand,capa,cap);
    u1(t,:) = utemp1';
    [p2,utemp2,iu2,x2,demand2] =  uncapLinearLeontief(budget,basedemand,capa);
    utemp3 =  min(utemp2,cap');
    u2(t,:) = utemp2';
    u3(t,:) = utemp3';
    % when uncap, u1=u2
    [MMp, MMutemp, MMiu, MMx] = MMF(budget,basedemand,capa,cap);
    MMu(t,:) = MMutemp';
    [MMp1, MMutemp1, MMiu1, MMx1] = MMF(budget,basedemand,capa,uncap);
    MMu1(t,:) = MMutemp1';
    [xprop,uproptemp] = proportionalSharing(budget,basedemand,capa,cap);
    uprop(t,:) = uproptemp';
    [xprop1,uproptemp1] = proportionalSharing(budget,basedemand,capa,uncap);
    uprop1(t,:) = uproptemp1';
    [SWp,SWutemp,SWiu,SWx] = SWM(budget,basedemand,capa,cap);
    SWu(t,:) = SWutemp';
    [SWp1,SWutemp1,SWiu1,SWx1] = SWM(budget,basedemand,capa,uncap);
    SWu1(t,:) = SWutemp1';
end
 



u=[mean(u2)' mean(u2)' mean(uprop1)' mean(SWu1)' mean(MMu1)'];
bar(u)

% uuu1 = [u2 u2 uprop1 SWu1  MMu1]
% bar(uuu1)
uuu=[mean(u1)' mean(u3)' mean(uprop)' mean(SWu)' mean(MMu)'];
bar(uuu)
% uuu = [u1 u3 uprop SWu MMu];
% bar(uuu)

%%%% uncap no limit %%%%%%%%%%%%
h1 = {u2;u2;uprop1;SWu1;MMu1}; % Create a cell array with the data for each group

aboxplot(h1,'labels',[1,2,3,4,5,6,7,8]); % Advanced box plot

xlabel('Buyer')
ylabel('Utility');
legend('GEG','EG','PROP','SWM','MM');

%%% utility limit %%%%%%
h = {u1;u3;uprop;SWu;MMu}; % Create a cell array with the data for each group

aboxplot(h,'labels',[1,2,3,4,5,6,7,8]); % Advanced box plot

xlabel('Buyer')
ylabel('Utility');
legend('GEG','EG','PROP','SWM','MM');


