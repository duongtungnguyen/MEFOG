function uti = Leontief(x,a)
% x is a vector of allocated resources
% a is the vector of base demand
% for example, x = [3 4 6 2]; a = [1 2 0 4];
uti = min(x./a);

