function [xopt,uti] = subprob(budget,basedemand,price,maxu)
d = basedemand; B= budget;p=price;
M = length(d);
cvx_begin
%     cvx_solver SDPT3
%     cvx_save_prefs
    variable x(M)
    variable u
    maximize(B*log(u) - p*x)
    subject to
        for i = 1:M
            u <= x(i)/d(i);
        end
        u < maxu
        x >= 0
cvx_end
uti = u; 
xopt = x;
    
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