clear all
% A = [1 2 4; 2 3 1];
% A(:,:,2) = [2 2 9; 1 8 5];
% A
% A(1,1,:) = [1 2 2]; A(1,2,:) = [2 3 9]; A(1,3,:) =[2 1 3]; A(1,4,:)=[9 8 1];
% A(2,1,:) = [1 12 2]; A(2,2,:) = [2 13 1]; A(2,3,:) =[12 11 3]; A(2,4,:)=[10 2 1];
% A
% A(:,1,1) = [1 2 2]; A(:,1,2) = [2 3 9]; A(:,1,3) =[2 1 3]; A(:,1,4)=[9 8 1];
% A(:,2,1) = [1 12 2]; A(:,2,2) = [2 13 1]; A(:,2,3) =[12 11 3]; A(:,2,4)=[10 2 1];
% A

% 2 BUYERS, 4 NODEs, 3 resource types
% base demand at node 1
A(:,:,1) = [1 2 2;2 3 4];
% base demand at node 2
A(:,:,2) = [2 3 9;2 1 3]; 
A(:,:,3)=[9 8 1;1 12 2];
A(:,:,4) = [2 13 1; 12 11 3];
A

% ANOTHER WAY IS to create data associated with every buyer
% basedemand of buyer 1 at node 1 is 1:2:2; at node 2 is 2:3:4
%A(:,:,1) = [1 2 2;2 3 4];
