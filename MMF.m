function [MMp, MMu, MMiu, MMx] = MMF(budget,basedemand,capa,cap)
c = capa; a = basedemand; B = budget; uti_cap = cap;
[M,R,N]=size(basedemand);

cvx_begin
%     cvx_solver SDPT3 
%     cvx_save_prefs
    variable u(N)
    variable uu
    variable v(N,M)
    variable x(M,R,N)
    dual variable y{M,R}
    maximize(uu)
    subject to
        for i = 1:N
            uu <= u(i)/B(i);
        end
        u == sum(v,2);
        u <= cap';  
        for i = 1:N
            for j=1:M
                for r=1:R
                    a(j,r,i)*v(i,j) <= x(j,r,i);
                end
            end
        end
        for j=1:M
            for r=1:R
%                 for i=1:N
%                     temp(i) == x(j,r,i);
%                 end               
                sum(x(j,r,:)) <= c(j,r) : y{j,r};
            end            
        end
        x >= 0 ;     
        v >= 0;        
cvx_end
MMx = x; 
%MMu = u; 
for i=1:N
    MMu(i)=min(u(i),cap(i));
end
MMu = MMu';
MMiu = v; MMp = y;