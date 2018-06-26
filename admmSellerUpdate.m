function [z_update,v_update] = admmSellerUpdate(v,X_ave,rho,N)

K = length(X_ave);

cvx_begin
    variable z(K)
    minimize( N*rho/2*pow_pos( norm(z' - v - X_ave) ,2)  )
    %minimize( N*rho/2*sum_square(z' - v - X_ave) )
    subject to
        N*z <= 1;
        z >= 0;
cvx_end



%v_new = v  + X_ave - z';
%v_new = max(v_new,0);

%v_update = max(v_new,0);
%v_update = v_new;
v_update = v  + X_ave - z';
v_update = max(v_update,0);
z_update = z';

