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


K = M*R; 
x_update = zeros(N,K);
%z_update = zeros(1,K);
%v_update = zeros(1,K);
%aveX = zeros(1,K); aveZ = zeros(1,K);
ite = 0;
x_old = ones(N,K)/N;
%x_old = rand(N,K);
aveX_old = sum(x_old)/N;
x_new = zeros(N,K);
%aveX_new = ones(1,K)/N;
aveX_new = aveX_old;

aveZ_old = ones(1,K)/N;
%aveZ_new = zeros(1,K);
aveZ_new = aveZ_old;

v_old = ones(1,K);
v_new = v_old;

uti = zeros(1,N);
price_trace =[];
u_trace = [];
gap1_trace = []; gap2_trace = [];
maxIte = 10000;

while 1
    ite = ite + 1
    aveX_new
    aveZ_new
    if ite > 1
        aveX_old = aveX_new;
        aveZ_old = aveZ_new;
        v_old = v_new;
        x_old = x_new;
    end
    v_old
    'test v_old value'
    [z_update,v_update] = admmSellerUpdate(v_old,aveX_new,rho,N);
    aveZ_new = z_update
    aveX_new
    v_new = v_update; 
    %%% X_UPDATE %%%%
    %%%%%%%%%%
    parfor i = 1:N
        [x_update(i,:),uti(i)] = ...
            admmBuyerUpdate(budget(i),base(i,:),cap(i),x_old(i),v_new,aveX_old,aveZ_new,rho,R);
    end
    uti
    u_trace = [u_trace;uti];
    x_new = x_update;    
    aveX_new = sum(x_new)/N 
    'test aveX_new value'

    %%%%% Z_UPDATE %%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%          

    aveX_new
    'test aveZ_new value'
     
    v_new
    'test v_new value'
    v_new*rho
    price_trace =[price_trace;v_new*rho]
    % gap1: Primal residual
    % gap2: Dual residual    

    gap1 = N*power(norm(aveZ_new - aveX_new),2)
    
    gap2 = power(rho,2)*power( norm(aveZ_new - aveZ_old),2)

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