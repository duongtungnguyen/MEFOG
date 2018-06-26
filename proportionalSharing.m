function [xprop,uprop] = proportionalSharing(budget,basedemand,capa,cap)
B = budget;
c = capa; a = basedemand;
[M, R, N]  = size(basedemand);
sumB = sum(B);
x = zeros(M,R,N);
for j=1:M
    for r=1:R
        for i=1:N
            x(j,r,i) = c(j,r)*B(i)/sumB;
        end
    end
end
%u = zeros(1,N);
bigM = 1000000;
u = bigM*ones(1,N);
v = zeros(N,M);
temp = zeros(1,R);

for i=1:N
    base = a(:,:,i);
    xx = x(:,:,i);
    for j=1:M
        uti(j) = min(xx(j,:)./base(j,:));
    end
    u(i) = sum(uti);
end
for i=1:N
    u(i)=min(u(i),cap(i));
end
xprop = x; uprop = u';





% for i=1:N
%     for j=1:M
%         for r=1:R
%             if a(j,r,i) > 0
%                 temp(r) = x(j,r,i)/a(j,r,i);
%             else 
%                 temp(r) = 0;
%             end
%         end
%         v(i,j) = min(temp
            
        
% for i=1:N
%     for j=1:M
%         for r=1:R
%             if a(j,r,i) > 0
%                 temp = x(j,r,i)/a(j,r,i)
%                 u
%                 if  u(i) > temp  && temp > 0
%                     u(i) = temp
%                 end
%                 temp2 = u(i)
%                 u
% %             else 
% %                 temp = 0;
% %             end
% %             if temp > 0 && u(i) > temp  
% %                 u(i) = temp;
%             end
%         end
%     end
% end


