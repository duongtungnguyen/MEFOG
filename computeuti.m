function uti = computeuti(base,x,cap)
temp1 = x./base;
temp1=temp1';
temp2 = min(temp1);
uti = sum(temp2);
uti = min(uti,cap);