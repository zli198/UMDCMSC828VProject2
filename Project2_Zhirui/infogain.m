function [IG] = infogain(M,y)
[n,~] = size(M);
i1 = find(y==-1);
i2 = find(y==1);
n1 = length(i1);
n2 = length(i2);
M = full(M);
Mfreq = sum(M,1)/n;
M1freq = sum(M(i1,:),1)/n1;
M2freq = sum(M(i2,:),1)/n2;
IG = abs(M1freq-M2freq).*Mfreq; % information gain
end