function [num_ite,p,u,x,x_vector,gap1_trace,gap2_trace,uti_trace,p_trace] = ...
    admmcapLinearLeontief(budget,basedemand,capa,cap,rho,tol1,tol2)

[M, R , N] = size(basedemand);
B = budget; a = basedemand; c = capa ;a = basedemand; uti_cap = cap;

% convergence criterion (p.18.Boyd): 
% primal residual: r(k) = Ax(k) + Bz(k) - c
% dual residual  s(k) = rho * A^T * B (z(k) - z(k-1)). In fact, convergence
% proof shows B(z(k+1)-z(k)) converges to zero, which implies s(k)
% converges to zero. 
% stopping criteria: ||r(k)||_norm2 <= tol1, ||s(k)||^2 < = tol2. tol1,
% tol2 chosen as page 19.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% As with all problems where the constraint is x ? z = 0, the primal
% and dual residuals take the simple form
% r(k) =  x(k) - z(k); s(k) = -rho(z(k) - z(k-1)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%% convert individual demand vectors from basedemand matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K=M*R;
base = zeros(N,K);
for i =1:N
    ibase = basedemand(:,:,i);
    base(i,:) = matrix2vector(ibase);
end

x_update = zeros(N,K);

ite = 0;
x_old = ones(N,K)/N;
x_new = x_old;
aveX_old = sum(x_old)/N;
aveX_new = aveX_old;

aveZ_old = ones(1,K)/N;
aveZ_new = aveZ_old;

v_old = ones(1,K);
v_new = v_old;

uti = zeros(1,N);
price_trace =[];
u_trace = [];
gap1_trace = []; gap2_trace = [];
maxIte = 1000;

while 1
    ite = ite + 1
%     aveX_new
%     aveZ_new
    if ite > 1
        aveX_old = aveX_new;
        aveZ_old = aveZ_new;
        v_old = v_new;
        x_old = x_new;
    end
 
    %%% X_UPDATE %%%%
    %%%%%%%%%%
    parfor i = 1:N
        [x_update(i,:),uti(i)] = ...
            admmBuyerUpdate(budget(i),base(i,:),cap(i),x_old(i,:),v_old,aveX_old,aveZ_old,rho,R);
    end
    %uti;
    u_trace = [u_trace;uti]
    x_new = x_update ;   
    aveX_new = sum(x_new)/N ;
    %'test aveX_new value'

    %%%%% Z_UPDATE %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
    [z_update,v_update] = admmSellerUpdate(v_old,aveX_new,rho,N);
    aveZ_new = z_update
    aveX_new
    %'test aveZ_new value'
    v_new = v_update;  
    %v_new
    %'test v_new value'
    %v_new*rho
    price_trace =[price_trace;v_new*rho];
    % gap1: Primal residual
    % gap2: Dual residual
    
    %gap1 = 0;
%     for i=1:N
%         %gap1 = gap1  + power( norm(x_new(i,:) - aveZ_new), 2);
%         % z_i(k+1) = u(k) + x_i(k+1) + aveZ(k+1) - u(k) - aveX(k+1)
%         % z_i(k) = u(k-1) + x_i(k) + aveZ(k) - u(k-1) - aveX(k) 
%         % z_i(k) = x_i(k) +aveZ(k) - aveX(k);
%         % x_i(k) - z_i(k) = aveZ(k) - aveX(k);
%                
%     end
%    gap1 = N*power(norm(aveZ_new - aveX_new),2)
    gap1 = sqrt(N)*norm(aveZ_new - aveX_new)
    %gap1 = N*power(norm(v_new - v_old),2)
    %gap1 = sum(sum_square((x_new - z_new)'))

    
%    gap2 = power(rho,2)*power( norm(aveZ_new - aveZ_old),2)
    gap2 = rho*norm(aveZ_new - aveZ_old)
    %gap2 = power(rho,2)*sum( sum_square(z_new - z_old))

    gap1_trace = [gap1_trace, gap1]
    gap2_trace = [gap2_trace, gap2]
    if (gap1 < tol1 && gap2 < tol2 )  || ite > maxIte
        if ite > maxIte
            'Too many iterations! STOP !!!'
            break
        else
            'Successful! Converegence!!! Total iterations: '
            ite            
            break
        end
    end
    gap1
    gap2
end
num_ite = ite;
x_vector = x_new;

% xx = reshape(x_vector',R,M,N);
% x = zeros(M,R,N);
% for i=1:N
%     x(:,:,i) = xx(:,:,i)';
% end
% 
x=zeros(M,R,N);
for i=1:N
    temp = x_vector(i,:);
    x(:,:,i) = reshape(temp,R,M)';
end

p_trace = price_trace;
u = uti;
uti_trace = u_trace;
p = v_new*rho;