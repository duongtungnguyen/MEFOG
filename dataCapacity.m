function [capa1,capa2] = dataCapacity(M)
R = 3;
% capa : M*R matrix, here R = 3;
% some M4 M5 AMAZON SERVERS: https://aws.amazon.com/ec2/instance-types/
% CPU cores, RAM(Mem), Bandwidth (mbps)
s = zeros(8,R); % 8 types of servers

s(1,:) = [8   32    2120];
s(2,:) = [4   16   750];
s(3,:) = [8   32   1000];
s(4,:) = [16  64   2000];
s(5,:) = [40  160  4000];
s(6,:) = [64  256  10000];
s(7,:) = [48  192  5000];
s(8,:) = [96  384  10000];

% for capa1, each FN is one Amazon server
capa1 = zeros(M,R);
for j = 1:M
    % generate type server type k
    k = randi(8,1);
    capa1(j,:) = s(k,:);
end

% for capa2, each FN contain a number of server of the same type.
% capa of each FN is the sum of all servers capa at that node
capa2 = zeros(M,R);
maxNum = 5; % maximum number of servers at an FN
num_servers = randi(maxNum,1,M); % vector of number of servers at FNs
for j = 1:M
    k = randi(8,1);
    capa2(j,:) = num_servers(j)*s(k,:);
end
