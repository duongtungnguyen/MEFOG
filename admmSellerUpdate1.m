function [z_update,v_update] = admmSellerUpdate1(v,x,rho)

[N,K] = size(x);

cvx_begin
    variable z(N,K)
    variable u
    %variable iu(N)
    %minimize( N*rho/2*pow_pos( norm(z' - v - aveX) ,2)  )
    %minimize( N*rho/2*sum_square(z' - v - aveX) )
    %minimize( rho/2*sum( sum_square( z - repmat(v,N,1) - x))  )
    minimize( rho/2*sum( sum_square( z - v - x))  )

    subject to
%         u == sum(iu);
%         for i =1:N
%             iu(i) == pow_pos( norm(z(i,:) - v(i,:)- x(i,:)),2);
%         end
        sum(z) <= 1;
        z >= 0;
cvx_end

v_new = v  + x - z;
v_new = max(v_new,0);

%v_update = max(v_new,0);
v_update = v_new;
z_update = z;


