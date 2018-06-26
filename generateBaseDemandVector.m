


function [data1,data2,data3,data4] = generateBaseDemandVector(M1,R,N1,M,N,capa,rev)
% This function generates base demand vectors (BDV) assuming that a service has
% the same base demand vectors at different FNs. Different services can
% have different BDVs.


%%%%%%%%%%%%%%%%%%%%%%%%%%%------------%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Demand of a service for a resource type at an FN is selected randomly
% between [0, ratio]. For example, if ratio = 5, R = 3 resource types, a
% base demand vector can be [2 4 1], [5 2 4],...
% ratio is the ratio between the highest resource demand and the lowest
% e.g., if ratio = 5, demand for any resource type must be in the range of
% [1,5]., e.g., (3,5,2). 3CPU cores, 5 GB RAM, 2Gbps BW to handle 1 unit of
% requests (e.g., 100 requests). => actual BDV is (3,5,2)/100 for
% handling 1 request.


%%%%%%%%%%%%%%%%%%%%%%%%%%%------------%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a base demand vector is the resource required to handle one request unit 
% (e.g., 1000 requests).

%%%%%%%%%%%%%%%%%%%%%%%%%%%------------%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% M1 : # FNs, N1: # services; R: # resource types
% M: first M FNs, M <= M1;  N: first N services, N < =N1
% (e.g., M1 = 100; N1 = 100; M = 10, N = 4 in the paper).

% nozero (default 1): indicator of allowing demand for a resource type to be 0 or not. 
% e.g., (1 3 0 2) => no demand for resource type 3. then, nonzero = 0;

% data1 full dataset.
% data2 includes data of M x N first nodes and services.
% data1 and data2 are not normalized. original base demand vectors.
% e.g. [0.2GB RAM 0.5CPU core 50MBps BW)

% data3 and data4 include BDVs that are NORMALIZED according to the resource capacities
% e.g., [0.1 0.15 0.25] => 10% resource type 1, 15% resource type 2, 25%
% resource type 3 of an FN to handle one request unit % (e.g., 100 requests).

% i, j, r: service, node, and resource type index

% basedemand for CPU: [0.1 0.5]
% basedemand for RAM: [0.4 0.2]
% basedemand for BW: [10 50];
temp = zeros(1,R);
for i = 1:N1
    %basedemand(:,:,i) = randi(ratio,M, R);
    if i == 1
        temp(1) = randi(5,1)/10;
        temp(2) = 4*randi(5,1)/10;
        temp(3) = randi(5,1)*10;
        basedemand = repmat(temp,[M1 1]);
    else
        temp(1) = randi(5,1)/10;
        temp(2) = 4*randi(5,1)/10;
        temp(3) = randi(10,1)*10;
        temp1 = repmat(temp,[M1 1]);
        basedemand = cat(3, basedemand,temp1);
    end
end


%%% normalize basedemand according to capacity and revenue/request.
base = zeros(M1,R,N1);

for j=1:M1
    for r=1:R
        for i=1:N1
            base(j,r,i) = basedemand(j,r,i)/(capa(j,r)*rev(i));
            %base(j,r,i) = basedemand(j,r,i)
            %'hahaha'
        end
    end
end


data1 = basedemand;
data2 = basedemand(1:M,:,1:N);
data3 = base;
data4 = base(1:M,:,1:N);