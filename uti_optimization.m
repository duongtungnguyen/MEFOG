function [xopt,uti] = uti_optimization(budget,basedemand,capa,cap)
B = budget; a = basedemand; 
[N,R] = size(a);
M = length(capa);

cvx_begin
    cvx_solver SDPT3
    cvx_save_prefs
    variable u(N,M)
    variable v(N)
    maximize(B*log(v))
    subjec to
        v == sum(u,2)
        v <= cap'
        for j=1:M
            for r=1:R
                a(:,r)*u(:,j) <= 1
            end
        end
        u >= 0
cvx_end
uti = u; xopt=0;

cvx_end