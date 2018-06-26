function [price,xopt,vopt,uti] = additivecapa(budget,basedemand,capa)
% inputs: 
% - c: capacity of resource vector
% - B: budget vector (B1,B2,...,Bn)
% - a: NxM matrix . row (ai1,ai2,..,aiM) is the bundle agent i wants
% Output: 
% - x: allocation matrix, xij portion of good j to agent i.
[N,M] = size(a);
% Bmin = min(B);
% B = B/Bmin;
cvx_begin
%     cvx_solver SDPT3 
%     cvx_save_prefs
    variable x(N,M)
    variable u(N)
    dual variable y{M}
    maximize(B*log(u))
    subject to
        for i=1:N
            u(i) <= sum(a(i,:)*x(i,:)');
        end
        for j=1:M
            sum(x(:,j)) <= 1 : y{j};
        end
        x >= 0    
cvx_end
xopt = x;
vopt = B*log(u);
price = y;
uti = u;