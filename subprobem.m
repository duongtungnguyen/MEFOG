function [xtemp,utemp,iutemp] = subprobem(ibudget,ibasedemand,price,icap)
% ibudget: scalar, ibasedemand MxR, icap: scalar, price : MxR.
d = ibasedemand; B= ibudget;p=price;
[M, R] = size(d);
cvx_begin
%     cvx_solver SDPT3
%     cvx_save_prefs
    variable x(M,R)
    variable u
    variable v(M)
    % actually we not necessarily need variable x. experess obj in terms of
    % v and d is fine.
    maximize(B*log(u) - sum(sum(p.*x)))
    subject to
        u == sum(v);
        u <= icap;        
        for j = 1:M
            for r=1:R
                d(j,r)*v(j) == x(j,r);
            end
        end
        x >= 0;
        v >= 0;
cvx_end
utemp = u; 
xtemp = x;
iutemp = v;
    
% cvx_begin
%     cvx_solver SDPT3 
%     cvx_save_prefs
%     variable x(N,M)
%     variable u(N)
%     dual variable y{M}
%     maximize(B*log(u))
%     subject to
%         for i=1:N
%             for j = 1:M
%                 if a(i,j) > 0
%                     u(i) <= sum(x(i,j)/a(i,j));
%                 end
%             end
%         end
%         for j=1:M
%             sum(x(:,j)) <= 1 : y{j};
%         end
%         x >= 0    
% cvx_end
% xopt = x;
% vopt = B*log(u);
% price = cell2mat(y); p  =  price';
% uti = u;