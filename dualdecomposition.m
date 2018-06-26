function [num_ite,uti,price,xopt,price_trace,p1_trace,u_trace,u1_trace] = ... 
    dualdecomposition(budget,basedemand,capa,cap,step,tol)
% work with one Fog node M=1 only
[N, R] = size(basedemand)
% a : NxR
B = budget;
c = capa ;
a = basedemand
uti_cap = cap;
ptrace = []; utrace = []; u1trace = [];p1trace = [];
ite = 0;

%p = zeros(1,R);
%p = sum(budget)*ones(1,R);
p = ones(1,R);
terminate = 1;
x = zeros(N,R);u =zeros(1,N); uti_old = 0; uti_new=0;
maxIte = 10000;
while 1
    ite = ite + 1
    p1trace = [p1trace;p(1)];
    ptrace = [ptrace;p];
    u1trace = [u1trace;u(1)];
    uti_old = uti_new;
    %utrace = [utrace;uti_new];
    for i = 1:N
        [x(i,:),u(i)] = subprobemclosedform(budget(i),a(i,:),p,cap(i));
    end
    uti_new = log(u)*B';
    utrace = [utrace;u];
    demand = sum(x);
    surplus = capa - demand
    p = p - step*surplus/sqrt(ite)
    %p = p - step*surplus
    p = max(p,0)
    asurplus = abs(surplus); 
    gap = max(asurplus);
    gap = abs(uti_new - uti_old)
    if gap < tol || ite > maxIte
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
xopt = x;
price = p;
uti = u;
num_ite = ite;
price_trace = ptrace;
p1_trace = p1trace;
u_trace = utrace;
u1_trace = u1trace;

%     % do sth
%     ite = ite + 1;
%     u_old = u;
%     if ite == 1
%         uti_old = 0;
%     else
%         uti_old = uti_new;
%     end
%     for i = 1:N
%         [x(i,:),u(i)] = subprobemclosedform(budget(i),a(i,:),p,cap(i));
%     end
%     demand = sum(x);
%     surplus = capa - demand
%     asurplus = abs(surplus); 
%     gap = max(asurplus);  
% %     if gap > tol
% %         p = p - step*surplus;
% %         for r=1:R
% %             p(r) = max(p(r),0);
% %         end
% %         p
% %     else 
%     p_old = p;
%     p
%     p_new = p - step*surplus;
%     p_gap = abs(p_new-p_old)
%     gapp = max(p_gap)
%     B
%     u
%     uti_new = log(u)*B';
%     ugap = abs(uti_new - uti_old)
%     u_new = u;
%     udev = u_new - u_old;
%     gapu = abs(udev)
%     gap = max(u) 
%     if gap <tol
%         terminate = 0;
%     end