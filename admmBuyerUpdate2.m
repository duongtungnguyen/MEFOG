function [x_update,uti] = admmBuyerUpdate2(ibudget,ibasedemand,icap,x_old,z_old,v_old,rho,R)
% ibasedemand, p, aveX,y are  1x(RxM)-vectors
%[M,R ] = size(p);
%K = M*R;
K  = length(ibasedemand);
B = ibudget;
a = ibasedemand; %%% a is a vector
% v has relationship (can be computed from price vector)
%a = matrix2vector(ibasedemand); % 1x(RxM) vector. should convert before
%calling this function
%p = matrix2vector(p);
% aveV is a 1x(RxM) vector
% v_i is dual associated with x_i - z_i. we show that v_i = v, for all i.


% Note that aveZ = y/N and v = u/N in Baochun Li's paper. ;
%d = d/N;
cvx_begin
    variable x(K)
    variable u
    %variable uu
    variable iu(K)
    %minimize(-B*log(u) + rho/2*pow_pos(norm(x' - x_old + aveX - aveZ +  v),2))
    %minimize(-B*log(u) + rho/2*sum_square(x' - x_old  + aveX - aveZ +  v ) )
    minimize(-B*log(u) + rho/2*pow_pos(norm(x' - z_old +  v_old),2))

    subject to
        u == sum(iu);
        for k=1:K
            if mod(k,R) == 1
                iu(k) == x(k)/a(k);
                for j = 1:(R-1)
                    x(k+j)/a(k+j) == iu(k);
                end
            else
                iu(k) == 0;
            end
        end
        %uu == pow_pos(norm(x' - x_old + d),2);
        u <= icap;
        x >= 0;                
cvx_end
x_update = x';
%x_matrix = vector2matrix(x_vec);
uti = u;