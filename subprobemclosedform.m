function [xtemp,utemp] = subprobemclosedform(ibudget,ibasedemand,price,icap)
% ibudget: scalar, ibasedemand MxR, icap: scalar, price : MxR.
d = ibasedemand; B= ibudget;p=price;
[M, R] = size(d);
temp = price*d';
u1 = B/temp;
utemp = min(u1,icap);
xtemp = utemp*d;

