% base demand vectors
% M : # FNs, N: # users/services; R: # resource types
% ratio is the maximum ratio between highest resource demand and lowest
% nozero: if allow a demand for a resource to be 0 or not. e.g., (1 3 0 2)
% no demand for storage.
% resource demand.
% data2 includes data of M x N first buyers and nodes.
% NORMALIZED resource capacities
function [data1,data2,data3,data4] = generateDataFixedProportion2(M1,R,N1,ratio,M,N,nozero,capa,rev)
%base = randi(5,
% i, j, r: buyer, node, and resource type index
for i = 1:N1
    %basedemand(:,:,i) = randi(ratio,M, R);
    if i == 1
        if nozero
            temp = randi(ratio,1,R);
        else
            temp = randi(ratio+1,1,R) - 1;
        end
        basedemand = repmat(temp,[M1 1]);
    else
        if nozero
            temp = randi(ratio,1,R);
        else
            temp = randi(ratio+1,1,R)-1;
        end
        temp1 = repmat(temp,[M1 1]);
        basedemand = cat(3, basedemand,temp1);
    end
end
%basedemand
%%% normalize basedemand according to capacity and rev.
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