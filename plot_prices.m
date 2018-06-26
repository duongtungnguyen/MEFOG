clear all



%%%%%%%%%%%%%%%%%% DATA INPUT %%%%%%%%%%%%%%%%%%%%%
[~, ~, fullbasedemand] = dataTON_v1();
M  = 40; n1 = 8; n2 = 40; R = 3;
basedemand1 = fullbasedemand(1:M,:,1:n1);
basedemand2 = fullbasedemand(1:M,:,1:n2);


cap1 = 600*ones(1,n1); % cap is utility limit
cap2 = 600*ones(1,n2); % cap is utility limit
capa = ones(M,R); % since basedemand is normalized 


budget1 = ones(1,n1);

budget2 = ones(1,n2);


[p1,u1,iu1,x1,demand1] =  capLinearLeontief(budget1,basedemand1,capa,cap1);

[p2,u2,iu2,x2,demand2] =  capLinearLeontief(budget2,basedemand2,capa,cap2);


%[p3,u3,iu3,x3,demand3] =  uncapLinearLeontief(budget,basedemand,capa);
%[p4,u4,iu4,x4,demand4] =  uncapLinearLeontief(budget,basedemand,capa);
pp1= p1(1:5,:)
pp2 = p2(1:5,:)
bar(pp1)
bar(pp2)

