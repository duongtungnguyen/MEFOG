function [xopt,uti] = proportionality(budget,basedemand,capa,cap)
c = capa; a = basedemand; B = budget; uti_cap = cap;
[N,M]=size(basedemand);
for i=1:N
    for j=1:M
        xopt(i,j) = capa(j)*B(i)/sum(B);
    end
end

