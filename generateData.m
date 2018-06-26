% base demand vectors
% M : # FNs, N: # users/services; R: # resource types
% ratio is the maximum ratio between highest resource demand and lowest
% resource demand.
% data2 includes data of M x N first buyers and nodes. 
function [data1,data2] = generateData(M1,R,N1,ratio,M,N,nozero)
%base = randi(5,
% i, j, r: buyer, node, and resource type index
for i = 1:N1
    %basedemand(:,:,i) = randi(ratio,M, R);
    if i == 1
        if nozero
            basedemand = randi(ratio,M1,R);
        else
            basedemand = randi(ratio+1,M1,R) - 1;
        end            
    else
        if nozero
            basedemand = cat(3, basedemand,randi(ratio,M1,R));
        else
            basedemand = cat(3, basedemand,randi(ratio+1,M1,R));
        end
    end
end
data1 = basedemand;
data2 = basedemand(1:M,:,1:N);