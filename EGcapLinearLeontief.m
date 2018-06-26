function [price,uti,iuti,xopt,demand] =  EGcapLinearLeontief(budget,basedemand,capa,cap)

[price,uti,iuti,xopt,demand] =  uncapLinearLeontief(budget,basedemand,capa,cap);
temp  = [uti cap'];
uti = min(temp')';
