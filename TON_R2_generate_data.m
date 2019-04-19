[capa1,capa2] = dataCapacity(M1);
% each FN is an Amazon EC2 instance
capa = capa1; 
M1 = 100; N1 = 40; R = 3; M = 40; N = 8;
rev = ones(1,N1);

% data1 full basedemand dataset M1xN1.
% data2 includes data of M x N first nodes and services.
% data1 and data2 are not normalized (i.e., original base demand vectors).
% e.g. [0.2GB_RAM 0.5CPU_core 50MBps_BW)

% data3 is the normalized value of base demand vector 
% (i.e.,  a_{ijr} in the paper)
% data4 is a M*N matrix extracted from data3.

[data1,data2,data3,data4] = generateBaseDemandVector(M1,R,N1,M,N,capa,rev);
% fullbasedemandoriginal = data1;
% basedemandoriginal = data2;
% fullbasedemand = data3; normalized by capacity
% basedemand = data4;