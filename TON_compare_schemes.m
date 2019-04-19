clear all



%%%%%%%%%%%%%%%%%% DATA INPUT %%%%%%%%%%%%%%%%%%%%%
[~, capa, fullbasedemand] = dataTON_v1();
M  = 40; N = 8;
basedemand = fullbasedemand(1:M,:,1:N);
[M, R, N] = size(basedemand);
K = M*R;
budget = ones(1,N);
cap = 600*ones(1,N); % cap is utility limit
 % change cap to bigM to get results for unlimited demand (no utility limit case)
capa_normalized = ones(M,R); % since basedemand is normalized 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uncap = 1000000*ones(1,N);
[p,u,iu,x,demand] =  capLinearLeontief(budget,basedemand,capa_normalized,cap);


[p2,u2,iu2,x2,demand2] =  uncapLinearLeontief(budget,basedemand,capa_normalized);

u3 =  min(u2,cap');
% when uncap, u=u2
[MMp, MMu, MMiu, MMx] = MMF(budget,basedemand,capa_normalized,cap)
[MMp1, MMu1, MMiu1, MMx1] = MMF(budget,basedemand,capa_normalized,uncap)

[xprop,uprop] = proportionalSharing(budget,basedemand,capa_normalized,cap)
[xprop1,uprop1] = proportionalSharing(budget,basedemand,capa_normalized,uncap)

% SWmax is for one FN only.
[SWp,SWu,SWiu,SWx] = SWM(budget,basedemand,capa_normalized,cap)
 [SWp1,SWu1,SWiu1,SWx1] = SWM(budget,basedemand,capa_normalized,uncap)
 
 
 uuu1 = [u2 u2 uprop1 SWu1  MMu1]
bar(uuu1)

uuu = [u u3 uprop SWu MMu];
bar(uuu)
legend('off')
legend('show')