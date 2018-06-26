function A = vector2matrix(B,M,R)
% convert an MxR matrix to a 1x(MxR) vector
B = B'; % B is 1x(MxR) vector. 
%A = reshape(B,[],M); % A should be a RxM matrix.
A = reshape(B,[R,M]);
A = A'; % MxR matrix