function A = matrix2vector(B)
% convert an MxR matrix to a 1x(MxR) vector
% a row of B is a resource vector of 1 node.
B = B'; % write MxR into RxM each colum for one node.
A = reshape(B,[],1);
A = A';

% A = 1:10;
% B = reshape(A,[5,2])