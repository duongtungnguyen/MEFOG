function [envy1,uti,iEF,EF] = computeEFindex(budget,basedemand,capa,cap,x)
[M, R , N] = size(basedemand);
B = budget; a = basedemand; c = capa ;a = basedemand; uti_cap = cap;
uti = zeros(N,N);
envy1 = zeros(N,N);
envy = zeros(1,N);
bigM = 10^10;

for i=1:N
    for ii=1:N
        temp = zeros(1,M);
        for j=1:M
            temp(j) = min(B(i)/B(ii)*x(j,:,ii)./a(j,:,i));
        end
        uti(i,ii) = min(cap(i),sum(temp));
    end

    for j=1:N
        if uti(i,j)==0
            envy1(i,j) = bigM;
        else
            %envy1(i,j) = (B(j)/B(i))*(uti(i,i)/uti(i,j));
            envy1(i,j) = uti(i,i)/uti(i,j);
        end
    end
    envy(i) = min(envy1(i,:));
end

iEF = envy;
EF = min(envy);






            
            