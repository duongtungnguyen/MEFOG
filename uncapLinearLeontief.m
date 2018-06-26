function [price,uti,iuti,xopt,demand] =  uncapLinearLeontief(budget,basedemand,capa)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[M, R , N] = size(basedemand);
B = budget; a = basedemand; c = capa ;a = basedemand;
% a(:,:,2) : basedemand of buyer 2. e.g., 
% a(:,:,2) = (2 3 4 2; 2 1 2 3) where (2 3 4 2) is basedemand of buyer 2 at
% node 1 to achieve one unit of requests.
% M = size(basedemand,1); R = size(basedemand,2); N = size(basedemand,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
base = zeros(1,N);
cvx_begin
%     cvx_solver  SDPT3
%     cvx_save_prefs
    variable v(N,M)
    variable u(N)
    dual variable y{M,R}
    maximize(B*log(u))
    %maximize(sum(sum(u)))
    subject to
        u == sum(v,2);
        %u <= cap';
        for j =1:M
            for r=1:R
                for i=1:N
                    base(i) = a(j,r,i);
                end
               base*v(:,j) <= c(j,r)   : y{j,r} ;
                %a(j,r,:)*v(:,j) <= c(j,r)   : y{j,r} ;
            end
        end
        v >= 0;
cvx_end
uti = u;
iuti = v;
for i=1:N
    for j=1:M
        for r=1:R
            xopt(j,r,i) = v(i,j)*a(j,r,i);
        end
    end
end
price = cell2mat(y);
totalDemand = zeros(M,R);
for j=1:M
    for r = 1:R
        totalDemand(j,r) = sum(xopt(j,r,:));
    end
end
demand = totalDemand;