function [p,xopt,vopt,uti] = EG_linear_leontief(budget,basedemand,basedemand2,capa)
c = capa; a = basedemand; aa=basedemand2; B = budget; 
% inputs: 
% - c: capacity of resource vector
% - B: budget vector (B1,B2,...,Bn)
% - a: NxM matrix . row (ai1,ai2,..,aiM) is the bundle agent i wants
% Output: 
% - x: allocation matrix, xij portion of good j to agent i.
% N: number of buyers; M: number of goods.
[N,M] = size(a);
% Bmin = min(B);
% B = B/Bmin;
cvx_begin
    cvx_solver SDPT3 
    cvx_save_prefs
    variable x(N,M)
    variable u(N)
    variable v(N)
    dual variable y{M}
    maximize(B*log(u+v))
    subject to
        for i=1:N
            for j = 1:M
                if a(i,j) > 0
                    u(i) <= sum(x(i,j)/a(i,j));
                    v(i) <= sum(x(i,j)/aa(i,j));
                end
            end
        end
        for j=1:M
            sum(x(:,j)) <= 1 : y{j};
        end
        x >= 0    
cvx_end
xopt = x;
vopt = B*log(u);
price = cell2mat(y); p =  price';
uti = u;