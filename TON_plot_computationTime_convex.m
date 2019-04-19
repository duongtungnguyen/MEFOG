%clear all
M1 = 200; R = 3; N1 = 1000;
%M = 10; 
%N = [2,5,10,20,30,40,50,60,70,80,90,100,200,300,400,500,600,800,1000]; 
N = [2,5,10,20,30,40,50,60,70,80,90,100,200,300,400,500,600,800,1000]; 
%N = [300,400,500,600,800,1000]; 
nozero=1; 
M = [5,10,20,40,80,100,150,200];
rev = ones(1,N1);

[capa1,capa2] = dataCapacity(M1);

n = length(N); m = length(M);
compTime = zeros(n,m);
L = 10;
%temp = zeros(1,L);

for i=1:n
    for j=1:m
        temp = zeros(1,L);
        for l=1:L
            [data1,data2,data3,data4] = generateBaseDemandVector(M1,R,N1,M(j),N(i),capa1,rev);
            % data1 full dataset.
            % data2 includes data of M x N first nodes and services.
            % data1 and data2 are not normalized. original base demand vectors.
            % e.g. [0.2GB RAM 0.5CPU core 50MBps BW)

            % data3 and data4 include BDVs that are NORMALIZED according to the resource capacities
            % e.g., [0.1 0.15 0.25] => 10% resource type 1, 15% resource type 2, 25%
            % resource type 3 of an FN to handle one request unit % (e.g., 100 requests).

            % use data4 in paper.
            %x
            basedemand = data4;  capa = ones(M(j),R);  %budget = ones(1,N);
            %budget = randi(50,1,N);
            budget = ones(1,N(i));
            cap = 10000*ones(1,N(i));
            size(basedemand)

            %     [~,u,~,x,~] =  uncapLinearLeontief(budget,basedemand,capa)
            %     u = min(u,cap');

            %[envy1,uti,iEF,EF] = computeEFindex(budget,basedemand,capa,cap,x)
            tic
            [p1,u1,iu1,x1,demand1] =  capLinearLeontief(budget,basedemand,capa,cap);
            p1;
            u1;
            temp(l) = toc
        end
        compTime(i,j) = sum(temp)/L
    end
end
csvwrite('comptimeMosekAverage2.csv',compTime);
plot(N,compTime(:,1),N,compTime(:,2),N,compTime(:,3),N,compTime(:,4),N,compTime(:,5),N,compTime(:,6),N,compTime(:,7),N,compTime(:,8));

